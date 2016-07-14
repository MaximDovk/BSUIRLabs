unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, ActnList, Grids, UTypes,
  XPStyleActnCtrls, ActnMan, Menus;

type
  TfrmMain = class(TForm)
    alMain: TActionList;
    aCalculate: TAction;
    aUndo: TAction;
    aOpenFile: TAction;
    openDialog: TOpenDialog;
    pcTabs: TPageControl;
    tabSimple: TTabSheet;
    tabBit: TTabSheet;
    tabExpression: TTabSheet;

    { Компоненты вкладки tabExpression }
    eeditExpression: TEdit;
    eeditOperands: TEdit;
    eeditResult: TEdit;
    ebtnOpen: TButton;
    ebtnCalculate: TButton;
    ebtnPi: TButton;
    ebtnEuler: TButton;
    ebtnY: TButton;
    ebtnX: TButton;
    ebtnSin: TButton;
    ebtnCos: TButton;
    ebtnTg: TButton;
    ebtnCtg: TButton;
    ebtnAsin: TButton;
    ebtnAcos: TButton;
    ebtnAtg: TButton;
    ebtnActg: TButton;
    ebtnLog: TButton;
    ebtnLg: TButton;
    ebtnLn: TButton;
    ebtnAbs: TButton;
    ebtnMod: TButton;
    ebtnDiv: TButton;
    ebtnFact: TButton;
    ebtnPower: TButton;
    ebtnMul: TButton;
    ebtnDivision: TButton;
    ebtnAdd: TButton;
    ebtnSub: TButton;
    ebevSplitter1: TBevel;
    ebevSplitter2: TBevel;
    ebevSplitter3: TBevel;
    ebevSplitter4: TBevel;
    ebevSplitter5: TBevel;
    ebtnDot: TButton;
    ebtn0: TButton;
    ebtn1: TButton;
    ebtn2: TButton;
    ebtn3: TButton;  
    ebtn4: TButton;
    ebtn5: TButton;  
    ebtn6: TButton; 
    ebtn7: TButton;
    ebtn8: TButton;
    ebtn9: TButton;
    ebtnC: TButton;
    ebtnLBracket: TButton;
    ebtnRBracket: TButton;

    { Компоненты вкладки tabBit }
    bpanelOutput: TPanel;
    panelCountSystemLabel: TPanel;
    panelOperand: TPanel;
    blabelH: TLabel;
    blabelD: TLabel;
    blabelO: TLabel;
    blabelB: TLabel;    
    beditH: TStaticText;
    beditD: TStaticText;
    beditO: TStaticText;
    beditB: TStaticText;
    bbtn0: TSpeedButton;
    bbtn1: TSpeedButton;
    bbtn2: TSpeedButton;
    bbtn3: TSpeedButton;  
    bbtn4: TSpeedButton;
    bbtn5: TSpeedButton;
    bbtn6: TSpeedButton; 
    bbtn7: TSpeedButton;
    bbtn8: TSpeedButton;
    bbtn9: TSpeedButton;
    bbtnA: TSpeedButton;  
    bbtnB: TSpeedButton;
    bbtnC: TSpeedButton;  
    bbtnD: TSpeedButton; 
    bbtnE: TSpeedButton;
    bbtnF: TSpeedButton;
    bbtnClear: TSpeedButton;
    bbtnBackspace: TSpeedButton;

    { Компоненты вкладки tabSimple }
    panelExtended: TPanel;
    panelHistory: TPanel;
    panelMain: TPanel;
    labelLeftArrow: TLabel;
    labelRightArrow: TLabel;
    aClearNumber: TAction;
    panelMainNoArrows: TPanel;
    panelOutput: TPanel;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btnMul: TSpeedButton;
    btnSub: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btnAdd: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btnEqual: TSpeedButton;
    btn0: TSpeedButton;
    btnChangeSign: TSpeedButton;
    btnDot: TSpeedButton;
    btnDiv: TSpeedButton;
    btnCE: TSpeedButton;
    btnC: TSpeedButton;
    btnBackspace: TSpeedButton;
    btnEuler: TSpeedButton;
    btnPi: TSpeedButton;
    btnSqr: TSpeedButton;
    btnXPowerY: TSpeedButton;
    btnSqrt: TSpeedButton;
    btnXRootY: TSpeedButton;
    btnLn: TSpeedButton;
    btn1DivX: TSpeedButton;
    btnLog: TSpeedButton;
    btnLg: TSpeedButton;
    btnCos: TSpeedButton;
    btnSin: TSpeedButton;
    lvHistory: TListView;
    panelHistoryTitle: TPanel;
    labelHistory: TLabel;
    labelHistoryClear: TSpeedButton;
    sgOutput: TStringGrid;
    procedure eeditOperandsEnter(Sender: TObject);
    procedure eeditOperandsExit(Sender: TObject);
    procedure eeditExpressionEnter(Sender: TObject);
    procedure eeditExpressionExit(Sender: TObject);
    procedure ebtnPiClick(Sender: TObject);
    procedure ebtnEulerClick(Sender: TObject);
    procedure ebtnYClick(Sender: TObject);
    procedure ebtnXClick(Sender: TObject);
    procedure ebtnSinClick(Sender: TObject);
    procedure ebtnCosClick(Sender: TObject);
    procedure ebtnTgClick(Sender: TObject);
    procedure ebtnCtgClick(Sender: TObject);
    procedure ebtnAsinClick(Sender: TObject);
    procedure ebtnAcosClick(Sender: TObject);
    procedure ebtnAtgClick(Sender: TObject);
    procedure ebtnActgClick(Sender: TObject);
    procedure ebtnLogClick(Sender: TObject);
    procedure ebtnLgClick(Sender: TObject);
    procedure ebtnLnClick(Sender: TObject);
    procedure ebtnAbsClick(Sender: TObject);
    procedure ebtnModClick(Sender: TObject);
    procedure ebtnDivClick(Sender: TObject);
    procedure ebtnFactClick(Sender: TObject);
    procedure ebtnPowerClick(Sender: TObject);
    procedure ebtnCalculateKeyPress(Sender: TObject; var Key: Char);
    procedure eeditExpressionKeyPress(Sender: TObject; var Key: Char);
    procedure ebtnMulClick(Sender: TObject);
    procedure ebtnDivisionClick(Sender: TObject);
    procedure ebtnAddClick(Sender: TObject);
    procedure ebtnSubClick(Sender: TObject);
    procedure eeditResultEnter(Sender: TObject);
    procedure aCalculateExecute(Sender: TObject);
    procedure eeditOperandsKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure aUndoExecute(Sender: TObject);
    procedure aOpenFileExecute(Sender: TObject);
    procedure ebtn1Click(Sender: TObject);
    procedure ebtn2Click(Sender: TObject);
    procedure ebtn3Click(Sender: TObject);
    procedure ebtn0Click(Sender: TObject);
    procedure ebtn4Click(Sender: TObject);
    procedure ebtn5Click(Sender: TObject);
    procedure ebtn6Click(Sender: TObject);
    procedure ebtn7Click(Sender: TObject);
    procedure ebtn8Click(Sender: TObject);
    procedure ebtn9Click(Sender: TObject);
    procedure ebtnDotClick(Sender: TObject);
    procedure ebtnLBracketClick(Sender: TObject);
    procedure ebtnRBracketClick(Sender: TObject);
    procedure ebtnCClick(Sender: TObject);
    procedure bbtn0Click(Sender: TObject);
    procedure bbtn1Click(Sender: TObject);
    procedure beditHClick(Sender: TObject);
    procedure beditDClick(Sender: TObject);
    procedure beditOClick(Sender: TObject);
    procedure beditBClick(Sender: TObject);
    procedure bbtnBackspaceClick(Sender: TObject);
    procedure bbtn2Click(Sender: TObject);
    procedure bbtn3Click(Sender: TObject);
    procedure bbtn4Click(Sender: TObject);
    procedure bbtn5Click(Sender: TObject);
    procedure bbtn6Click(Sender: TObject);
    procedure bbtn7Click(Sender: TObject);
    procedure bbtn8Click(Sender: TObject);
    procedure bbtn9Click(Sender: TObject);
    procedure bbtnAClick(Sender: TObject);
    procedure bbtnBClick(Sender: TObject);
    procedure bbtnCClick(Sender: TObject);
    procedure bbtnDClick(Sender: TObject);
    procedure bbtnEClick(Sender: TObject);
    procedure bbtnFClick(Sender: TObject);
    procedure pcTabsChange(Sender: TObject);
    procedure labelLeftArrowClick(Sender: TObject);
    procedure labelRightArrowClick(Sender: TObject);
    procedure btnEulerClick(Sender: TObject);
    procedure btnPiClick(Sender: TObject);
    procedure btnXPowerYClick(Sender: TObject);
    procedure btnSqrClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEqualClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure btnMulClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnCClick(Sender: TObject);
    procedure btnCEClick(Sender: TObject);
    procedure btnBackspaceClick(Sender: TObject);
    procedure btnChangeSignClick(Sender: TObject);
    procedure btnDotClick(Sender: TObject);
    procedure btnXRootYClick(Sender: TObject);
    procedure btnSqrtClick(Sender: TObject);
    procedure btnLnClick(Sender: TObject);
    procedure btn1DivXClick(Sender: TObject);
    procedure btnLgClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnSinClick(Sender: TObject);
    procedure btnCosClick(Sender: TObject);
    procedure aClearNumberExecute(Sender: TObject);
    procedure btnClearHistoryClick(Sender: TObject);
    procedure lvHistorySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lvHistoryEnter(Sender: TObject);
    procedure sgOutputEnter(Sender: TObject);
    procedure sgOutputDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure eeditExpressionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
      { Переменные для вкладки tabExpression }
    { Введённое пользователем выражение }
    FExpression: String;
    { Массив ошибок в выражении }
    FErrors: TErrorsArray;
    { Последней нажата кнопка/клавиша/backspace }
    FLastText: TLastButton;
    { История ввода выражения }
    FHistory: array of TLocalHistory;
                        
      { Переменные для вкладки tabBit }
    { Выделенная система счисления }
    FSelectedCountSystem: TCountSystem;
    { Введённое число }
    FNumber: TNumber;
    { Клавиши на вкладке tabBit }
    FButtons: array [1..16] of TSpeedButton;
    { Поля вывода на вкладке tabBit }
    FLabels: array [1..4] of TStaticText;

      { Переменные для вкладки tabSimple }
    { Определяет открыта ли расширенная панель }
    FExtPanelOpen: Boolean;
    { Определяет открыта ли вкладка истории }
    FHistPanelOpen: Boolean;
    { Массив, в котором хранится выведенная история }
    FHistoryArray: THistoryArray;
    { Текущая выполняемая операция }
    FBinOperation: TCalcOperation;
    { Первый операнд }
    FFirstOperand: String;
    { Второй операнд }
    FSecondOperand: String;

    procedure setExpression(expression: String);
    procedure selectCountSystem(countSystem: TCountSystem);
    procedure setExtPanelOpen(isOpen: Boolean);
    procedure setHistPanelOpen(isOpen: Boolean);
    procedure setFirstOperand(value: String);
    procedure setSecondOperand(value: String);

    { При изменении выводит выражение в eeditExpression }
    property PExpression: String read FExpression write setExpression;
    { При изменении системы счисления отключает клавиши и выделяет поле }
    property PSelectedCountSystem: TCountSystem read FSelectedCountSystem write selectCountSystem;
    { При изменении открывает/закрывает расширенную панель }
    property PExtPanelOpen: Boolean read FExtPanelOpen write setExtPanelOpen;
    { При изменении открывает/закрывает вкладку истории }
    property PHistPanelOpen: Boolean read FHistPanelOpen write setHistPanelOpen;
    { При изменении выводит операнд }
    property PFirstOperand: String read FFirstOperand write setFirstOperand;
    { При изменении выводит операнд }
    property PSecondOperand: String read FSecondOperand write setSecondOperand;

      { Процедуры вкладки tabExpression }
    { Очищает все поля вкладки }
    procedure clearExpressionTab;
    { Сохраняет текущее состояние PExpression в историю }
    procedure saveToHistory(new: Boolean);
    { Удаляет символ из PExpression }
    procedure expressionBackPress();
    procedure expressionDeletePress();
    { Добавляет note в PExpression и сохраняет в историю }
    procedure btnClick(note: String; shift: Integer; history: Boolean);
    { Добавляет символ в PExpression }
    procedure expressionKeyPress(key: Char);

      { Процедуры вкладки tabBit }
    { Очищает вкладку конвертера }
    procedure clearBitTab;
    { Сохраняет в массивы указатели на клавиши и поля }
    procedure setButtons();
    procedure setLabels();
    { Выводит число в поля вкладки }
    procedure outputNumber(number: TNumber);
    { Добавляет к числу символ }
    procedure bitKeyPress(key: Char);
    { Удаляет последний символ в числе }
    procedure bitBackPress();
    { Сравнивает две строки }
    function greater(strA, strB: String):Boolean;
    { Отключает кнопки, недоступные для этой системы счисления }
    procedure disableButtons(countSystem: TCountSystem);
    { Подсвечивает выбранную систему счисления }
    procedure highlightLabel(countSystem: TCountSystem);
                       
      { Процедуры вкладки tabSimple } 
    { Очищает вкладку простого калькулятора }
    procedure clearSimpleTab;
    { Устанавливает ширину окна }
    procedure setWindowWidth();
    { Преобразует строку с числом в понятный пользователю вид }
    function formatString(str: String):String;
    { Вызывает процедуру вычисления, если была выбрана другая операция }
    procedure operationBtnClick(operation: TCalcOperation);
    { Добавляет цифру к операнду }
    procedure digitBtnClick(digit: Char);
    { Вызывает процедуру вычисления }
    procedure calculateBtnClick();
    { Добавляет точку к операнду }
    procedure dotBtnClick();
    { Вычисляет значение операции }
    function executeOperation(operation: TCalcOperation):String;
    { Выводит историю }
    procedure outputHistory();
  public
    { Путь к выбранному файлу }
    openedFile: String;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  UExpression, UTextForm, Math, UHistory, UCountSystems;

