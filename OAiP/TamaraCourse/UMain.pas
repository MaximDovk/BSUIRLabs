unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, ExtCtrls, ActnList;

const
  { ������������ ������ ���� }
  MAX_FIELD_SIZE = 7;

type
  { ������� ������ }
  TCell = record
    x, y: Integer;
  end;
  { ������ ������� ����� }
  THistory = array of TCell;
  { ������� ��� }
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
    { ������� ��� }
    FTurn: TTurn;
    { ���� }
    FField: TField;
    { ������� ����� }
    FHistory: THistory;

    { �������� ����� "������� ���"
      ��� ��������� �������� ����� �������� ���� }
    procedure setTurn(turn: TTurn);
    property PTurn: TTurn read FTurn write setTurn;

    { ������� ���� � StringGrid }
    procedure outputField(field: TField);
    { ������ ���� ������� ������� }
    procedure setFieldSize(size: Byte);
    { �������� ���� � ������� ��� }
    procedure clearGameField(var field: TField);
    { �������� ������� }
    procedure clearHistory();
    { ��������� ��� � ������� }
    procedure addHistoryMove(x, y: Integer);

    { ��������� ��� }
    function nextTurn(turn: TTurn):TTurn;

    { ���� ��� ���������� }
    function findWinMove(turn: TTurn; field: TField):TCell;
    function findGoodMove(turn: TTurn; field: TField):TCell;
    procedure setComputerMove(turn: TTurn; var field: TField);
                                           
    { ���������, ������� �� ���-���� }
    function winCheck(field: TField):Boolean;
    { ���������, ��� �� ������ ��������� }
    function drawCheck():Boolean; 

    { ��������� �������� �����, �� ������ }
    function checkPrimDiagonal(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkSecDiagonal(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkVertLine(field: TField; x, y: Integer; size: Integer):Boolean;
    function checkHoriLine(field: TField; x, y: Integer; size: Integer):Boolean;
  public
    { ���������, ��� �������� �������, � ��� ����������� }
    FIsPlayer1II: Boolean;
    FIsPlayer2II: Boolean;
    { ����� ������� }
    FPlayer1Name: String[20];
    FPlayer2Name: String[20];
  end;

var
  frmMain: TfrmMain;

implementation

uses
  ULogin, UStat;

{$R *.dfm}    

{ ������������� ����� �������� ���� }
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

{ ����� ���� � StringGrid }
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

{ ������������� ������� ���� }
procedure TfrmMain.setFieldSize(size: Byte);
begin
  sgField.ColCount := size;
  sgField.RowCount := size;
  sgField.DefaultColWidth := (sgField.Width - 5) div size;
  sgField.DefaultRowHeight := (sgField.Height - 5) div size;
end;

{ �������� ���� � ������� ��� }
procedure TfrmMain.clearGameField(var field: TField);
var
  i, j: Integer;
begin
  for i := 0 to MAX_FIELD_SIZE - 1 do
    for j := 0 to MAX_FIELD_SIZE - 1 do
      field[i, j] := tuEND;
end;

{ �������� ������� }
procedure TfrmMain.clearHistory;
begin
  SetLength(FHistory, 0);
end;

{ ��� ������� ����� ����, �������� ����, ������� ��� � ������� }
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

{ ��������� ��� � ������� }
procedure TfrmMain.addHistoryMove(x, y: Integer);
begin
  SetLength(FHistory, length(FHistory) + 1);
  FHistory[length(FHistory) - 1].x := x;
  FHistory[length(FHistory) - 1].y := y;
end;

{ ��� ��������� ������� ����, �������������� ���
  ��� ������������� ��������� ����� ����� ������
  �������� ����� ���� }
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

{ ��� ��������� ����� ����� ������ �������� ����� ���� }
procedure TfrmMain.editWinLineChange(Sender: TObject);
begin
  if length(FHistory) <> 0 then
    aNewGame.Execute;
end;          

{ ��������� ����� ������ }
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

{ ���� ������� ��� }
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

{ ���� �������� ��� }
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

{ ���� ��� ���������� }
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

{ ��� ������� �� ������
  ���������� ���������� ��� � �������
  ������ ������� ���
  ��������� ������� �� ���-���� }
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
          ShowMessage('�������� ��������');
          saveWinToFile(FPlayer1Name);
        end
        else
        begin
          ShowMessage('������ ��������');
          saveWinToFile(FPlayer2Name);
        end;
        PTurn := tuEND;
      end;
      if PTurn <> tuEND then
      begin
        if drawCheck() then
        begin
          ShowMessage('�����');
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
            ShowMessage('������ ��������');
            saveWinToFile(FPlayer1Name);
          end
          else
          begin
            ShowMessage('�������� ��������');   
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

{ ��������� ��������� ������, ������� ����� �� ������ ������ }
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

{ ��� ������� Ctrl+Z ������� ��������� ��� ������� }
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

{ �������� �� ����� }
function TfrmMain.drawCheck(): Boolean;
begin
  result := length(FHistory) = sqr(udFieldSize.Position);
end;
          
{ ��������� ���� �� ������ }
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

{ ��������� ������� ��������� }
function TfrmMain.checkPrimDiagonal(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x + i] <> field[y + i + 1, x + i + 1] then
      result := false;
end;

{ ��������� �������� ��������� }
function TfrmMain.checkSecDiagonal(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x - i] <> field[y + i + 1, x - i - 1] then
      result := false;
end;

{ ��������� ��������������� ����� }
function TfrmMain.checkHoriLine(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y, x + i] <> field[y, x + i + 1] then
      result := false;
end;

{ ��������� ������������ ����� }
function TfrmMain.checkVertLine(field: TField; x, y, size: Integer): Boolean;
var
  i: Integer;
begin
  result := field[y, x] <> tuEND;
  for i := 0 to size - 2 do
    if field[y + i, x] <> field[y + i + 1, x] then
      result := false;
end;

{ ��� �������� ����� �������� ����� ���� }
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Self.Caption := Application.Title;
  setFieldSize(3);
  aNewGame.Execute;
end;

{ ��� ������ ���������� ����� ����� }
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin.Show;
end;

end.
