unit FormMainLab4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TPoint = record
    x, y: Integer;
  end;
  TPriorities = array of Integer;
  TOperations = array of Integer;
  TUser = record
    amount: Integer;
    priority: Integer;
    operations: TOperations;
    miss: Integer;
  end;
  TUsers = array of TUser;
  TRes = record
    efficiency: Extended;
    downtime: Integer;
    res: array of String;
  end;
  TResult = array [1..10] of TRes;
  TMainForm = class(TForm)
    comboConstType: TComboBox;
    labelConstType: TLabel;
    labelConstValue: TLabel;
    editConstValue: TEdit;
    panelGraph: TPanel;
    buttonShowGraph: TButton;
    imageGraph: TImage;
    labelT01: TLabel;
    labelT02: TLabel;
    labelT03: TLabel;
    labelT04: TLabel;
    labelT05: TLabel;
    labelT07: TLabel;
    labelT06: TLabel;
    labelT08: TLabel;
    labelT09: TLabel;
    labelT10: TLabel;
    procedure comboConstTypeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure buttonShowGraphClick(Sender: TObject);
    procedure labelT01Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure labelT02Click(Sender: TObject);
    procedure labelT03Click(Sender: TObject);
    procedure labelT04Click(Sender: TObject);
    procedure labelT05Click(Sender: TObject);
    procedure labelT06Click(Sender: TObject);
    procedure labelT07Click(Sender: TObject);
    procedure labelT08Click(Sender: TObject);
    procedure labelT09Click(Sender: TObject);
    procedure labelT10Click(Sender: TObject);
    procedure editConstValueKeyPress(Sender: TObject; var Key: Char);
    procedure comboConstTypeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  res: TResult;
  resultType, constValue, tempValue: Integer;

implementation

uses FormResults;

{$R *.dfm}

procedure TMainForm.comboConstTypeChange(Sender: TObject);
begin
  case comboConstType.ItemIndex of
    0:
      labelConstValue.Caption := 'Значение времени такта';
    1:
      labelConstValue.Caption := 'Значение времени ввода';
  end;
end;

function Coord(x, y: Integer):TPoint;
begin
  result.x := x * 38 + 14;
  result.y := round((100 - y) * (38 / 10) + 52);
end;

procedure drawGrid(max: Integer);
var
  x, y: Integer;
begin
  with MainForm.imageGraph do
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := clBlack;
    { Оси }
    Canvas.MoveTo(14, 14);
    Canvas.LineTo(14, 432);
    Canvas.LineTo(432, 432);

    { Стрелки }
    Canvas.LineTo(426, 430);
    Canvas.MoveTo(432, 432);
    Canvas.LineTo(426, 434);
    Canvas.MoveTo(14, 14);
    Canvas.LineTo(12, 20);
    Canvas.MoveTo(14, 14);
    Canvas.LineTo(16, 20);

    { Штрихи }
    x := 14;
    y := 394;
    while (y > 14) do
    begin
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(x - 2, y);
      Canvas.LineTo(x + 3, y);
      Canvas.Pen.Style := psDot;
      Canvas.Pen.Color := clGray;
      Canvas.LineTo(413, y);
      dec(y, 38);
    end;
    y := 432;
    x := 52;
    while (x < 432) do
    begin
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Color := clBlack;
      Canvas.MoveTo(x, y + 3);
      Canvas.LineTo(x, y - 2);
      Canvas.Pen.Style := psDot;
      Canvas.Pen.Color := clGray;
      Canvas.LineTo(x, 33);
      inc(x, 38);
    end;

    Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Size := 7;
    Canvas.TextOut(5, 3, 'КПД');
    Canvas.TextOut(435, 428, 'T');
    Canvas.Font.Size := 5;
    Canvas.TextOut(16, 55, '100%');
    Canvas.TextOut(16, 93, '90%');
    Canvas.TextOut(16, 131, '80%');
    Canvas.TextOut(16, 169, '70%');
    Canvas.TextOut(16, 207, '60%');
    Canvas.TextOut(16, 245, '50%');
    Canvas.TextOut(16, 283, '40%');
    Canvas.TextOut(16, 321, '30%');
    Canvas.TextOut(16, 359, '20%');
    Canvas.TextOut(16, 397, '10%');

    if max <> 0 then
    begin
      Canvas.TextOut(16, 65, IntToStr(max));
      Canvas.TextOut(16, 103, IntToStr(Round(max / 10 * 9)));
      Canvas.TextOut(16, 141, IntToStr(Round(max / 10 * 8)));
      Canvas.TextOut(16, 179, IntToStr(Round(max / 10 * 7)));
      Canvas.TextOut(16, 217, IntToStr(Round(max / 10 * 6)));
      Canvas.TextOut(16, 255, IntToStr(Round(max / 10 * 5)));
      Canvas.TextOut(16, 293, IntToStr(Round(max / 10 * 4)));
      Canvas.TextOut(16, 331, IntToStr(Round(max / 10 * 3)));
      Canvas.TextOut(16, 369, IntToStr(Round(max / 10 * 2)));
      Canvas.TextOut(16, 407, IntToStr(Round(max / 10 * 1)));
    end;

    Canvas.TextOut(55, 423, '1');
    Canvas.TextOut(93, 423, '2');
    Canvas.TextOut(131, 423, '3');
    Canvas.TextOut(169, 423, '4');
    Canvas.TextOut(207, 423, '5');
    Canvas.TextOut(245, 423, '6');
    Canvas.TextOut(283, 423, '7');
    Canvas.TextOut(321, 423, '8');
    Canvas.TextOut(359, 423, '9');
    Canvas.TextOut(397, 423, '10');

    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Style := psSolid;
    Canvas.MoveTo(width div 2 - 50, 465);
    Canvas.LineTo(width div 2, 465);

    Canvas.Pen.Color := clGreen;
    Canvas.MoveTo(width div 2 - 50, 495);
    Canvas.LineTo(width div 2, 495);
    Canvas.Font.Size := 8;
    Canvas.TextOut(width div 2 + 10, 458, 'КПД');
    Canvas.TextOut(width div 2 + 10, 488, 'Время простоя');
  end;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  drawGrid(0);
