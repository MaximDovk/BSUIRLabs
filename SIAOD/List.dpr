program lists;

{$APPTYPE CONSOLE}

type
  TValue = Integer;
  TList = ^TElement;
  TElement = record
    value: TValue;
    next: TList;
  end;

var
  list: TList;

procedure createList(list: TList);
var
  n, i: Integer;
begin
  write('Enter N: ');
  readln(n);
  for i := 1 to n do
  begin
    new(list^.next);
    list^.next^.next := nil;
    list := list^.next;
    write('Enter element: ');
    readln(list^.value);
  end;
end;

procedure outputList(const note: String; list: TList);
begin
  while list^.next <> nil do
  begin
    writeln(note, list^.next^.value);
    list := list^.next;
  end;
  writeln;
end;

procedure deleteNext(list: TList);
var
  temp: TList;
begin
  temp := list^.next;
  list^.next := list^.next^.next;
  dispose(temp);
end;

procedure insert(list: TList; const value: TValue);
var
  temp: TList;
begin    
  new(temp);
  temp^.value := value;
  temp^.next := list^.next;
  list^.next := temp;
end;

procedure clearList(list: TList);
begin
  while list^.next <> nil do
  begin
    deleteNext(list);
  end;
end;

function findInList(list: TList; const value: TValue):Integer;
var
  n: Integer;
begin
  result := -1;
  n := 1;
  while list^.next <> nil do
  begin
    if list^.next^.value = value then
      result := n;
    list := list^.next;
    inc(n);
  end
end;

function getListLength(list: TList):Integer;
begin
  result:=0;
  while list^.next <> nil do
  begin
    inc(result);
    list := list^.next;
  end;
end;

procedure insertOn (list: TList; const value: TValue; const position: Integer);
var
  n: Integer;
begin
  if position > getListLength(list)+1 then
    writeln('ERROR. Can`t insert element. Position > Length of list')
  else
  begin
    for n:=1 to position-1 do
      list := list^.next;
    insert(list, value);
  end;
end;

procedure deleteOn (list: TList; const position: Integer);
var
  n: Integer;
begin
  if position > getListLength(list) then
    writeln('ERROR. Can`t delete element. Position > Length of list')
  else
  begin
    for n:=1 to position-1 do
      list := list^.next;
    deleteNext(list);
  end;
end;

function getRest(list: TList; const position: Integer):TList;
var
  n: Integer;
begin
  if position > getListLength(list) then
    writeln('ERROR. Position > Length of list')
  else
  begin
    for n:=1 to position do
      list := list^.next;
  end;                   
  result := list;
end;


begin
  new(list);                //�������� �������� ������

  createList(list);         //�������� ������

  writeln('Default list: ');
  outputList('1> ', list);  //����� ������

  writeln('Insert "0": ');
  insert(list, 0);          //������� � ������ ������ �������� "0"
  outputList('2> ', list);  //����� ������

  writeln('Delete first element: ');
  deleteNext(list);         //�������� �������� ������
  outputList('3> ', list);  //����� ������

  writeln('Position of "3": ', findInList(list, 3));  //����� �������� "3" � ������
  writeln('Length: ', getListLength(list));  //����� ����� ������
  writeln;

  writeln('Elements after position "3": ');
  outputList('4> ', getRest(list, 3)); //����� ������, ������������ ����� �������� "3"

  writeln('Insert "10" on "third" position: ');
  insertOn(list, 10, 3);    //������� �������� "10" �� ������� 3
  outputList('5> ', list);  //����� ������

  writeln('Delete element on "third" position: ');
  deleteOn(list, 3);        //�������� �������� � ������� 3
  outputList('6> ', list);  //����� ������

  writeln('Clear list: ');
  clearList(list);          //������������� ������ �� ��������� ������
  outputList('7> ', list);  //����� ������

  dispose(list);            //������������ �������� ������

  readln;
end.
