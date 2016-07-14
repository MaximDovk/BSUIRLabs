unit UHistory;

interface

uses
  UTypes;

{ Проверяет пуста ли история }
function isEmptyList():Boolean;

{ Добавляет элемент в историю }
procedure addHistoryItem(item: THistoryItem);

{ Добавляет элемент в конец истории }
procedure addLastHistoryCell(cell: THistoryCell);

{ Очищает историю }
procedure clearHistory();

{ Возвращает последний элемент истории }
function returnLastItem():THistoryItem;

{ Возвращает все записи в истории }
function returnHistory():THistoryArray;

{ Возвращает и удаляет последний элемент истории }
function pop():THistoryCell;

implementation

uses
  DateUtils;

type
  { Список истории вычисленных выражений }
  THistoryList = ^THistoryListElem;
  THistoryListElem = record
    cell: THistoryCell;
    next: THistoryList;
  end;

var
  list: THistoryList;
  lastCode: Integer = 0;

{ Проверяет пуст ли список }
function isEmpty(list: THistoryList):Boolean;
begin
  result := list^.next = nil;
end;

{ Добавляет элемент в список }
procedure insert(list: THistoryList; cell: THistoryCell);
var
  temp: THistoryList;
begin
  new(temp);
  temp^.cell := cell;
  temp^.next := list^.next;
  list^.next := temp;
end;

{ Удаляет элемент из списка }
procedure delete(list: THistoryList);
var
  temp: THistoryList;
begin
  temp := list^.next;
  list^.next := temp^.next;
  dispose(temp);
end;

{ Возвращет конец списка истории }
function findEnd(list: THistoryList):THistoryList;
begin
  result := list;
  while not isEmpty(result) do
    result := result^.next;
end;

{ Очищает список }
procedure clearList(list: THistoryList);
begin
  while not isEmpty(list) do
    delete(list);
end;

{ Создаёт список }
procedure createList(var list: THistoryList);
begin
  new(list);
  list^.next := nil;
end;

{ Разрушает список }
procedure destroyList(var list: THistoryList);
begin
  clearList(list);
  dispose(list);
  list := nil;
end;   
                   
{ Проверяет пуста ли история }
function isEmptyList():Boolean;
begin
  result := isEmpty(list);
end;
                  
{ Добавляет элемент в историю }
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
                   
{ Добавляет элемент в конец истории }
procedure addLastHistoryCell(cell: THistoryCell);
begin
  if cell.code > lastCode then
    lastCode := cell.code;
  insert(findEnd(list), cell);
end;
              
{ Очищает историю }
procedure clearHistory();
begin
  clearList(list);
end;
                  
{ Возвращает последний элемент истории }
function returnLastItem():THistoryItem;
begin
  if list^.next <> nil then
    result := list^.next^.cell.item
  else
    result.operation := opNONE;
end;
                         
{ Возвращает все записи в истории }
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
               
{ Возвращает и удаляет последний элемент истории }
function pop():THistoryCell;
begin
  result := list^.next^.cell;
  delete(list);
end;

{ При подключении модуля создаёт список }
initialization
  createList(list);

{ При отключении модуля разрушает список }
finalization
  destroyList(list);

end.