end;

procedure doNothing(res: Integer);
begin
end;

function checkText(str: String):Boolean;
var
  res, err: Integer;
begin
  val(str, res, err);
  if err = 0 then
    result := true
  else
    result := false;
  doNothing(res);
end;

{ Копирует из константы в динамический массив }
procedure copyArray(var dest: TOperations; num: Integer);
var
  i: Integer;
const
  { Время, затрачиваемое пользователями в обратном порядке }
  user1: array [0..7] of Integer =  (4, 5, 2, 3, 6, 1, 2, 3);
  user2: array [0..8] of Integer =  (4, 6, 2, 1, 3, 3, 2, 1, 2);
  user3: array [0..9] of Integer =  (2, 1, 3, 2, 4, 5, 8, 6, 1, 4);
  user4: array [0..9] of Integer =  (9, 5, 6, 1, 2, 3, 9, 8, 4, 2);
  user5: array [0..10] of Integer = (2, 3, 1, 5, 4, 1, 3, 2, 7, 6, 9);
  user6: array [0..10] of Integer = (1, 3, 2, 1, 4, 3, 6, 1, 2, 3, 2);
  user7: array [0..11] of Integer = (2, 1, 6, 1, 2, 1, 4, 3, 1, 3, 2, 3);
  user8: array [0..11] of Integer = (2, 2, 2, 4, 8, 3, 6, 1, 3, 3, 3, 2);
begin
  case num of
    0:
      for i := 0 to length(user1) - 1 do
        dest[i] := user1[i];
    1:
      for i := 0 to length(user2) - 1 do
        dest[i] := user2[i];
    2:
      for i := 0 to length(user3) - 1 do
        dest[i] := user3[i];
    3:
      for i := 0 to length(user4) - 1 do
        dest[i] := user4[i];
    4:
      for i := 0 to length(user5) - 1 do
        dest[i] := user5[i];
    5:
      for i := 0 to length(user6) - 1 do
        dest[i] := user6[i];
    6:
      for i := 0 to length(user7) - 1 do
        dest[i] := user7[i];
    7:
      for i := 0 to length(user8) - 1 do
        dest[i] := user8[i];
  end;
end;

{ Заполняет пользователей данными }
procedure setUsers(var users: TUsers);
var
  i: Integer;
