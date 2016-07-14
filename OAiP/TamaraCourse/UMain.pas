unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls, ActnList;

const
  { Максимальный размер поля }
  MAX_FIELD_SIZE = 7;

type
  { Нажатая ячейка }
  TCell = record
    x, y: Integer;
  end;
  { Массив нажатых ячеек }
  THistory = array of TCell;
  { Текущий ход }
  TTurn = (tuCROSS, tuCIRCLE, tuEND);
  TField = array [0..MAX_FIELD_SIZE - 1, 0..MAX_FIELD_SIZE - 1] of TTurn;
  TfrmMain = class(TForm)
    panelControls: TPanel;
    editFieldSize: TEdit;
    udFieldSize: TUpDown;
    editWinLine: TEdit;
    udWinLine: TUpDown;
    panelField: TPanel;
    sgField: TStringGrid;
    labelFieldSize: TLabel;
    labelWinLine: TLabel;
    btnNewGame: TButton;
    alMain: TActionList;
    aNewGame: TAction;
    aUndo: TAction;
    labelCurrentMove: TLabel;
    labelMove: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure editFieldSizeChange(Sender: TObject);
    procedure sgFieldSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure editWinLineChange(Sender: TObject);
    procedure sgFieldDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure aNewGameExecute(Sender: TObject);
    procedure aUndoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private        
    { Текущий ход }
    FTurn: TTurn;
    { Поле }
    FField: TField;
    { История ходов }
    FHistory: THistory;

    { Свойство формы "Текущий ход"
      При изменении изменяет метку текущего хода }
    procedure setTurn(turn: TTurn);
    property PTurn: TTurn read FTurn write setTurn;

    { Выводит поле в StringGrid }
    procedure outputField(field: TField);
    { Рисует поле нужного размера }
    procedure setFieldSize(size: Byte);
    { Обнуляет поле и текущий ход }
    procedure clearGameField(var field: TField);
    { Обнуляет историю }
    procedure clearHistory();
    { Добавляет ход в историю }
    procedure addHistoryMove(x, y: Integer);

    { Следующий ход }
    function nextTurn(turn: TTurn):TTurn;

    { Ищут ход компьютера }
    function findWinMove(turn: TTurn; field: TField):TCell;
    function findGoodMove(turn: TTurn; field: TField):TCell;
    procedure setComputerMove(turn: TTurn; var field: TField);
                                           
    { Проверяет, победил ли кто-либо }
    function winCheck(field: TField):Boolean;
    { Проверяет, все ли клетки заполнены }
    function drawCheck():Boolean; 

    { Проверяет заданную линию, на победу }
    function checkPrimDiagonal(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkSecDiagonal(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkVertLine(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkHoriLine(field: TField; x, y: Integer; size: Integer):Boolean;
  public
    { Указывает, кто является игроком, а кто компьютером }
    FIsPlayer1II: Boolean;
    FIsPlayer2II: Boolean;
    { Имена игроков }
    FPlayer1Name: String[20];
    FPlayer2Name: String[20];
  end;

var
  frmMain: TfrmMain;

implementation

uses
  ULogin, UStat;

{$R *.dfm}    

{ Устанавливает метку текущего хода }
procedure TfrmMain.setTurn(turn: TTurn);
begin
  case turn of
    tuCROSS:
      labelMove.Caption := 'X';
    tuCIRCLE:
      labelMove.Caption := 'O';
  end;
  FTurn := turn;
end;        

{ Вывод поля в StringGrid }
procedure TfrmMain.outputField(field: TField);
var
  i, j: Integer;
begin
  for i := 0 to sgField.RowCount - 1 do
    for j := 0 to sgField.ColCount - 1 do
      case field[i, j] of
        tuCROSS:
          sgField.Cells[j, i] := 'X';   
        tuCIRCLE:
          sgField.Cells[j, i] := 'O';
        tuEND:
          sgField.Cells[j, i] := '';
      end;
end;

{ Устанавливает размеры поля }
procedure TfrmMain.setFieldSize(size: Byte);
begin
  sgField.ColCount := size;
  sgField.RowCount := size;
  sgField.DefaultColWidth := (sgField.Width - 5) div size;
  sgField.DefaultRowHeight := (sgField.Height - 5) div size;
end;

{ Обнуляет поле и текущий ход }
procedure TfrmMain.clearGameField(var field: TField);
var
  i, j: Integer;
begin
  for i := 0 to MAX_FIELD_SIZE - 1 do
    for j := 0 to MAX_FIELD_SIZE - 1 do
      field[i, j] := tuEND;
end;

{ Обнуляет историю }
procedure TfrmMain.clearHistory;
begin
  SetLength(FHistory, 0);
end;

{ При запуске новой игры, обнуляет поле, текущий ход и историю }
procedure TfrmMain.aNewGameExecute(Sender: TObject);
begin
  PTurn := tuCROSS;
  clearHistory;
  clearGameField(FField);
  if FIsPlayer1II then
  begin
    setComputerMove(tuCROSS, FField);
    PTurn := tuCIRCLE;
  end;          
  outputField(FField);
end;

{ Добавляет ход в историю }
procedure TfrmMain.addHistoryMove(x, y: Integer);
begin
  SetLength(FHistory, length(FHistory) + 1);
  FHistory[length(FHistory) - 1].x := x;
  FHistory[length(FHistory) - 1].y := y;
end;

{ При изменении размера поля, перерисовывает его
  При необходимости уменьшает длину линии победы
  Начинает новую игру }
procedure TfrmMain.editFieldSizeChange(Sender: TObject);
var
  oldLineSize: Integer;
begin
  setFieldSize(udFieldSize.Position);
  oldLineSize := udWinLine.Max;
  udWinLine.Max := udFieldSize.Position;
  if oldLineSize > udFieldSize.Position then
    editWinLine.Text := IntToStr(udWinLine.Position);
  aNewGame.Execute;
end;

{ При изменении длины линии победы начинает новую игру }
procedure TfrmMain.editWinLineChange(Sender: TObject);
begin
  if length(FHistory) <> 0 then
    aNewGame.Execute;
end;          

{ Следующим будет ходить }
function TfrmMain.nextTurn(turn: TTurn):TTurn;
begin
  case turn of
    tuCROSS:
      result := tuCIRCLE;
    tuCIRCLE:
      result := tuCROSS;
    else
      result := tuEND;
  end;
end;

{ Ищет хороший ход }
function TfrmMain.findGoodMove(turn: TTurn; field: TField): TCell; 
var      
  winCell: TCell;
  i, j: Integer;
  ar: array of TCell;
begin
  SetLength(ar, 0);
  for i := 0 to sgField.RowCount - 1 do
    for j := 0 to sgField.ColCount - 1 do
      if field[i, j] = tuEND then
      begin
        field[i, j] := turn;
        winCell := findWinMove(turn, field);
        if winCell.x <> -1 then
        begin
          SetLength(ar, length(ar) + 1);
          ar[length(ar) - 1].x := winCell.x;
          ar[length(ar) - 1].y := winCell.y;
        end;
        field[i, j] := tuEND;
      end;
  randomize;
  if length(ar) > 0 then
  begin
    i := random(length(ar));
    result.x := ar[i].x;
    result.y := ar[i].y;
  end
  else
  begin
    for i := 0 to sgField.RowCount - 1 do
      for j := 0 to sgField.ColCount - 1 do
        if field[i, j] = tuEND then
        begin
          SetLength(ar, length(ar) + 1);
          ar[length(ar) - 1].x := j;
          ar[length(ar) - 1].y := i;
        end;
    i := random(length(ar));
    result.x := ar[i].x;
    result.y := ar[i].y;
  end;
end;

{ Ищет победный ход }
function TfrmMain.findWinMove(turn: TTurn; field: TField): TCell;
var
  i, j: Integer;
begin
  result.x := -1;
  result.y := -1;
  for i := 0 to sgField.RowCount - 1 do
    for j := 0 to sgField.ColCount - 1 do
      if field[i, j] = tuEND then
      begin
        field[i, j] := turn;
        if winCheck(field) then
        begin
          result.x := j;
          result.y := i;
        end;
        field[i, j] := tuEND;
      end;
end;

{ Ищет ход компьютера }
procedure TfrmMain.setComputerMove(turn: TTurn; var field: TField);
var
  winCell: TCell;
begin
  winCell := findWinMove(turn, field);
  if winCell.x = -1 then
  begin
    winCell := findWinMove(nextTurn(turn), field);
    if winCell.x = -1 then
      winCell := findGoodMove(turn, field);
  end;
  field[winCell.y, winCell.x] := turn;
  addHistoryMove(winCell.x, winCell.y);
  outputField(field);
end;

{ При нажатии на ячейку
  Записывает допустимый ход в историю
  Меняет текущий ход
  Проверяет победил ли кто-либо }
procedure TfrmMain.sgFieldSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if PTurn <> tuEND then
  begin
    if FField[ARow, ACol] = tuEND then
    begin
      addHistoryMove(ACol, ARow);
      FField[ARow, ACol] := PTurn;
      outputField(FField);
      if winCheck(FField) then
      begin
        if PTurn = tuCROSS then
        begin
          ShowMessage('Крестики победили');
          saveWinToFile(FPlayer1Name);
        end
        else
        begin
          ShowMessage('Нолики победили');
          saveWinToFile(FPlayer2Name);
        end;
        PTurn := tuEND;
      end;
      if PTurn <> tuEND then
      begin
        if drawCheck() then
        begin
          ShowMessage('Ничья');
          PTurn := tuEND;
        end;
      end;
      if not (PTurn = tuEND) then
      begin
        case PTurn of
          tuCROSS:
          begin
            if FIsPlayer2II then
              setComputerMove(tuCIRCLE, FField)
            else
              PTurn := nextTurn(PTurn);
          end;
          tuCIRCLE:
          begin
            if FIsPlayer1II then
              setComputerMove(tuCROSS, FField)
            else
              PTurn := nextTurn(PTurn);
          end;
        end;
        if winCheck(FField) then
        begin
          if PTurn = tuCROSS then
          begin
            ShowMessage('Нолики победили');
            saveWinToFile(FPlayer1Name);
          end
          else
          begin
            ShowMessage('Крестики победили');   
            saveWinToFile(FPlayer2Name);
          end;
          PTurn := tuEND;
        end;
        if PTurn <> tuEND then
          drawCheck();
      end;
    end;
  end
  else
    aNewGame.Execute;
end;

{ Обработка рисования ячейки, выводит текст по центру ячейки }
procedure TfrmMain.sgFieldDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  text: String;
begin
  with sgField do
  begin
    Canvas.Brush.Color := clWindow;
    Canvas.FillRect(Rect);
    text := Cells[ACol, ARow];
    Canvas.Font.Size := 15;
    Canvas.Font.Style := Canvas.Font.Style + [fsBold];
    Canvas.TextOut((DefaultColWidth - Canvas.TextWidth(text)) div 2 + Rect.Left,
                   (DefaultRowHeight - Canvas.TextHeight(text)) div 2 + Rect.Top,
                   text);
  end;
end;

{ При нажатии Ctrl+Z удаляет последний ход истории }
procedure TfrmMain.aUndoExecute(Sender: TObject);
begin
  if FIsPlayer1II or FIsPlayer2II then
  begin
    if length(FHistory) > 1 then
    begin
      FField[FHistory[length(FHistory) - 1].y,
             FHistory[length(FHistory) - 1].x] := tuEND; 
      FField[FHistory[length(FHistory) - 2].y,
             FHistory[length(FHistory) - 2].x] := tuEND;
      SetLength(FHistory, length(FHistory) - 2);
    end;
  end
  else
  begin
    if length(FHistory) > 0 then
    begin
      FField[FHistory[length(FHistory) - 1].y,
             FHistory[length(FHistory) - 1].x] := tuEND;
      SetLength(FHistory, length(FHistory) - 1);
      if length(FHistory) mod 2 = 0 then
        PTurn := tuCROSS
      else
        PTurn := tuCIRCLE;
    end;
  end;
  outputField(FField);
end;

{ Проверка на ничью }
function TfrmMain.drawCheck(): Boolean;
begin
  result := length(FHistory) = sqr(udFieldSize.Position);
end;
          
{ Проверяет поле на победу }
function TfrmMain.winCheck(field: TField): Boolean;
var
  i, j, size: Integer;
begin
  size := udWinLine.Position;
  result := false;
  for i := 0 to sgField.RowCount - 1 do
  begin
    for j := 0 to sgField.ColCount - 1 do
    begin
      if sgField.ColCount - i + 1 > size then
        result := result or checkHoriLine(field, i, j, size);
      if sgField.RowCount - j + 1 > size then
        result := result or checkVertLine(field, i, j, size);
      if (sgField.ColCount - i + 1 > size) and (sgField.RowCount - j + 1 > size) then
        result := result or checkPrimDiagonal(field, i, j, size);
      if (i >= size - 1) and (sgField.RowCount - j + 1 > size) then
        result := result or checkSecDiagonal(field, i, j, size);
    end;
  end;
end;

{ Проверяет главную диагональ }
function TfrmMain.checkPrimDiagonal(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x + i] <> field[y + i + 1, x + i + 1] then
      result := false;
end;

{ Проверяет побочную диагональ }
function TfrmMain.checkSecDiagonal(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x - i] <> field[y + i + 1, x - i - 1] then
      result := false;
end;

{ Проверяет горизонатальную линию }
function TfrmMain.checkHoriLine(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y, x + i] <> field[y, x + i + 1] then
      result := false;
end;

{ Проверяет вертикальную линию }
function TfrmMain.checkVertLine(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x] <> field[y + i + 1, x] then
      result := false;
end;

{ При создании формы начинает новую игру }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Caption := Application.Title;
  setFieldSize(3);
  aNewGame.Execute;
end;

{ При выходе показывать форму входа }
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin.Show;
end;

end.
