unit UHistory;

interface

type
  THistoryCell = packed record
    code: Integer;
    date: TDateTime;
    score: Integer;
    snakeLength: Integer;
  end;
  THistoryArray = array of THistoryCell;

procedure addHistoryItem(cell: THistoryCell); overload;

procedure clearHistory();

function returnHistory():THistoryArray;

function toHistoryCell(score: Integer; snakeLength: Integer):THistoryCell;

implementation

uses
  DateUtils, SysUtils;

type
  THistoryList = ^THistoryListElem;
  THistoryListElem = record
    cell: THistoryCell;
    next: THistoryList;
  end;

var
  list: THistoryList;
  lastCode: Integer = 0;

function isEmpty(list: THistoryList):Boolean;
begin
  result := list^.next = nil;
end;

procedure insert(list: THistoryList; cell: THistoryCell);
var
  temp: THistoryList;
begin
  while not isEmpty(list) and (list^.next^.cell.score > cell.score) do
    list := list^.next;
  new(temp);
  temp^.cell := cell;
  temp^.next := list^.next;
  list^.next := temp;
end;

procedure delete(list: THistoryList);
var
  temp: THistoryList;
begin
  temp := list^.next;
  list^.next := temp^.next;
  dispose(temp);
end;

procedure clearList(list: THistoryList);
begin
  while not isEmpty(list) do
    delete(list);
end;

procedure createList(var list: THistoryList);
begin
  new(list);
  list^.next := nil;
end;

procedure destroyList(var list: THistoryList);
begin
  clearList(list);
  dispose(list);
  list := nil;
end;   

function isEmptyList():Boolean;
begin
  result := isEmpty(list);
end;

procedure addHistoryItem(cell: THistoryCell);
begin
  if cell.code = -1 then
  begin
    inc(lastCode);
    cell.code := lastCode;
  end
  else
    if lastCode < cell.code then
      lastCode := cell.code;
  insert(list, cell);
end;

procedure clearHistory();
begin
  clearList(list);
end;

function returnHistory():THistoryArray;
var
  temp: THistoryList;
begin
  temp := list;
  SetLength(result, 0);
  while not isEmpty(temp) do
  begin
    SetLength(result, length(result) + 1);
    result[length(result) - 1] := temp^.next^.cell;
    temp := temp^.next;
  end;
end;

function toHistoryCell(score: Integer; snakeLength: Integer):THistoryCell;
begin
  result.code := -1;
  result.date := Now;
  result.score := score;
  result.snakeLength := snakeLength;
end;

initialization
  createList(list);

finalization
  destroyList(list);

end.