resourcestring
  { Подсказки для полей ввода }
  sEXPRESSION = 'Выражение';
  sOPERANDS = 'Операнды';
  sRESULT = 'Результат';         

const
  { Максимальные числа для ввода }
  MAX_HEX = '7FFFFFFFFFFFFFFF';
  MAX_DEC = '9223372036854775807';
  MAX_OCT = '777777777777777777777';
  MAX_BIN = '111111111111111111111111111111111111111111111111111111111111111';

  { Ширина панелей на вкладке tabSimple }
  EXT_WIDTH = 153;
  MAIN_WIDTH = 242;
  HIST_WIDTH = 250;

{$R *.dfm}

{ При выделении поля, удаляет подсказку, если она выведена }
procedure TfrmMain.eeditOperandsEnter(Sender: TObject);
begin
  if eeditOperands.Text = sOPERANDS then
    eeditOperands.Text := '';
end;

procedure TfrmMain.eeditExpressionEnter(Sender: TObject);
begin
  if eeditExpression.Text = sEXPRESSION then
    eeditExpression.Text := '';
end;

{ При выходе из поля, выводит подсказку }
procedure TfrmMain.eeditOperandsExit(Sender: TObject);
begin
  if eeditOperands.Text = '' then
    eeditOperands.Text := sOPERANDS;
