unit UTextForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  { ����������� � ����� �������� }
  TOperation = (opCONVERT, opCALC_INFIX{, opCALC_POSTFIX});
  { ������ � ��������� � ����� }
  TExpression = record
    operation: TOperation;
    expression: String;
    operands: String;
    result: Extended;
    converted: String;
    error: Integer;
    replaced: Boolean;
    line: Integer;
    position: Integer;
  end;
  { ������ ����� }
  TText = array of String;
  { ������ ��������� }
  TExpressions = array of TExpression;
  TfrmText = class(TForm)
    panelText: TPanel;
    reditText: TRichEdit;
    panelExpressions: TPanel;
    splitter: TSplitter;
    lvExpressions: TListView;
    panelButtons: TPanel;
    btnHelp: TButton;
    btnReplaceAll: TButton;
    labelExpressions: TLabel;
    btnSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lvExpressionsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvExpressionsEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure btnReplaceAllClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { ������ ��������� ��������� }
    FExpressions: TExpressions;
    { ����� �� ����� }
    FText: TText;
    { ���������� ��������� }
    FSelected: Integer;

    { ������������� ������� � ������� ������ ��������� }
    procedure setListViewColumns;
    { ��������� ���� }
    procedure readFile(path: String);
    { ������� ����� }
    procedure textToRichEdit(text: TText);
    { ������� ��������� }
    procedure expressionsToListView(expressions: TExpressions);
    { ������� ����� ������� � ������, �� ������ ������ }
    function countChars(text: TText; lines: Integer):Integer;
    { ���� ��������� � ������ }
    procedure parseLine(numLine: Integer; line: String; var expressions: TExpressions);
    { ���� ��������� � ������ }
    function parseFile(text: TText):TExpressions;
    { ��������� ��������� }
    procedure processExpressions(var expressions: TExpressions);
    { ������������ ��������� }
    procedure highlightExpressions(expressions: TExpressions);
    { ������������ ���������� ��������� }
    procedure highlightSelected(expressions: TExpressions; num: Integer);
    { �������� ��������� � ������ �� ��������� }
    procedure replaceResult(var text: TText; var expressions: TExpressions; num: Integer; outputErrors: Boolean);
  public
    { Public declarations }
  end;

var
  frmText: TfrmText;

implementation

uses UMain, UExpression, UTypes;

resourceString
  sCAPTION = '���� - ';
  sEXPRESSION = '���������';
  sOPERATION = '��������';
  sOPERANDS = '��������';
  sRESULT = '���������';
  sERRORS = '������';
  sREPLACED = '��������';

{$R *.dfm}    
                             
{ ������������� ������� � ������� ������ ��������� }
procedure TfrmText.setListViewColumns;
var
  listColumn: TListColumn;
begin
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sEXPRESSION;
  listColumn.Width := 150;
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sOPERATION;
  listColumn.Width := 75;
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sOPERANDS;
  listColumn.Width := 100;
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sRESULT;
  listColumn.Width := 125;
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sERRORS;
  listColumn.Width := 75;
  listColumn := lvExpressions.Columns.Add;
  listColumn.Caption := sREPLACED;
  listColumn.Width := 75;
end;
                            
{ ��������� ���� }
procedure TfrmText.readFile(path: String);
var
  f: TextFile;
begin
  AssignFile(f, path);
  Reset(f);
  SetLength(FText, 0);
  while not eof(f) do
  begin
    SetLength(FText, length(FText) + 1);
    readln(f, FText[length(FText) - 1]);
  end;
  CloseFile(f);
end;

{ ���� ��������� � ������ }
procedure TfrmText.parseLine(numLine: Integer; line: String; var expressions: TExpressions);
var
  i, j: Integer;
  tempStr: String;
  tempExpression: TExpression;
const
  OPERATIONS_SHORT: array [TOperation] of String =
    ('@TP@', '@CI@'{, '@CP@'});
