program epicList;

{$APPTYPE CONSOLE}

type
  TValue = Integer;
  TList = ^TElement;
  TElement = record
    value: TValue;
    next: TList;
    prev: TList;
  end;

var
  list: TList;
  i: Integer;

function isListExists(const list: TList):Boolean;
begin
  if list = nil then
    result := false
  else
    result := true;
end;

function isListEmpty(const list: TList):Boolean;
begin
  if isListExists(list) then
  begin
    if list^.next = nil then
      result := true
    else
      result := false;
  end
  else
    result := true;
end;

procedure insertZeroElement(const list: TList; const value: TValue);
var
  temp: TList;
begin
  if isListExists(list) then
  begin             
    new(temp);
    temp^.value := value;
    if not isListEmpty(list) then
    begin
      temp^.next := list^.next;
      temp^.prev := temp^.next^.prev;
      list^.next^.prev := temp;
      temp^.prev^.next := temp;
      list^.next := temp;
    end
    else
    begin
      temp^.next := temp;
      temp^.prev := temp;
      list^.next := temp;
    end;
  end
  else
    writeln('List is not exists, can`t insert element');
end;

function getListLength(list: TList):Integer;
var
  temp: TList;
begin
  result := 0;
  if not isListEmpty(list) then
  begin
    temp := list^.next;
    repeat
      inc(result);
      list := list^.next;
    until list^.next = temp;
  end;
end;

procedure deleteZeroElement(const list: TList);
var
  temp: TList;
begin
  if not isListEmpty(list) then
  begin
    if getListLength(list) > 1 then begin
      temp := list^.next;
      list^.next := temp^.next;
      temp^.next^.prev := temp^.prev;
      temp^.prev^.next := temp^.next;
      dispose(temp);
    end
    else
    begin
      temp := list^.next;
      list^.next := nil;
      dispose(temp);
    end;
  end
  else
    writeln('List is empty or does not exists, can`t delete element');
end;

procedure clearList(const list: TList);
begin
  while not isListEmpty(list) do
  begin
    deleteZeroElement(list);
  end;
end;

procedure deleteList(var list: TList);
begin
  if not isListEmpty(list) then
    clearList(list);
  dispose(list);
  list := nil;
end;

procedure createList(var list: TList);
begin
  if isListExists(list) then
    deleteList(list);
  new(list);
end;

procedure outputList(const note: String; list: TList); overload;
var
  i: Integer;
begin
  for i := 1 to getListLength(list) do
  begin
    writeln(note, list^.next^.value);
    list := list^.next;
  end;
end;

procedure outputList(const note: String; list: TList; const times: Integer); overload;
var
  i: Integer;
begin
  for i := 1 to getListLength(list)*times do
  begin
    writeln(note, list^.next^.value);
    list := list^.next;
  end;
end;

function getListAfterElement(list: TList; const position: Integer):TList;  //0, 1, 2, 3...
var
  i: Integer;
begin
  if isListExists(list) then
  begin
    for i := 1 to position do
    begin
      list := list^.next;
    end;
    result := list;
  end
  else
  begin
    result := nil;
    writeln('List is not extists');
  end;
end;

function getZeroElement(const list: TList):TValue;
begin
  result := list^.next^.value;
end;

function getNthElement(const list: TList; const position: Integer):TValue;
begin
  result := getZeroElement(getListAfterElement(list, position));
end;

procedure insertNthElement(const list: TList; const position: Integer; const value: TValue);
begin
  insertZeroElement(getListAfterElement(list, position), value);
end;

procedure deleteNthElement(const list: TList; const position: Integer);
begin
  deleteZeroElement(getListAfterElement(list, position));
end;

begin
  createList(list);
  for i := 10 downto 1 do
  begin
    insertZeroElement(list, i);
  end;
  outputList('1> ', list);

  writeln('Length: ', getListLength(list));

  outputList('2> ', getListAfterElement(list, 10));

  writeln('Zero element: ', getZeroElement(list));
  writeln('Nth element: ', getNthElement(list, 5));

  insertNthElement(list, 5, 0);
  deleteNthElement(list, 0);
  outputList('3> ', list);

  deleteList(list);
  readln;
end.