end;

procedure TfrmMain.eeditExpressionExit(Sender: TObject);
begin
  if eeditExpression.Text = '' then
    eeditExpression.Text := sEXPRESSION;
end;                    

{ При изменении PExpression выводит его в eeditExpression }
procedure TfrmMain.setExpression(expression: String);
begin
  eeditExpression.Text := expression;
  FExpression := expression;
end;        

{ Сохраняет текущее состояние в историю }
{ Если new = true, то сохраняет в новую ячейку истории }
procedure TfrmMain.saveToHistory(new: Boolean);
begin
  if new then
    SetLength(FHistory, length(FHistory) + 1);
  FHistory[length(FHistory) - 1].textShot := PExpression;
  FHistory[length(FHistory) - 1].selStartShot := eeditExpression.SelStart;
end;

{ Удаляет символ из PExpression, сдвигает указатель на символ влево }
procedure TfrmMain.expressionBackPress;
var
  tempStr: String;
  selStart: Integer;
begin
  tempStr := PExpression;
  selStart := eeditExpression.SelStart;

  if eeditExpression.SelLength <> 0 then
    delete(tempStr, selStart + 1, eeditExpression.SelLength)
  else
  begin
    delete(tempStr, selStart, 1);
    dec(selStart);
  end;

  PExpression := tempStr;
  eeditExpression.SelStart := selStart;
end; 

procedure TfrmMain.expressionDeletePress;
var
  tempStr: String;
  selStart: Integer;
begin
  tempStr := PExpression;
  selStart := eeditExpression.SelStart;

  if eeditExpression.SelLength <> 0 then
    delete(tempStr, selStart + 1, eeditExpression.SelLength)
  else
  begin
    delete(tempStr, selStart + 1, 1);
  end;

  PExpression := tempStr;
  eeditExpression.SelStart := selStart;
end;

{ Добавляет note в PExpression, сдвигает указатель на shift символов }
{ Сохраняет в историю, если history = true }
procedure TfrmMain.btnClick(note: String; shift: Integer; history: Boolean);
var
  tempStr: String;
  selStart: Integer;
begin                
  eeditExpression.SetFocus;
  tempStr := PExpression;
  selStart := eeditExpression.SelStart;

  if eeditExpression.SelLength <> 0 then
    delete(tempStr, selStart + 1, eeditExpression.SelLength);
  insert(note, tempStr, selStart + 1);

  PExpression := tempStr;
  eeditExpression.SelStart := selStart + shift;
  if history then
  begin          
    saveToHistory(true);
    FLastText := lbBUTTON;
  end;
end;

{ Добавляет символ в PExpression }
{ Если key - цифра, буква, точка или backspace
  то сохраняет в историю }
procedure TfrmMain.expressionKeyPress(key: Char);
begin
  case key of
    #13:
      aCalculate.Execute;
    '*':
      btnClick(' * ', 3, true);
    '/':
      btnClick(' / ', 3, true);
    '+':
      btnClick(' + ', 3, true);
    '-':
      btnClick(' - ', 3, true);
    '^':
      btnClick(' ^ ', 3, true);
    '|':
      btnClick('||', 1, true);
    '!':    
      btnClick('!', 1, true);
    '(':
      btnClick('(', 1, true);
    ')':
      btnClick(')', 1, true);
    ' ':
    begin                    
      btnClick(key, 1, false);
      if (FLastText = lbTEXT) then
      begin
        saveToHistory(false);
        FLastText := lbBUTTON;
      end;
    end;  
    'a'..'z', 'A'..'Z', '0'..'9', '.':
    begin
      btnClick(key, 1, false);
      saveToHistory(FLastText <> lbTEXT);
      FLastText := lbTEXT;
    end;  
    #8:
    begin
      expressionBackPress;
      saveToHistory(FLastText <> lbBACK);
      FLastText := lbBACK;
    end;
  end;