begin
  i := 1;
  while i <= length(line) do
  begin
    tempStr := copy(line, i, 4);
    j := i + 4;
    if (tempStr = OPERATIONS_SHORT[opCONVERT]) or
       (tempStr = OPERATIONS_SHORT[opCALC_INFIX]) {or
       (tempStr = OPERATIONS_SHORT[opCALC_POSTFIX])} then
    begin
      tempExpression.operands := '';
      tempExpression.replaced := false;
      tempExpression.line := numLine;
      tempExpression.position := i;
      while (j <= length(line)) and (line[j] <> '@') do
        inc(j);
      if j <= length(line) then
        tempExpression.expression := copy(line, i + 4, j - i - 4)
      else
        tempExpression.expression := '';
      inc(j);
    end;

    if (tempStr = OPERATIONS_SHORT[opCONVERT]) then
    begin
      tempExpression.operation := opCONVERT;
      tempExpression.operands := '';
      i := j;
    end;

    if (tempStr = OPERATIONS_SHORT[opCALC_INFIX]) then
    begin                
      tempExpression.operation := opCALC_INFIX;
      i := j;
      while (j <= length(line)) and (line[j] <> '@') do
        inc(j);
      if j <= length(line) then
        tempExpression.operands := copy(line, i, j - i)
      else
        tempExpression.expression := '';
      i := j;
    end;

    {if (tempStr = OPERATIONS_SHORT[opCALC_POSTFIX]) then
    begin                
      tempExpression.operation := opCALC_POSTFIX;
      i := j;
      while (j <= length(line)) and (line[j] <> '@') do
        inc(j);                    
      if j <= length(line) then
        tempExpression.operands := copy(line, i, j - i)
      else
        tempExpression.expression := '';
      i := j;
    end;     }
    if tempExpression.expression <> '' then
    begin
      SetLength(expressions, length(expressions) + 1);
      expressions[length(expressions) - 1] := tempExpression;
      tempExpression.expression := '';
    end;
    inc(i);
  end;
end;

{ ���� ��������� � ������ }
function TfrmText.parseFile(text: TText):TExpressions;
var
  i: Integer;
begin
  SetLength(result, 0);
  for i := 0 to length(text) - 1 do
    parseLine(i, text[i], result);
end;

{ ��������� ��������� }
procedure TfrmText.processExpressions(var expressions: TExpressions);
var
  i: Integer;
begin
  for i := 0 to length(expressions) - 1 do
  begin
    with expressions[i] do
    begin
      case operation of
        opCONVERT:
        begin
          error := check(expression);
          if error = 0 then
            converted := infixToPostfix(expression);
        end;
        opCALC_INFIX:
        begin
          error := check(expression, operands);
          if error = 0 then
            result := calculateInfix(expression, operands, error);
        end;
      end;
    end;
  end;
end;
               
{ ������� ����� }
procedure TfrmText.textToRichEdit(text: TText);
var
  i: Integer;
begin
  reditText.Lines.Clear;
  for i := 0 to length(text) - 1 do
    reditText.Lines.Add(text[i]);
end;  
               
{ ������� ��������� }
procedure TfrmText.expressionsToListView(expressions: TExpressions);
var
  i: Integer;
  listItem: TListItem;
begin
  lvExpressions.Items.Clear;
  for i := 0 to length(expressions) - 1 do
  begin
    with expressions[i] do
    begin
      case operation of
        opCONVERT:
        begin
          listItem := lvExpressions.Items.Add;
          listItem.Caption := expression;
          listItem.SubItems.Add('�������');
          listItem.SubItems.Add('');
          if error <> 0 then
          begin
            listItem.SubItems.Add('-');
            listItem.SubItems.Add('������ � ���������');
          end
          else
          begin
            listItem.SubItems.Add(converted);
            listItem.SubItems.Add('-');
          end;
          listItem.SubItems.Add(BoolToStr(replaced, true));
        end;
        opCALC_INFIX:
        begin
          listItem := lvExpressions.Items.Add;
          listItem.Caption := expression;
          listItem.SubItems.Add('����������');
          listItem.SubItems.Add(operands);
          if error <> 0 then
          begin
            listItem.SubItems.Add('-');
            listItem.SubItems.Add('������ � ���������');
          end
          else
          begin
            listItem.SubItems.Add(FloatToStrF(result, ffFixed, 4, 5));
            listItem.SubItems.Add('-');
          end;
          listItem.SubItems.Add(BoolToStr(replaced, true));
        end;
      end;
    end;
  end;
end;       
               
{ ������� ����� ������� � ������, �� ������ ������ }
function TfrmText.countChars(text: TText; lines: Integer): Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 0 to lines - 1 do
    result := result + length(text[i]) + 2;
end;

{ ������������ ��������� }
procedure TfrmText.highlightExpressions(expressions: TExpressions);
var
  i: Integer;
begin
  for i := 0 to length(expressions) - 1 do
  begin
    with expressions[i] do
    begin
      reditText.SelStart := countChars(FText, line) + position - 1;
      if not replaced then
      begin
        if operation <> opCONVERT then
          reditText.SelLength := 6 + length(expression) + length(operands)
        else
          reditText.SelLength := 5 + length(expression);
      end
      else
      begin
        if operation <> opCONVERT then
          reditText.SelLength := length(FloatToStrF(result, ffFixed, 4, 5))
        else
          reditText.SelLength := length(converted);
      end;
      reditText.SelAttributes.Color := clGreen;
    end;
  end;
  reditText.SelStart := 0;
  reditText.SelLength := 0;
end;

{ ��� ��������, ������������� ���������,
  ��������� ����, ���� ��������� � ������,
  ������� ��������� � �������,
  ������������ ��������� � ������ }
