program R6;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TMatrix = array of array of char;
  TDirection = (LEFT, UP, RIGHT, DOWN);
  TPoint = record
    x, y: Integer;
  end;
var
  operation: Boolean;
  inputStr, resultStr: String;
  matrix: TMatrix;

{ Функция, запрашивающая выбор действия }
function getOperation():Boolean;
var
  i: integer;
begin
  repeat
    writeln('Введите код операции');
    write('1 - Шифрование, 2 - Дешифрование: ');
    readln(i);
  until (i = 2) or (i = 1);
  if i = 1 then
    result := true
  else
    result := false;
end;

{ Функция, запращивающая ввод строки }
function getStr():String;
begin
  write('Введите строку: ');
  readln(result);
end;

{ Процедура, находящая и устанавливающая размеры матрицы }
procedure setMatrixLength(var matrix: TMatrix; const len: Integer);
var
  j, i: Integer;
begin
  j := 1;
  while sqr(j) < len do
    inc(j, 2);
  setLength(matrix, j);
  for i := 0 to j - 1 do
  begin
    setLength(matrix[i], j);
  end;
end;

{ Дополнение строки пробелами }
procedure setStrLength(var str: String; const len: Integer);
begin
  while length(str) < len do
    str := str + ' ';
end;

{ Изменение направления по часовой стрелке }
procedure changeDirection(var direction: TDirection);
begin
  if direction = DOWN then
    direction := LEFT
  else
    direction := succ(direction);
end;

{ Поиск следующей позиции по направлению }
procedure nextPosition(var position: TPoint; const direction: TDirection);
begin
  case direction of
    LEFT:
      position.x := position.x - 1;
    UP:
      position.y := position.y - 1;
    RIGHT:
      position.x := position.x + 1;
    DOWN:
      position.y := position.y + 1;
  end;
end;

{ Заполнение матрицы символами строки }
function strToMatrix(const operation: Boolean; str: String):TMatrix;
var
  i, j, k: Integer;
  direction: TDirection;
  position: TPoint;
  change: Boolean;
begin
  case operation of
    true:
    { Заполнение по строкам }
    begin
      setMatrixLength(result, length(str));
      setStrLength(str, sqr(length(result)));

      k := 1;
      for i := 0 to length(result) - 1 do
      begin
        for j := 0 to length(result) - 1 do
        begin
          result[i, j] := str[k];
          inc(k);
        end;
      end;
    end;
    false:
    { Заполнение по обратной спирали }
    begin
      setMatrixLength(result, length(str)-1);
      setStrLength(str, sqr(length(result)));

      { Указание начальной позиции }
      position.x := length(result) div 2;
      position.y := length(result) div 2;

      k := 0;
      j := 1;
      change := false;
      { Запоминаем направление из последнего символа строки }
      direction := TDirection(ord(str[length(str)])-48);
      delete(str, length(str), 1);

      { Записываем j символов 2 раза, потом увеличиваем j }
      while k < sqr(length(result)) do
      begin
        i := 1;
        while (i <= j) and (k <= sqr(length(result))) do
        begin
          inc(k);
          result[position.y, position.x] := str[k];
          nextPosition(position, direction);
          inc(i);
        end;
        changeDirection(direction);
        if change then
        begin
          inc(j);
          change := false;
        end
        else
          change := true;
      end;
    end;
  end;
end;

{ Чтение строки из матрицы }
function readFromMatrix(const operation: Boolean; const matrix: TMatrix):String;
var
  i, j, k: Integer;
  direction: TDirection;
  position: TPoint;
  change: Boolean;
  ch: Char;
begin              
  result := '';
  case operation of
    true:
    { Чтение по спирали }
    begin
                                    
      { Указание начальной позиции }
      position.x := length(matrix) div 2;
      position.y := length(matrix) div 2;
      k := 0;
      j := 1;
      change := false;
      randomize;

      { Выбор направления }
      direction := TDirection(random(4));
      ch := chr(ord(direction) + 48);

      { Считываем j символов 2 раза, потом увеличиваем j }
      while k < sqr(length(matrix)) do
      begin
        i := 1;
        while (i <= j) and (k <= sqr(length(matrix))) do
        begin
          result := result + matrix[position.y, position.x];
          nextPosition(position, direction);
          inc(i);
          inc(k);
        end;
        changeDirection(direction);
        if change then
        begin
          inc(j);
          change := false;
        end
        else
          change := true;
      end;
      { Добавляем в конец строки символ направления }
      result := result + ch;
    end;
    false:
    { Чтение по строкам }
    begin
      for i := 0 to length(matrix) - 1 do
      begin
        for j := 0 to length(matrix) - 1 do
        begin
          result := result + matrix[i, j];
        end;
      end;
    end;
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  
  operation := getOperation();
  inputStr := getStr();

  matrix := strToMatrix(operation, inputStr);
  resultStr := readFromMatrix(operation, matrix);

  writeln('Полученная строка: ', resultStr);
  readln;
end.