begin
  SetLength(users, 8);

  { Заполнение данных пользователей системы }
  users[0].amount := 8;
  users[1].amount := 9;
  users[2].amount := 10;
  users[3].amount := 10;
  users[4].amount := 11;
  users[5].amount := 11;
  users[6].amount := 12;
  users[7].amount := 12;

  { Заполнение приоритетов пользователей }
  users[0].priority := 1;
  users[1].priority := 1;
  users[2].priority := 1;
  users[3].priority := 2;
  users[4].priority := 2;
  users[5].priority := 3;
  users[6].priority := 3;
  users[7].priority := 3;

  users[0].miss := 0;
  users[1].miss := 0;
  users[2].miss := 0;
  users[3].miss := 0;
  users[4].miss := 0;
  users[5].miss := 0;
  users[6].miss := 0;
  users[7].miss := 0;

  for i := 0 to length(users) - 1 do
    SetLength(users[i].operations, users[i].amount);

  { Заполнение пользователей }
  copyArray(users[0].operations, 0);
  copyArray(users[1].operations, 1);
  copyArray(users[2].operations, 2);
  copyArray(users[3].operations, 3);
  copyArray(users[4].operations, 4);
  copyArray(users[5].operations, 5);
  copyArray(users[6].operations, 6);
  copyArray(users[7].operations, 7);
end;

{ Устанавливает начальные приоритеты }
procedure setPriorities(var priorities: TPriorities; len, maxPr: Integer);
var
  i: Integer;
begin
  SetLength(priorities, maxPr);
  for i := 0 to maxPr - 1 do
    priorities[i] := len - 1;
end;

{ Очищает массив результата }
procedure clearResult(var res: TResult; n: Integer);
var
  t, i: Integer;
begin
  for t := 1 to 10 do
  begin
      res[t].efficiency := 0;
      res[t].downtime := 0;
      setLength(res[t].res, n);
      for i := 0 to n - 1 do
       res[t].res[i] := '';
  end;
end;

{ Проверяет на пустоту задачи пользователей }
function isEmpty(users: TUsers):Boolean;
var
  i: Integer;
begin
  result := true;
  for i := 0 to length(users) - 1 do
  begin
    if users[i].amount <> 0 then
      result := false
    else
      if users[i].operations[0] <> 0 then
        result := false;
  end;
end;

function findNext(var users: TUsers; var priorities: TPriorities; maxPr: Integer):Integer;
var
  pr, i, num: Integer;
begin
  result := -1;
  pr := 1;
  while (pr <= maxPr) and (result = -1) do
  begin
    num := 0;
    i := priorities[pr - 1] + 1;
    if i = length(users) then
      i := 0;
    while (result = -1) and (num <= 8) do
    begin
      if users[i].priority = pr then
      begin
        if users[i].miss = 0 then
        begin
          if users[i].amount <> 0 then
          begin
            result := i;
          end
          else
            if users[i].operations[0] <> 0 then
              result := i;
        end;
      end;
      inc(num);
      inc(i);
      if i = length(users) then
        i := 0;
    end;
    inc(pr);
  end;
  if result <> -1 then
  begin
    dec(pr);
    priorities[pr - 1] := result;
  end;
end;

procedure tact(var users: TUsers);
var
  i: Integer;
begin
  for i := 0 to length(users) - 1 do
  begin
    if users[i].miss > 0 then
      dec(users[i].miss);
  end;
end;

function calcBest(users: TUsers):Integer;
var
  i, j: Integer;
begin
  result := 0;
  for i := 0 to length(users) - 1 do
  begin
    for j := 0 to length(users[i].operations) - 1 do
      inc(result, users[i].operations[j]);
  end;
end;

function strX(str: String; n: Integer):String;
begin
  result := '';
  while n > 0 do
  begin
    result := result + str;
    dec(n);
  end;
end;

procedure otherWait(var res: TRes; this: Integer; ch: String; tTact: Integer);
var
  i: Integer;
begin
  for i := 0 to length(res.res) - 1 do
  begin
    if i <> this then
      res.res[i] := res.res[i] + strX(ch, tTact);
  end;
end;

procedure process(var users: TUsers; var res: TRes; tTact, tInput, maxPr: Integer);
var
  next, wait, i, j, k: Integer;
  priorities: TPriorities;
