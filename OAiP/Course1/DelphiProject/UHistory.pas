unit UHistory;

interface

uses
  UTypes;

{ ��������� ����� �� ������� }
function isEmptyList():Boolean;

{ ��������� ������� � ������� }
procedure addHistoryItem(item: THistoryItem);

{ ��������� ������� � ����� ������� }
procedure addLastHistoryCell(cell: THistoryCell);

{ ������� ������� }
procedure clearHistory();

{ ���������� ��������� ������� ������� }
function returnLastItem():THistoryItem;

{ ���������� ��� ������ � ������� }
function returnHistory():THistoryArray;

{ ���������� � ������� ��������� ������� ������� }
function pop():THistoryCell;

implementation

uses
  DateUtils;

type
  { ������ ������� ����������� ��������� }
  THistoryList = ^THistoryListElem;
  THistoryListElem = record
    cell: THistoryCell;
    next: THistoryList;
  end;

var
  list: THistoryList;
  lastCode: Integer = 0;

{ ��������� ���� �� ������ }
function isEmpty(list: THistoryList):Boolean;
begin
  result := list^.next = nil;
end;

{ ��������� ������� � ������ }
procedure insert(list: THistoryList; cell: THistoryCell);
var
  temp: THistoryList;
begin
  new(temp);
  temp^.cell := cell;
  temp^.next := list^.next;
  list^.next := temp;
end;

{ ������� ������� �� ������ }
procedure delete(list: THistoryList);
var
  temp: THistoryList;
begin
  temp := list^.next;
  list^.next := temp^.next;
  dispose(temp);
end;

{ ��������� ����� ������ ������� }
function findEnd(list: THistoryList):THistoryList;
begin
  result := list;
  while not isEmpty(result) do
    result := result^.next;
end;

{ ������� ������ }
procedure clearList(list: THistoryList);
begin
  while not isEmpty(list) do
    delete(list);
end;

{ ������ ������ }
procedure createList(var list: THistoryList);
begin
  new(list);
  list^.next := nil;
end;

{ ��������� ������ }
procedure destroyList(var list: THistoryList);
begin
  clearList(list);
  dispose(list);
  list := nil;
end;   
                   
{ ��������� ����� �� ������� }
function isEmptyList():Boolean;
begin
  result := isEmpty(list);
end;
                  
{ ��������� ������� � ������� }
procedure addHistoryItem(item: THistoryItem);
var
  tempCell: THistoryCell;
begin
  inc(lastCode);
  tempCell.code := lastCode;
  tempCell.date := today;
  tempCell.item := item;
  insert(list, tempCell);
end;
                   
{ ��������� ������� � ����� ������� }
procedure addLastHistoryCell(cell: THistoryCell);
begin
  if cell.code > lastCode then
    lastCode := cell.code;
  insert(findEnd(list), cell);
end;
              
{ ������� ������� }
procedure clearHistory();
begin
  clearList(list);
end;
                  
{ ���������� ��������� ������� ������� }
function returnLastItem():THistoryItem;
begin
  if list^.next <> nil then
    result := list^.next^.cell.item
  else
    result.operation := opNONE;
end;
                         
{ ���������� ��� ������ � ������� }
function returnHistory():THistoryArray;
var
  temp: THistoryList;
begin
  temp := list;
  SetLength(result, 0);
  while not isEmpty(temp) do
  begin
    SetLength(result, length(result) + 1);
    result[length(result) - 1] := temp^.next^.cell.item;
    temp := temp^.next;
  end;
end;      
               
{ ���������� � ������� ��������� ������� ������� }
function pop():THistoryCell;
begin
  result := list^.next^.cell;
  delete(list);
end;

{ ��� ����������� ������ ������ ������ }
initialization
  createList(list);

{ ��� ���������� ������ ��������� ������ }
finalization
  destroyList(list);

end.
