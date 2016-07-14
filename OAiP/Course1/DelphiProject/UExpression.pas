unit UExpression;

interface

function infixToPostfix(expression: String):String;

function calculateInfix(expression: String; operands: String; var errors: Integer):Extended;

function check(expression: String; operands: String):Integer; overload;
function check(expression: String):Integer; overload;

implementation

uses
  SysUtils, UStack, Math, UTypes;

type
  TCommand = record
    longOpen: String;
    longClose: String;
    shortOpen: String;
    shortClose: String;
  end;                      
  TCommandArray = array [1..16] of TCommand;
  TOperand = record
    ID: String;
    value: Extended;
  end;
  TOperands = array of TOperand;

    { FORMAT PROCEDURE }

const
  CONSTANT_SYMBOLS: set of char = ['A'..'Z', '0'..'9', '.'];
  INFIX_COMMANDS: TCommandArray =
      ((longOpen: 'SIN(';  longClose: ')'; shortOpen: #1;  shortClose: #2),
       (longOpen: 'COS(';  longClose: ')'; shortOpen: #3;  shortClose: #4),
       (longOpen: 'TG(';   longClose: ')'; shortOpen: #5;  shortClose: #6),
       (longOpen: 'CTG(';  longClose: ')'; shortOpen: #7;  shortClose: #8),
       (longOpen: 'ASIN('; longClose: ')'; shortOpen: #9;  shortClose: #10),
       (longOpen: 'ACOS('; longClose: ')'; shortOpen: #11; shortClose: #12),
       (longOpen: 'ATG(';  longClose: ')'; shortOpen: #13; shortClose: #14),
       (longOpen: 'ACTG('; longClose: ')'; shortOpen: #15; shortClose: #16),
       (longOpen: 'LN(';   longClose: ')'; shortOpen: #17; shortClose: #18),
       (longOpen: 'LG(';   longClose: ')'; shortOpen: #19; shortClose: #20),
       (longOpen: 'LOG(';  longClose: ')'; shortOpen: #21; shortClose: #22),
       (longOpen: 'MOD';   longClose: '';  shortOpen: #25; shortClose: ''),
       (longOpen: 'DIV';   longClose: '';  shortOpen: #26; shortClose: ''),
       (longOpen: 'SQRT('; longClose: ')'; shortOpen: '('; shortClose: ')^(1/2)'),
       (longOpen: 'SQR(';  longClose: ')'; shortOpen: '('; shortClose: ')^2'),
       (longOpen: '|';     longClose: '|'; shortOpen: #23; shortClose: #24));

  POSTFIX_COMMANDS: TCommandArray =
      ((longOpen: ' SIN ';  longClose: ''; shortOpen: #1;  shortClose: ''),
       (longOpen: ' COS ';  longClose: ''; shortOpen: #3;  shortClose: ''),
       (longOpen: ' TG ';   longClose: ''; shortOpen: #5;  shortClose: ''),
       (longOpen: ' CTG ';  longClose: ''; shortOpen: #7;  shortClose: ''),
       (longOpen: ' ASIN '; longClose: ''; shortOpen: #9;  shortClose: ''),
       (longOpen: ' ACOS '; longClose: ''; shortOpen: #11; shortClose: ''),
       (longOpen: ' ATG ';  longClose: ''; shortOpen: #13; shortClose: ''),
       (longOpen: ' ACTG '; longClose: ''; shortOpen: #15; shortClose: ''),
       (longOpen: ' LN ';   longClose: ''; shortOpen: #17; shortClose: ''),
       (longOpen: ' LG ';   longClose: ''; shortOpen: #19; shortClose: ''),
       (longOpen: ' LOG ';  longClose: ''; shortOpen: #21; shortClose: ''),
       (longOpen: ' MOD ';  longClose: ''; shortOpen: #25; shortClose: ''),
       (longOpen: ' DIV ';  longClose: ''; shortOpen: #26; shortClose: ''),
       (longOpen: ' | ';    longClose: ''; shortOpen: #23; shortClose: ''),
       (longOpen: '';       longClose: ''; shortOpen: '';  shortClose: ''),
       (longOpen: '';       longClose: ''; shortOpen: '';  shortClose: ''));

{ Удаляет все пробелы в строке }
procedure deleteSpaces(var expression: String);
var
  i: Integer;
begin
  i := 1;
  while i <= length(expression) do
  begin
    if expression[i] = ' ' then
      delete(expression, i, 1)
    else
      inc(i);
  end;
end;

{ Добавляет ноль перед унарным минусом }
procedure unoMinus(var expression: String);
var
  i: Integer;
begin
  while expression[1] = ' ' do
    delete(expression, 1, 1);
  if (length(expression) > 0) and (expression[1] = '-') then
    insert('0', expression, 1);
  i := 1;
  while i < length(expression) do
  begin
    if ((expression[i] = '(') or (expression[i] = '|')) then
    begin
      while expression[i + 1] = ' ' do  
        delete(expression, i + 1, 1);
      if (expression[i + 1] = '-') then
        insert('0', expression, i + 1)
      else
        inc(i);
    end
    else
      inc(i);
  end;
end;

{ Удаляет пробелы перед открывающимися скобками }
procedure deformatExpression(var expression: String);
var
  i: Integer;
begin
  i := length(expression);
  while i > 0 do
  begin
    while (expression[i] <> '(') and (i > 0) do
      dec(i);
    dec(i);
    while (expression[i] = ' ') and (i > 1) do
    begin
      delete(expression, i, 1);
      dec(i);
    end;
  end;
  i := 1;
  while i < length(expression) do
  begin
    if (expression[i] = ' ') and (expression[i + 1] = ' ') then
      delete(expression, i, 1)
    else
      inc(i);
  end;
  if (length(expression) > 0) and (expression[1] = ' ') then
    delete(expression, 1, 1);
end;

{ Сравнивает две строки до длины второй }
function isEqual(strA: String; strB: String):Boolean;
var
  i: Integer;
begin
  result := true;
  for i := 1 to length(strB) do
    if strA[i] <> strB[i] then
      result := false;
end;

{ Ищет длинные команды и заменяет их короткими версиями }
procedure toShortCommands(var expression: String; commands: TCommandArray);
var
  subExpr: String;
  i, j, commandNumber, brackets: Integer;
begin
  i := 1;
  // При проходе по строке
  while i <= length(expression) do
  begin
    // Копирует 6 символов
    subExpr := copy(expression, i, 6);
    commandNumber := 0;
    j := 1;
    // Сравнивает их со всеми командами
    while (commandNumber = 0) and (j <= Length(commands)) do
    begin
      if (length(commands[j].longOpen) <> 0) and (isEqual(subExpr, commands[j].longOpen)) then
        commandNumber := j;
      inc(j);
    end;
    // Если совпало с командой
    if commandNumber <> 0 then
    begin
      // Удаляет длинную версию и добавляет короткую
      delete(expression, i, length(commands[commandNumber].longOpen));
      insert(' ' + commands[commandNumber].shortOpen + ' ', expression, i);

      // Если у команды есть конец, то ищет его, и заменяет на короткую версию
      if commands[commandNumber].longClose = ')' then
      begin
        j := i + 2;
        brackets := 1;
        while (j <= length(expression)) and (brackets <> 0) do
        begin
          if expression[j] = '(' then
            inc(brackets);
          if expression[j] = ')' then
            dec(brackets);
          inc(j);
        end;
        if brackets = 0 then
        begin
          delete(expression, j - 1, length(commands[commandNumber].longClose));
          insert(commands[commandNumber].shortClose, expression, j - 1);
        end;
      end;
      if commands[commandNumber].longClose = '|' then
      begin
        j := length(expression);
        while (expression[j] <> '|') and (j > 0) do
          dec(j);
        delete(expression, j, length(commands[commandNumber].longClose));
        insert(commands[commandNumber].shortClose, expression, j);
      end;
    end;
    inc(i);
  end;
end;

{ Заменяет кортокие команды на их длинные версии }
procedure toLongCommands(var expression: String; commands: TCommandArray);
var
  i, j: Integer;
begin
  i := 1;
  while i <= length(expression) do
  begin
    j := 1;
    while (j <= Length(commands)) do
    begin
      if length(commands[j].shortOpen) <> 0 then
      if expression[i] = commands[j].shortOpen then
      begin
        delete(expression, i, 1);
        insert(' ' + commands[j].longOpen + ' ', expression, i);
      end;
      inc(j);
    end;
    inc(i);
  end;
end;

{ Преобразует операнды из строки в массив }
function convertOperands(operands: String):TOperands;
var
  i, j: Integer;
begin
  DecimalSeparator := '.';
  SetLength(result, 2);
  result[0].ID := 'PI';
  result[0].value := Pi; 
  result[1].ID := 'E';
  result[1].value := exp(1);
  operands := UpperCase(operands);
  deleteSpaces(operands);
  i := 1;
  while i <= length(operands) do
  begin
    SetLength(result, length(result) + 1);
    j := i;
    while (operands[i] in CONSTANT_SYMBOLS) do
      inc(i);
    result[length(result) - 1].ID := copy(operands, j, i - j);
    inc(i);
    j := i;
    while (operands[i] in ['-', '0'..'9', '.']) do
      inc(i);
    result[length(result) - 1].value := StrToFloat(copy(operands, j, i - j));
    inc(i);
  end;
end;

    { OPERANDS PROCEDURE }

{ Ищет операнд в массиве }
function findOperand(str: String; operands: TOperands):Extended;
var
  i: Integer;
begin
  result := NaN;
  for i := 0 to length(operands) - 1 do
  begin
    if operands[i].ID = str then
      result := operands[i].value;
  end;
end;

{ Получает число из массива или строки }
function operandToNumber(str: String; operands: TOperands):Extended;
begin
  DecimalSeparator := '.';
  if str[1] in ['A'..'Z'] then
    result := findOperand(str, operands)
  else
    result := StrToFloat(str);
end;

    { CONVERTION PROCEDURE }

{ Получает приоритет символа в строке }
function getStringPriority(elem: Char):Integer;
begin
  case elem of
    '+', '-':
      result := 1;
    '*', '/', #25, #26:
      result := 3;
    '^':
      result := 6;
    '(', #1, #3, #5,
    #7, #9, #11, #13,
    #15, #17, #19, #21,
    #23:
      result := 9;
    ')', #2, #4, #6,
    #8, #10, #12, #14,
    #16, #18, #20, #22,
    #24:
      result := 0;
    else
      result := -1;
  end;
end;

{ Получает приоритет символа в стеке }
function getStackPriority(elem: TElem):Integer;
begin
  if elem.isOperand then
    result := 8
  else
  begin
    case elem.operation of
      '+', '-':
        result := 2;
      '*', '/', #25, #26:
        result := 4;
      '^':
        result := 5;
      '(', #1, #3, #5,
      #7, #9, #11, #13,
      #15, #17, #19, #21,
      #23:
        result := 0;
      else
        result := -1;
    end;
  end;
end;

{ Преобразует инфиксное выражение в постфиксоное }
function convertToPostfix(expression: String):String;
var
  i, j: Integer;
  stack: TStack;
begin
  createStack(stack);
  result := '';
  i := 1;
  while (i <= length(expression)) do
  begin
    case expression[i] of
      '+', '-', '*', '/',
      #25, #26, '^', '(',
      #1, #3, #5, #7,
      #9, #11, #13, #15,
      #17, #19, #21, #23:
      begin
        while (not isEmpty(stack)) and
              (getStackPriority(viewTop(stack)) >=
              getStringPriority(expression[i])) do
          result := result + elemToString(pop(stack));
        push(stack, expression[i]);
      end;
      ')', #2, #4, #6,
      #8, #10, #12, #14,
      #16, #18, #20, #22,
      #24:
      begin
        while (not isEmpty(stack)) and
              ((viewTop(stack).isOperand) or
              (viewTop(stack).operation <>
              pred(expression[i]))) do
          result := result + elemToString(pop(stack));
        if (not isEmpty(stack)) and (viewTop(stack).operation <> '(') then
          result := result + elemToString(pop(stack))
        else
          if not isEmpty(stack) then
            pop(stack);
        // Переносит ! вместе с закрывающейся скобкой
        if (i < length(expression)) and (expression[i+1] = '!') then
          result := result + '!';
      end;
      'A'..'Z', '0'..'9', '.':
      begin
        j := i;
        while (expression[i] in CONSTANT_SYMBOLS) and
              (i <= length(expression)) do
          inc(i);
        // Преносит ! вместе с предыдущим операндом
        if (i <= length(expression)) and (expression[i] = '!') then
          inc(i);
        push(stack, ' ' + copy(expression, j, i - j) + ' ');
        dec(i);
      end;
    end;
    inc(i);
  end;
  // Добавляет остаточное содержимое стека в результат
  while not isEmpty(stack) do
    result := result + elemToString(pop(stack));
  destroyStack(stack);
end;

{ Преобразует длинное инфиксное выражение в длинное постфиксное }
function infixToPostfix(expression: String):String;
begin
  expression := UpperCase(expression);
  deformatExpression(expression);
  unoMinus(expression);
  toShortCommands(expression, INFIX_COMMANDS);
  expression := convertToPostfix(expression);
  toLongCommands(expression, POSTFIX_COMMANDS);
  deformatExpression(expression);
  result := expression;
end;       

    { CHECK EXPRESSION PROCEDURE }

{ Проверяет ранг выражения }
function checkRank(expression: String; var mnemoText: String):Boolean;
var
  rank, i: Integer;
begin
  rank := 0;
  i := 1;
  mnemoText := '';
  while i <= length(expression) do
  begin
    case expression[i] of
      #25, #26, '+', '-', '*', '/', '^':
      begin
        dec(rank);
        mnemoText := mnemoText + '1';
      end;
      'A'..'Z':
      begin
        while (expression[i] in CONSTANT_SYMBOLS) and
              (i <= length(expression)) do
          inc(i);
        inc(rank);
        dec(i);
        mnemoText := mnemoText + '0';
      end;
      '0'..'9':
      begin
        while (expression[i] in ['0'..'9', '.']) and
              (i <= length(expression)) do
          inc(i);
        inc(rank);
        dec(i);        
        mnemoText := mnemoText + '0';
      end;
    end;
    inc(i);
  end;
  result := rank <> 1;
end;

{ Проверяет порядок следования операций }
function checkMnemoText(mnemoText: String):Boolean;
var
  i: Integer;
begin
  result := false;
  for i := 1 to length(mnemoText) - 1 do
    result := result or (mnemoText[i] = mnemoText[i + 1]);
end;

{ Проверяет скобки в выражении }
function checkBrackets(expression: String):Boolean;
var
  brackets, i: Integer;
begin
  brackets := 0;
  result := false;
  for i := 1 to length(expression) do
  begin
    if expression[i] = '(' then
      inc(brackets);
    if expression[i] = ')' then
      dec(brackets);
    result := result or (brackets < 0);
  end;
  result := result or (brackets <> 0);
end;

{ Проверяет формат операндов }
function checkOperandsFormat(operands: String):Boolean;
var
  i: Integer;
begin
  operands := UpperCase(operands);
  result := false;
  i := 1;
  while (i <= length(operands)) and not result do
  begin
    if not (operands[i] in ['A'..'Z']) then
      result := true
    else
    begin
      while ((operands[i] in ['A'..'Z']) or
            (operands[i] in ['0'..'9'])) and
            (i <= length(operands)) do
        inc(i);
      while (operands[i] = ' ') do
        inc(i);
      if operands[i] <> '=' then
        result := true
      else
      begin
        inc(i);
        while (operands[i] = ' ') do
          inc(i);
        if operands[i] = '-' then
          inc(i);
        while ((operands[i] in ['0'..'9']) or
              (operands[i] = '.')) and
              (i <= length(operands)) do
          inc(i);
        while (operands[i] = ' ') do
          inc(i);
        if i <= length(operands) then
          if operands[i] <> ',' then
            result := true
          else
          begin
            inc(i);
            while (operands[i] = ' ') do
              inc(i);
          end;
      end;
    end;
  end;
end;

{ Проверяет наличие нужных операндов }
function checkOperands(expression: String; operands: String):Boolean;
var
  i, j: Integer;
  operandsArray: TOperands;
begin
  operandsArray := convertOperands(operands);
  i := 1;
  result := false;
  while (i <= length(expression)) do
  begin
    if expression[i] in ['A'..'Z'] then
    begin
      j := i;
      while (expression[i] in CONSTANT_SYMBOLS) and
            (i <= length(expression)) do
        inc(i);
      result := result or isNaN(findOperand(copy(expression, j, i - j), operandsArray));
      dec(i);
    end;
    inc(i);
  end
end;

{ Проверяет выражение }
function check(expression, operands: String):Integer; overload;
var
  mnemoText: String;
begin
  result := 0;
  expression := UpperCase(expression);
  deformatExpression(expression);
  if expression = '' then
    result := errRANK
  else
  begin
    unoMinus(expression);
    if checkBrackets(expression) then
      result := result or errBRACKETS;
    toShortCommands(expression, INFIX_COMMANDS);
    if checkRank(expression, mnemoText) then
      result := result or errRANK;
    if checkMnemoText(mnemoText) then
      result := result or errRANK;
    if checkOperandsFormat(operands) then
      result := result or errBAD_OPERANDS
    else
    begin
      if checkOperands(expression, operands) then
        result := result or errNOT_ENOUGH_OPERANDS;
    end;
  end;
end;


{ Проверяет выражение }
function check(expression: String):Integer; overload;    
var
  mnemoText: String;
begin
  result := 0;
  expression := UpperCase(expression);
  deformatExpression(expression);
  if expression = '' then
    result := errRANK
  else
  begin         
    unoMinus(expression);
    if checkBrackets(expression) then
      result := result or errBRACKETS;
    toShortCommands(expression, INFIX_COMMANDS);
    if checkRank(expression, mnemoText) then
      result := result or errRANK;
    if checkMnemoText(mnemoText) then
      result := result or errRANK;
  end;
end;

    { CALCULATION PROCEDURE }

{ Вычисляет короткое постфиксное выражение }
function calculate(expression: String; operands: TOperands; var errors: Integer):Extended;
var
  stack: TStack;
  i, j, k: Integer;
  a, b, temp: Extended;
  strA, strB: String;
begin
  createStack(stack);
  expression := UpperCase(expression);
  deformatExpression(expression);
  i := 1;
  while i <= length(expression) do
  begin
    if expression[i] in CONSTANT_SYMBOLS then
    begin
      j := i;
      while expression[i] in CONSTANT_SYMBOLS do
        inc(i);
      push(stack, copy(expression, j, i - j));
      dec(i);
    end
    else
    begin
      try
      {$I 'commands_calculate.inc'}
      except
        i := length(expression) + 1;
        errors := errors or errRANK;
        push(stack, '1 ');
      end;
    end;
    inc(i);
  end;
  try
    result := operandToNumber(pop(stack).operand, operands);
  except
    result := NaN;
    errors := errors or errRank;
  end;
  destroyStack(stack);
end;

{ Вычисляет длинное инфиксное выражение }
function calculateInfix(expression: String; operands: String; var errors: Integer):Extended;
begin
  expression := UpperCase(expression);
  deformatExpression(expression);
  unoMinus(expression);
  toShortCommands(expression, INFIX_COMMANDS);
  expression := convertToPostfix(expression);
  result := calculate(expression, convertOperands(operands), errors);
  if errors <> 0 then
    result := NaN;
end;

end.