procedure TfrmText.FormCreate(Sender: TObject);
begin
  Self.Caption := sCAPTION + ExtractFileName(frmMain.openedFile);
  readFile(frmMain.openedFile);
  textToRichEdit(FText);
  FExpressions := parseFile(FText);
  processExpressions(FExpressions);
  setListViewColumns;
  expressionsToListView(FExpressions);
  highlightExpressions(FExpressions);
  FSelected := -1;
end;

{ ��� �������� ���������� ������� ����� }
procedure TfrmText.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMain.Show;
end;

{ ������������ ���������� ��������� }
procedure TfrmText.highlightSelected(expressions: TExpressions; num: Integer);
begin
  if FSelected <> -1 then
  begin
    with expressions[FSelected] do
    begin
      reditText.SelStart := countChars(FText, line) + position - 1;
      if not replaced then
      begin
        if operation <> opCONVERT then
          reditText.SelLength := 6 + length(expression) + length(operands)
        else
          reditText.SelLength := 5 + length(expression);
      end
      else
      begin
        if operation <> opCONVERT then
          reditText.SelLength := length(FloatToStrF(result, ffFixed, 4, 5))
        else
          reditText.SelLength := length(converted);
      end;
      reditText.SelAttributes.Color := clGreen;
    end;
  end;

  with expressions[num] do
  begin
    FSelected := num;
    reditText.SelStart := countChars(FText, line) + position - 1;
    if not replaced then
    begin
      if operation <> opCONVERT then
        reditText.SelLength := 6 + length(expression) + length(operands)
      else
        reditText.SelLength := 5 + length(expression);
    end
    else
    begin
      if operation <> opCONVERT then
        reditText.SelLength := length(FloatToStrF(result, ffFixed, 4, 5))
      else
        reditText.SelLength := length(converted);
    end;
    reditText.SelAttributes.Color := clRed;
  end;
end;

procedure TfrmText.lvExpressionsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  if Selected then
    highlightSelected(FExpressions, Item.Index);
end;

{ �������� ��������� � ������ �� ��������� }
procedure TfrmText.replaceResult(var text: TText;
  var expressions: TExpressions; num: Integer; outputErrors: Boolean);
var
  deltaLen, i: Integer;
begin
  with expressions[num] do
  begin
    if (not replaced) and (error = 0) then
    begin
      replaced := true;
      if operation <> opCONVERT then
      begin
        deltaLen := length(FloatToStrF(result, ffFixed, 4, 5)) - (6 + length(expression) + length(operands));
        delete(text[line], position, 6 + length(expression) + length(operands));
        insert(FloatToStrF(result, ffFixed, 4, 5), text[line], position);
        i := num + 1;
        while expressions[i].line = line do
        begin
          expressions[i].position := expressions[i].position + deltaLen;
          inc(i);
        end;
      end
      else
      begin
        deltaLen := length(converted) - (5 + length(expression));
        delete(text[line], position, 5 + length(expression));
        insert(converted, text[line], position);
        i := num + 1;
        while expressions[i].line = line do
        begin
          expressions[i].position := expressions[i].position + deltaLen;   
          inc(i);
        end;
      end;
    end
    else
      if (error <> 0) and outputErrors then
        ShowMessage('��������� �������� ������:' + #13 + #10 + arrayToString(errorToArray(error)));
  end;
end;        

{ �������� ��� ��������� �� ��������� }
procedure TfrmText.btnReplaceAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to length(FExpressions) - 1 do
  begin
    replaceResult(FText, FExpressions, i, false);
  end;     
  textToRichEdit(FText);
  highlightExpressions(FExpressions);
  expressionsToListView(FExpressions);
end;

{ ��� ������� �������� ������� � �������,
  �������� ��������� �� ��������� � ������ }
procedure TfrmText.lvExpressionsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  replaceResult(FText, FExpressions, Item.Index, true);
  textToRichEdit(FText);
  highlightExpressions(FExpressions);
  highlightSelected(FExpressions, Item.Index);
  expressionsToListView(FExpressions);
  AllowEdit := false;
end;

{ ��������� ����� � ���� }
procedure TfrmText.btnSaveClick(Sender: TObject);
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, frmMain.openedFile);
  Rewrite(f);
  for i := 0 to length(FText) - 1 do
  begin
    writeln(f, FText[i]);
  end;
  CloseFile(f);
end;

procedure TfrmText.btnHelpClick(Sender: TObject);
begin
  ShowMessage('��������� ��� ���������� � ����� ������ ����� ���:' + #13 + #10 +
              '@���_��������@���������@��������@, ��� ���_�������� - CI ��� TP,' + #13 + #10 +
              '���������, �������� ����������� � ���������.');
end;

end.