begin
  setUsers(users);
  setPriorities(priorities, length(users), maxPr);
  while not isEmpty(users) do
  begin
    next := findNext(users, priorities, maxPr);
    if next <> -1 then
    begin
      if users[next].operations[users[next].amount - 1] > tTact then
      begin            
        res.res[next] := res.res[next] + strX('X', tTact);
        otherWait(res, next, '_', tTact);
        dec(users[next].operations[users[next].amount - 1], tTact);
        tact(users);
      end
      else
      begin
        wait := tTact - users[next].operations[users[next].amount - 1];   
        res.res[next] := res.res[next] + strX('X', users[next].operations[users[next].amount - 1]) + strX('_', wait);
        otherWait(res, next, '_', tTact);
        inc(res.downtime, wait);
        users[next].operations[users[next].amount - 1] := 0;
        dec(users[next].amount);
        tact(users);
        if wait = tInput then
          users[next].miss := 0
        else
          users[next].miss := (tInput - wait) div tTact + 1;
        if tInput - wait = tTact then
          dec(users[next].miss);
      end;
    end
    else
    begin     
      otherWait(res, next, '_', tTact);
      tact(users);
      inc(res.downtime, tTact);
    end;
    res.efficiency := res.efficiency + tTact;
  end;
  setUsers(users);
  for i := 0 to length(res.res) - 1 do
  begin
    j := 1;
    while j <= length(res.res[i]) do
    begin
      if res.res[i][j] = 'X' then
      begin
        dec(users[i].operations[users[i].amount - 1]);
        if (users[i].operations[users[i].amount - 1] = 0) and (users[i].amount <> 1) then
        begin
          for k := 1 to tInput do
          begin
            res.res[i][j + k] := 'I';
          end;
          inc(j, tInput);
          dec(users[i].amount);
        end;
        if (users[i].amount = 1) and (users[i].operations[users[i].amount - 1] = 0) then
          res.res[i][j + 1] := '.';
      end;
      inc(j);
    end;
  end;
end;

function calculate(var res: TResult; calcType: Integer; constValue: Integer):Integer;
var
  users: TUsers;
  i: Integer;
begin             
  clearResult(res, 8);
  case calcType of
    0:
    begin
      for i := 1 to 10 do
      begin
        process(users, res[i], constValue, i, 3);
      end;
    end;
    1:
    begin
      for i := 1 to 10 do
      begin
        process(users, res[i], i, constValue, 3);
      end;
    end;
  end;
  setUsers(users);
  result := calcBest(users);
end;

function findMax(res: TResult):Integer;
var
  i: Integer;
begin
  result := res[1].downtime;
  for i := 2 to 10 do
  begin
    if res[i].downtime > result then
      result := res[i].downtime;
  end;
end;

procedure draw(res: TResult);
var
  i, max: Integer;
  p: TPoint;
begin
  with MainForm.imageGraph do
  begin
    Canvas.Pen.Style := psSolid;
    Canvas.Pen.Color := clBlack;
    p := Coord(1, round(res[1].efficiency * 100));
    Canvas.MoveTo(p.x, p.y);
    for i := 2 to 10 do
    begin
      p := Coord(i, round(res[i].efficiency * 100));
      Canvas.LineTo(p.x, p.y);
    end;
    max := findMax(res) + 10;
    p := Coord(1, round(res[1].downtime / max * 100));
    Canvas.Pen.Color := clGreen;
    Canvas.MoveTo(p.x, p.y);
    for i := 2 to 10 do
    begin
      p := Coord(i, round(res[i].downtime / max * 100));
      Canvas.LineTo(p.x, p.y);
    end;
  end;
end;

procedure TMainForm.buttonShowGraphClick(Sender: TObject);
var
  best, i: Integer;
begin
  if checkText(editConstValue.Text) and (strToInt(editConstValue.Text) <= 10) and (strToInt(editConstValue.Text) > 0) then
  begin
    imageGraph.Canvas.Brush.Color := clWhite;
    imageGraph.Canvas.Pen.Color := clWhite;
    imageGraph.Canvas.Rectangle(1, 1, 449, 449);
    constValue := strToInt(editConstValue.Text);
    resultType := comboConstType.ItemIndex;
    case resultType of
      0:
        best := calculate(res, 0, constValue);
      else
        best := calculate(res, 1, constValue);
    end;
    for i := 1 to 10 do
      res[i].efficiency := best / res[i].efficiency;    
    drawGrid(findMax(res) + 10);
    draw(res);
  end
  else
  begin
    MessageDlg('Введите время от 1 до 10', mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  tempValue := 0;
  constValue := 0;
  resultType := -1;
end;

procedure showError(str: String);
begin
  MessageDlg(str, mtError, [mbOK], 0);
end;

procedure TMainForm.labelT01Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 1;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT02Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 2;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT03Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 3;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT04Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 4;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT05Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 5;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT06Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 6;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT07Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 7;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT08Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 8;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT09Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 9;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;

procedure TMainForm.labelT10Click(Sender: TObject);
begin
  if resultType <> -1 then
  begin
    tempValue := 10;
    if (Assigned(ResultsForm)) then
    begin
      ResultsForm.Close;
    end;
    ResultsForm:=TResultsForm.Create(Self);
  end
  else
    showError('Вы должны вывести график до вывода таблицы');
end;


procedure TMainForm.editConstValueKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    buttonShowGraph.Click;
  end;
end;

procedure TMainForm.comboConstTypeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    buttonShowGraph.Click;
  end;
end;

end.