end;

{ Вызывается при нажатии Ctrl + Z }
{ Если история не пуста, то возвращает состояние }
procedure TfrmMain.aUndoExecute(Sender: TObject);
begin
  if (pcTabs.ActivePageIndex = 2) then
  begin
    if length(FHistory) > 1 then
      SetLength(FHistory, length(FHistory) - 1);
    if length(FHistory) > 0 then
    begin
      PExpression := FHistory[length(FHistory) - 1].textShot;
      eeditExpression.SelStart := FHistory[length(FHistory) - 1].selStartShot;
      FLastText := lbBUTTON;
    end;
  end;
end;

  { Обработчики нажатия кнопок
    Добавляют текст в PExpression,
    сохраняют состояние в историю }
procedure TfrmMain.ebtnPiClick(Sender: TObject);
begin
  btnClick('Pi', 2, true);
end;

procedure TfrmMain.ebtnEulerClick(Sender: TObject);
begin
  btnClick('e', 1, true);
end;

procedure TfrmMain.ebtnYClick(Sender: TObject);
begin
  btnClick('y', 1, true);
end;

procedure TfrmMain.ebtnXClick(Sender: TObject);
begin
  btnClick('x', 1, true);
end;

procedure TfrmMain.ebtnSinClick(Sender: TObject);
begin
  btnClick('sin()', 4, true);
end;

procedure TfrmMain.ebtnCosClick(Sender: TObject);
begin
  btnClick('cos()', 4, true);
end;

procedure TfrmMain.ebtnTgClick(Sender: TObject);
begin
  btnClick('tg()', 3, true);
end;

procedure TfrmMain.ebtnCtgClick(Sender: TObject);
begin
  btnClick('ctg()', 4, true);
end;

procedure TfrmMain.ebtnAsinClick(Sender: TObject);
begin
  btnClick('asin()', 5, true);
end;

procedure TfrmMain.ebtnAcosClick(Sender: TObject);
begin
  btnClick('acos()', 5, true);
end;

procedure TfrmMain.ebtnAtgClick(Sender: TObject);
begin
  btnClick('atg()', 4, true);
end;

procedure TfrmMain.ebtnActgClick(Sender: TObject);
begin
  btnClick('actg()', 5, true);
end;

procedure TfrmMain.ebtnLogClick(Sender: TObject);
begin
  btnClick('log()', 4, true);
end;

procedure TfrmMain.ebtnLgClick(Sender: TObject);
begin
  btnClick('lg()', 3, true);
end;

procedure TfrmMain.ebtnLnClick(Sender: TObject);
begin
  btnClick('ln()', 3, true);
end;

procedure TfrmMain.ebtnAbsClick(Sender: TObject);
begin
  btnClick('||', 1, true);
end;

procedure TfrmMain.ebtnModClick(Sender: TObject);
begin
  btnClick(' mod ', 5, true);
end;

procedure TfrmMain.ebtnDivClick(Sender: TObject);
begin
  btnClick(' div ', 5, true);
end;

procedure TfrmMain.ebtnFactClick(Sender: TObject);
begin
  btnClick('!', 1, true);
end;

procedure TfrmMain.ebtnPowerClick(Sender: TObject);
begin
  btnClick(' ^ ', 3, true);
end;          

procedure TfrmMain.ebtnMulClick(Sender: TObject);
begin
  btnClick(' * ', 3, true);
end;

procedure TfrmMain.ebtnDivisionClick(Sender: TObject);
begin
  btnClick(' / ', 3, true);
end;

procedure TfrmMain.ebtnAddClick(Sender: TObject);
begin
  btnClick(' + ', 3, true);
end;

procedure TfrmMain.ebtnSubClick(Sender: TObject);
begin
  btnClick(' - ', 3, true);
end;

  { Обработчики нажатия цифровых кнопок
    Добавляют символ в PExpression,
    сохраняют состояние в историю }
procedure TfrmMain.ebtn0Click(Sender: TObject);
begin
  expressionKeyPress('0');
end;

procedure TfrmMain.ebtn1Click(Sender: TObject);
begin
  expressionKeyPress('1');
end;

procedure TfrmMain.ebtn2Click(Sender: TObject);
begin
  expressionKeyPress('2');
end;

procedure TfrmMain.ebtn3Click(Sender: TObject);
begin
  expressionKeyPress('3');
end;

procedure TfrmMain.ebtn4Click(Sender: TObject);
begin
  expressionKeyPress('4');
end;

procedure TfrmMain.ebtn5Click(Sender: TObject);
begin
  expressionKeyPress('5');
end;

procedure TfrmMain.ebtn6Click(Sender: TObject);
begin
  expressionKeyPress('6');
end;

procedure TfrmMain.ebtn7Click(Sender: TObject);
begin
  expressionKeyPress('7');
end;

procedure TfrmMain.ebtn8Click(Sender: TObject);
begin
  expressionKeyPress('8');
end;

procedure TfrmMain.ebtn9Click(Sender: TObject);
begin
  expressionKeyPress('9');
end;

procedure TfrmMain.ebtnDotClick(Sender: TObject);
begin
  expressionKeyPress('.');
end;

procedure TfrmMain.ebtnLBracketClick(Sender: TObject);
begin
  expressionKeyPress('(');
end;

procedure TfrmMain.ebtnRBracketClick(Sender: TObject);
begin
  expressionKeyPress(')');
end;

{ Обработчик нажатия клавиш,
  если выделена кнопка "Вычислить",
  если выделено поле eeditExpression }
procedure TfrmMain.ebtnCalculateKeyPress(Sender: TObject; var Key: Char);
begin
  expressionKeyPress(key);
  key := #0;
end;

procedure TfrmMain.eeditExpressionKeyPress(Sender: TObject; var Key: Char);
begin
  expressionKeyPress(key);
  key := #0;
end;     

procedure TfrmMain.eeditExpressionKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 46 then
  begin
    key := 0;
    expressionDeletePress;
    saveToHistory(FLastText <> lbBACK);
    FLastText := lbBACK;
  end;
end;


{ Обработчик нажатия клавиш,
  если выделено поле eeditOperands }
procedure TfrmMain.eeditOperandsKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    'a'..'z', 'A'..'Z', ' ':;
    '0'..'9', '=', #8, ',', '-', '.':
      if length(eeditOperands.Text) = 0 then
        key := #0;
    #13:
    begin
      aCalculate.Execute;
      key := #0;
    end;
    else
      key := #0;
  end;
end;

{ Обработчик выделения поля eeditResult }
{ Выделяет поле eeditExpression }
{ Если сохранена ошибка в FErrors, выводит её }
procedure TfrmMain.eeditResultEnter(Sender: TObject);
begin
  eeditExpression.SetFocus;
  if length(FErrors) <> 0 then
    ShowMessage('Выражение содержит ошибки:' + #13 + #10 + arrayToString(FErrors));
end;        

{ Очищает историю и поля вкладки tabExpression }
procedure TfrmMain.ebtnCClick(Sender: TObject);
begin
  SetLength(FHistory, 1);
  PExpression := '';
  eeditOperands.Text := sOPERANDS;
  eeditResult.Text := sRESULT;
  eeditExpression.SetFocus;
end;

{ Вычисление выражения }
procedure TfrmMain.aCalculateExecute(Sender: TObject);
var
  error: Integer;
  res: Extended;
  expression, operands: String;
begin
  // Обнуляет сохранённые ошибки
  SetLength(FErrors, 0);
  // Сохраняет введённое выражение и операнды
  expression := PExpression;
  if eeditOperands.Text = sOPERANDS then
    operands := ''
  else
    operands := eeditOperands.Text;
  // Ищет ошибки в выражении и операндах
  error := check(expression, operands);
  if error = 0 then
  begin
    // Вычисляет выражение
    res := calculateInfix(expression, operands, error);
    if error = 0 then
      // Выводит результат
      eeditResult.Text := FloatToStr(res);
  end;
  // Если найдены ошибки
  if error <> 0 then
  begin
    // Сохраняет их и выводит сообщение об ошибке
    FErrors := errorToArray(error);
    if length(FErrors) = 1 then
      eeditResult.Text := FErrors[0]
    else
      eeditResult.Text := 'Ошибки в выражении (Нажмите для просмотра)';
  end;
end;

{ Обработчик нажатия кнопки "Открыть файл" }
{ Получает путь к файлу, открывает форму frmText }
procedure TfrmMain.aOpenFileExecute(Sender: TObject);
begin
  if (pcTabs.ActivePageIndex = 2) and (openDialog.Execute) then
  begin
    openedFile := openDialog.Files[0];
    if Assigned(frmText) then
      frmText.close;
    frmText := TFrmText.Create(Self);
    frmText.Show;
    Hide;
  end;
end;        

{ Подсвечивает выбранную систему счисления }
procedure TfrmMain.highlightLabel(countSystem: TCountSystem);
var
  i: Integer;
begin
  for i := 1 to 4 do
    FLabels[i].Font.Style := FLabels[i].Font.Style - [fsBold];
  i := ord(countSystem) + 1;
  FLabels[i].Font.Style := FLabels[i].Font.Style + [fsBold];
end;

{ Отключает кнопки, недоступные для этой системы счисления }
procedure TfrmMain.disableButtons(countSystem: TCountSystem);
var
  i: Integer;
  minCountSystem: Integer;
begin
  minCountSystem := ord(countSystem);
  for i := 1 to 16 do
    FButtons[i].Enabled := FButtons[i].Tag <= minCountSystem;
end;

{ Отключает кнопки, недоступные для этой системы счисления }
{ Подсвечивает выбранную систему счисления }
procedure TfrmMain.selectCountSystem(countSystem: TCountSystem);
begin
  FSelectedCountSystem := countSystem;
  highlightLabel(countSystem);
  disableButtons(countSystem);
end;

  { Обработчики нажатий на поля вкладки
    Выбирает систему счисления }
procedure TfrmMain.beditHClick(Sender: TObject);
begin
  PSelectedCountSystem := csHEX;
end;

procedure TfrmMain.beditDClick(Sender: TObject);
begin
  PSelectedCountSystem := csDEC;
end;

procedure TfrmMain.beditOClick(Sender: TObject);
begin
  PSelectedCountSystem := csOCT;
end;

procedure TfrmMain.beditBClick(Sender: TObject);
begin
  PSelectedCountSystem := csBIN;
end;

{ Выводит число в поля вкладки }
procedure TfrmMain.outputNumber(number: TNumber);
begin
  beditH.Caption := hexFromNumber(number);
  beditD.Caption := decFromNumber(number);
  beditO.Caption := octFromNumber(number);
  beditB.Caption := binFromNumber(number);
end;

{ Добавляет к числу символ }
procedure TfrmMain.bitKeyPress(key: Char);
begin
  case PSelectedCountSystem of
    csHEX:
      if not greater(FNumber.hex + key, MAX_HEX) then
        FNumber.hex := FNumber.hex + key;
    csDEC:
      if not greater(FNumber.dec + key, MAX_DEC) then
        FNumber.dec := FNumber.dec + key;
    csOCT:
      if not greater(FNumber.oct + key, MAX_OCT) then
        FNumber.oct := FNumber.oct + key;
    csBIN:
      if not greater(FNumber.bin + key, MAX_BIN) then
        FNumber.bin := FNumber.bin + key;
  end;
  convertToCountSystems(FNumber, PSelectedCountSystem);
  outputNumber(FNumber);
end;

{ Удаляет последний символ в числе }
procedure TfrmMain.bitBackPress;
begin
  case PSelectedCountSystem of
    csHEX:
      delete(FNumber.hex, length(FNumber.hex), 1);
    csDEC:
      delete(FNumber.dec, length(FNumber.dec), 1);
    csOCT:
      delete(FNumber.oct, length(FNumber.oct), 1);
    csBIN:
      delete(FNumber.bin, length(FNumber.bin), 1);
  end;
  convertToCountSystems(FNumber, PSelectedCountSystem);
  outputNumber(FNumber);
end;

  { Обработчики нажатия цифровых клавиш }
  { Добавляют символ к числу }
procedure TfrmMain.bbtn0Click(Sender: TObject);
begin
  if length(FNumber.bin) > 0 then
    bitKeyPress('0');
end;

procedure TfrmMain.bbtn1Click(Sender: TObject);
begin
  bitKeyPress('1');
end;

procedure TfrmMain.bbtn2Click(Sender: TObject);
begin                     
  bitKeyPress('2');
end;

procedure TfrmMain.bbtn3Click(Sender: TObject);
begin
  bitKeyPress('3');
end;

procedure TfrmMain.bbtn4Click(Sender: TObject);
begin
  bitKeyPress('4');
end;

procedure TfrmMain.bbtn5Click(Sender: TObject);
begin
  bitKeyPress('5');
end;

procedure TfrmMain.bbtn6Click(Sender: TObject);
begin
  bitKeyPress('6');
end;

procedure TfrmMain.bbtn7Click(Sender: TObject);
begin
  bitKeyPress('7');
end;

procedure TfrmMain.bbtn8Click(Sender: TObject);
begin
  bitKeyPress('8');
end;

procedure TfrmMain.bbtn9Click(Sender: TObject);
begin
  bitKeyPress('9');
end;

procedure TfrmMain.bbtnAClick(Sender: TObject);
begin
  bitKeyPress('A');
end;

procedure TfrmMain.bbtnBClick(Sender: TObject);
begin
  bitKeyPress('B');
end;

procedure TfrmMain.bbtnCClick(Sender: TObject);
begin
  bitKeyPress('C');
end;

procedure TfrmMain.bbtnDClick(Sender: TObject);
begin
  bitKeyPress('D');
end;

procedure TfrmMain.bbtnEClick(Sender: TObject);
begin
  bitKeyPress('E');
end;

procedure TfrmMain.bbtnFClick(Sender: TObject);
begin
  bitKeyPress('F');
end;      

{ Удаляет последний символ числа }
procedure TfrmMain.bbtnBackspaceClick(Sender: TObject);
begin
  bitBackPress;
end;

{ Очищает число }
procedure TfrmMain.aClearNumberExecute(Sender: TObject);
begin
  FNumber.hex := '';
  FNumber.dec := '';
  FNumber.oct := '';
  FNumber.bin := '';
  outputNumber(FNumber);
end;

{ Сравнивает две строки }
function TfrmMain.greater(strA, strB: String): Boolean;
begin
  if length(strA) > length(strB) then
    result := true
  else
  begin
    if length(strA) = length(strB) then
      result := strA > strB
    else
      result := false;
  end;
end;

{ Устанавливает ширину окна }
procedure TfrmMain.setWindowWidth;
begin
  ClientWidth := MAIN_WIDTH + 8 + Integer(PExtPanelOpen) * EXT_WIDTH
                 + Integer(PHistPanelOpen) * HIST_WIDTH;
  pcTabs.TabWidth := pcTabs.Width div 3 - 4;
end;

{ Открывает/Закрывает расширенную панель }
procedure TfrmMain.setExtPanelOpen(isOpen: Boolean);
begin
  FExtPanelOpen := isOpen;
  panelExtended.Visible := isOpen;
  if isOpen then
    frmMain.Left := frmMain.Left - EXT_WIDTH
  else
    frmMain.Left := frmMain.Left + EXT_WIDTH;
  setWindowWidth;
end;

{ Открывает/Закрывает панель истории }
procedure TfrmMain.setHistPanelOpen(isOpen: Boolean);
begin
  FHistPanelOpen := isOpen;
  setWindowWidth;
  panelHistory.Visible := isOpen;
end;

{ Открывают/закрывают панели }
procedure TfrmMain.labelLeftArrowClick(Sender: TObject);
begin
  PExtPanelOpen := not PExtPanelOpen;
end;

procedure TfrmMain.labelRightArrowClick(Sender: TObject);
begin
  PHistPanelOpen := not PHistPanelOpen;
end;

{ Переводит число в строке в удобный вид }
function TfrmMain.formatString(str: String): String;
begin
  while (length(str) > 0) and (str[1] = '0') do
    delete(str, 1, 1);
  if str = '' then
    result := '0'
  else
    result := str;
  if result[1] = '.' then
    result := '0' + result;
  if result[length(result)] = '.' then
    result := result + '0';
end;

{ Выводит первый операнд }
procedure TfrmMain.setFirstOperand(value: String);
begin
  if value = 'Error' then
    FFirstOperand := '0'
  else
    FFirstOperand := value;
  sgOutput.Cells[0, 1] := formatString(value);
end;

{ Выводит второй операнд }
procedure TfrmMain.setSecondOperand(value: String);
begin
  FSecondOperand := value;
  if value <> '' then
    sgOutput.Cells[0, 0] := formatString(value) + operationToString(FBinOperation)
  else
    sgOutput.Cells[0, 0] := '';
end;

{ Изменяет выбранную операцию, если была выбрана, то вычисляет }
procedure TfrmMain.operationBtnClick(operation: TCalcOperation);
begin
  if (operation in [opCOS, opSIN, opSQRT, opSQR, opLOG, opLN, opLG, op1DIVX]) then
  begin
    PFirstOperand := executeOperation(operation);
  end
  else
  begin
    if FBinOperation = opNONE then
    begin
      if PFirstOperand = '' then
        PSecondOperand := '0'
      else
        PSecondOperand := PFirstOperand;
    end
    else
      PSecondOperand := executeOperation(FBinOperation);
    PFirstOperand := '';
    FBinOperation := operation;
    PSecondOperand := PSecondOperand;
  end;
end;

{ Добавляет цифру к операнду }
procedure TfrmMain.digitBtnClick(digit: Char);
begin
  if length(PFirstOperand) < 16 then
    PFirstOperand := PFirstOperand + digit;
end;

{ Вызывает вычисление операции }
procedure TfrmMain.calculateBtnClick;
var
  lastOperation: THistoryItem;
begin
  // Если не выбрана операция
  if FBinOperation = opNONE then
  begin
    // То повторяет последнюю
    lastOperation := returnLastItem;
    FBinOperation := lastOperation.operation;
    if (FBinOperation in [opADD, opSUB, opMUL, opDIV, opPOWER, opROOT]) then
    begin
      FSecondOperand := PFirstOperand;
      FFirstOperand := deleteTrash(FloatToStrF(lastOperation.operandA, ffFixed, 10, 10));
    end;
  end;
  PFirstOperand := executeOperation(FBinOperation);  
  FBinOperation := opNONE;
  PSecondOperand := '';
end;

{ Добавляет точку к операнду }
procedure TfrmMain.dotBtnClick;
begin
  if PFirstOperand = '' then
    PFirstOperand := '0';
  if pos('.', PFirstOperand) = 0 then
    PFirstOperand := PFirstOperand + '.';
end;

{ Присваивает операнду значение exp(1) }
procedure TfrmMain.btnEulerClick(Sender: TObject);
begin
  PFirstOperand := deleteTrash(FloatToStrF(exp(1), ffFixed, 10, 10));
end;

{ Присваивает операнду значение Pi }
procedure TfrmMain.btnPiClick(Sender: TObject);
begin
  PFirstOperand := deleteTrash(FloatToStrF(Pi, ffFixed, 10, 10));
end;

  { Обработчики нажатия цифровых кнопок }
procedure TfrmMain.btn0Click(Sender: TObject);
begin
  if PFirstOperand <> '' then
    digitBtnClick('0');
end;

procedure TfrmMain.btn1Click(Sender: TObject);
begin
  digitBtnClick('1');
end;

procedure TfrmMain.btn2Click(Sender: TObject);
begin
  digitBtnClick('2');
end;

procedure TfrmMain.btn3Click(Sender: TObject);
begin
  digitBtnClick('3');
end;

procedure TfrmMain.btn4Click(Sender: TObject);
begin
  digitBtnClick('4');
end;

procedure TfrmMain.btn5Click(Sender: TObject);
begin
  digitBtnClick('5');
end;

procedure TfrmMain.btn6Click(Sender: TObject);
begin
  digitBtnClick('6');
end;

procedure TfrmMain.btn7Click(Sender: TObject);
begin
  digitBtnClick('7');
end;

procedure TfrmMain.btn8Click(Sender: TObject);
begin
  digitBtnClick('8');
end;

procedure TfrmMain.btn9Click(Sender: TObject);
begin
  digitBtnClick('9');
end;

  { Обработчики нажатия кнопок операций }
procedure TfrmMain.btnAddClick(Sender: TObject);
begin
  operationBtnClick(opADD);
end;    

procedure TfrmMain.btnSubClick(Sender: TObject);
begin
  operationBtnClick(opSUB);
end;

procedure TfrmMain.btnMulClick(Sender: TObject);
begin
  operationBtnClick(opMUL);
end;

procedure TfrmMain.btnDivClick(Sender: TObject);
begin
  operationBtnClick(opDIV);
end;       

procedure TfrmMain.btnXPowerYClick(Sender: TObject);
begin
  operationBtnClick(opPOWER);
end;      

procedure TfrmMain.btnXRootYClick(Sender: TObject);
begin
  operationBtnClick(opROOT);
end;

procedure TfrmMain.btnSqrClick(Sender: TObject);
begin
  operationBtnClick(opSQR);
end;

procedure TfrmMain.btnSqrtClick(Sender: TObject);
begin
  operationBtnClick(opSQRT);
end;

procedure TfrmMain.btnLnClick(Sender: TObject);
begin
  operationBtnClick(opLN)
end;

procedure TfrmMain.btn1DivXClick(Sender: TObject);
begin    
  operationBtnClick(op1DIVX)
end;

procedure TfrmMain.btnLgClick(Sender: TObject);
begin   
  operationBtnClick(opLG)
end;     

procedure TfrmMain.btnLogClick(Sender: TObject);
begin
  operationBtnClick(opLOG)
end;

procedure TfrmMain.btnSinClick(Sender: TObject);
begin
  operationBtnClick(opSIN)
end;

procedure TfrmMain.btnCosClick(Sender: TObject);
begin
  operationBtnClick(opCOS)
end;

{ Обработчик нажатия кнопки "=" }
procedure TfrmMain.btnEqualClick(Sender: TObject);
begin
  calculateBtnClick;
end;

{ Очищает операнды и операцию }
procedure TfrmMain.btnCClick(Sender: TObject);
begin                    
  FBinOperation := opNONE;
  PSecondOperand := '';
  PFirstOperand := '';
end;

{ Очищает текущий операнд }
procedure TfrmMain.btnCEClick(Sender: TObject);
begin
  PFirstOperand := '';
end;

{ Удаляет символ из операнда }
procedure TfrmMain.btnBackspaceClick(Sender: TObject);
begin
  PFirstOperand := copy(PFirstOperand, 1, length(PFirstOperand) - 1);
end;

{ Меняет знак операнда }
procedure TfrmMain.btnChangeSignClick(Sender: TObject);
var
  tempStr: String;
begin
  tempStr := PFirstOperand;
  if tempStr <> '' then
  begin
    if tempStr[1] = '-' then
      delete(tempStr, 1, 1)
    else
      tempStr := '-' + tempStr;
  end;
  PFirstOperand := tempStr;
end;

{ Обработчик нажатия кнопки "." }
procedure TfrmMain.btnDotClick(Sender: TObject);
begin
  dotBtnClick;
end;

{ Вычисляет операцию }
function TfrmMain.executeOperation(operation: TCalcOperation): String;
var
  operandA, operandB, res: Extended;
begin
  result := '';
  operandA := StrToFloat(formatString(PFirstOperand));
  operandB := StrToFloat(formatString(PSecondOperand));
  res := 0;
	case operation of
		opADD:
			res := operandB + operandA;
		opSUB:
			res := operandB - operandA;
		opMUL:
			res := operandB * operandA;
		opDIV:
      try
			  res := operandB / operandA;
      except
        res := NaN;
      end;
		opPOWER:
      try
			  res := power(operandB, operandA);
      except
        res := NaN;
      end;
		opROOT:
      try
			  res := power(operandB, 1 / operandA);
      except
        res := NaN;
      end;
		opCOS:
		begin
			res := cos(operandA);
			operandB := 0;
		end;
		opSIN:
		begin
			res := sin(operandA);
			operandB := 0;
		end;
		opSQRT:
		begin
      try
			  res := sqrt(operandA);
      except
        res := NaN;
      end;
			operandB := 0;
		end;
		opSQR:
		begin
			res := sqr(operandA);
			operandB := 0;
		end;
		opLOG:
		begin
      try
			  res := log2(operandA);
      except
        res := NaN;
      end;
			operandB := 0;
		end;
		opLN:
		begin
      try
			  res := ln(operandA);
      except
        res := NaN;
      end;
			operandB := 0;
		end;
		opLG:
		begin
      try
			  res := log10(operandA);
      except
        res := NaN;
      end;
			operandB := 0;
		end;
		op1DIVX:
		begin
      try
			  res := 1 / operandA;
      except
        res := NaN;
      end;
			operandB := 0;
		end;
	end;
  if IsNan(res) then
    result := 'Error'
  else
  begin
    addHistoryItem(toHistoryItem(operation, operandA, operandB, res));
    result := deleteTrash(FloatToStrF(res, ffFixed, 10, 10));
    outputHistory;
  end;
end;   

{ Выводит историю }
procedure TfrmMain.outputHistory;
var
  i: Integer;
  listItem: TListItem;
begin
  FHistoryArray := returnHistory;
  lvHistory.Items.Clear;
  i := 0;
  while (i < length(FHistoryArray)) do
  begin
    listItem := lvHistory.Items.Add;
    listItem.Caption := historyItemToString(FHistoryArray[i]);
    listItem.SubItems.Add(deleteTrash(FloatToStrF(FHistoryArray[i].res, ffFixed, 5, 5)));
    inc(i);
  end;
end;       

{ Обработчик кнопки очистки истории }
procedure TfrmMain.btnClearHistoryClick(Sender: TObject);
begin
  clearHistory;
  outputHistory;
end;       

{ При выделении элемента в истории возвращает его значение в операнд }
procedure TfrmMain.lvHistorySelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then
    PFirstOperand := deleteTrash(FloatToStrF(FHistoryArray[Item.Index].res, ffFixed, 10, 10));
end;

{ При выделении истории, удаляет с неё фокус }
procedure TfrmMain.lvHistoryEnter(Sender: TObject);
begin
  ActiveControl := nil;
end;           

procedure TfrmMain.sgOutputEnter(Sender: TObject);
begin
  ActiveControl := nil;
end;

{ Заносит кнопки конвертера в массив }
procedure TfrmMain.setButtons;
begin
  FButtons[1] := bbtn0;
  FButtons[2] := bbtn1;
  FButtons[3] := bbtn2;
  FButtons[4] := bbtn3;
  FButtons[5] := bbtn4;
  FButtons[6] := bbtn5;
  FButtons[7] := bbtn6;
  FButtons[8] := bbtn7;
  FButtons[9] := bbtn8;
  FButtons[10] := bbtn9;
  FButtons[11] := bbtnA;
  FButtons[12] := bbtnB;
  FButtons[13] := bbtnC;
  FButtons[14] := bbtnD;
  FButtons[15] := bbtnE;
  FButtons[16] := bbtnF;
end;

{ Заносит метки конвертера в массив }
procedure TfrmMain.setLabels;
begin
  FLabels[1] := beditB;
  FLabels[2] := beditO;
  FLabels[3] := beditD;
  FLabels[4] := beditH;
end;

{ Очищает вкладку выражений }
procedure TfrmMain.clearExpressionTab;
begin
  PExpression := '';
  eeditResult.Text := sRESULT;
  eeditOperands.Text := sOPERANDS;
  eeditExpression.Text := sEXPRESSION;
  SetLength(FHistory, 1);
  FHistory[0].textShot := '';
  FHistory[0].selStartShot := 0;
  SetLength(FErrors, 0);
  FLastText := lbBUTTON;
end;
                 
{ Очищает вкладку конвертера }
procedure TfrmMain.clearBitTab;
begin
  setButtons;
  setLabels;
  PSelectedCountSystem := csHEX;
  aClearNumber.Execute;
end;
            
{ Очищает вкладку простого калькулятора }
procedure TfrmMain.clearSimpleTab;
begin
  PExtPanelOpen := false;
  PHistPanelOpen := false;
  FBinOperation := opNONE;
  PFirstOperand := '';
  PSecondOperand := '';
  sgOutput.RowHeights[0] := 20;
  sgOutput.RowHeights[1] := 40;
  outputHistory;
end;

{ При создании формы очищает вкладки }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DecimalSeparator := '.';
  clearExpressionTab;
  clearBitTab;
  clearSimpleTab;
  setWindowWidth;
end;

{ При изменении активной вкладки, изменяет фокус и размеры окна }
procedure TfrmMain.pcTabsChange(Sender: TObject);
begin
  case pcTabs.ActivePageIndex of
    0:
    begin
      ActiveControl := nil;
      ClientHeight := 329;
      pcTabs.TabWidth := 80;
      setWindowWidth;
    end;
    1:
    begin
      ActiveControl := nil;
      ClientHeight := 283;
      ClientWidth := 332;
      pcTabs.TabWidth := 107;
    end;
    2:
    begin
      ActiveControl := ebtnCalculate;
      ClientHeight := 293;
      ClientWidth := 553;
      pcTabs.TabWidth := 181;
    end;
  end;
end;

{ Обработчик нажатия клавиш }
procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case pcTabs.ActivePageIndex of
    0:
    begin
      case key of
        '0':
          if PFirstOperand <> '' then
            digitBtnClick('0');
        '1'..'9':
          digitBtnClick(key);
        #13:
          calculateBtnClick;
        #8:
          PFirstOperand := copy(PFirstOperand, 1, length(PFirstOperand) - 1);
        '.':
          dotBtnClick;
        '+':
          operationBtnClick(opADD);
        '-':
          operationBtnClick(opSUB);
        '*':
          operationBtnClick(opMUL);
        '/':
          operationBtnClick(opDIV);
      end;
    end;  
    1:
    begin
      case key of
        '0'..'1':
          if (key <> '0') or (length(FNumber.bin) > 0) then
            bitKeyPress(key);
        '2'..'7':
          if PSelectedCountSystem >= csOCT then
            bitKeyPress(key);
        '8'..'9':
          if PSelectedCountSystem >= csDEC then
            bitKeyPress(key);
        'A'..'F':
          if PSelectedCountSystem = csHEX then
            bitKeyPress(key);
        #8:
          bitBackPress;
      end;
    end;
  end;
end;

{ Обработчик вывода в поле операндов }
procedure TfrmMain.sgOutputDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  with (Sender as TStringGrid).Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(Rect);
    Font.Name := 'Lucida Bright';
    if ARow = 0 then
      Font.Size := 10
    else
      Font.Size := 14;
    TextOut(Rect.Right - TextWidth(sgOutput.Cells[ACol, ARow]),
            Rect.Top + ((Rect.Bottom - Rect.Top) -
            TextHeight(sgOutput.Cells[ACol, ARow])) div 2,
            sgOutput.Cells[ACol, ARow]);
  end
end;

end.
