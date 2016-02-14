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
  new(list);                //Создание верхушки списка

  createList(list);         //Создание списка

  writeln('Default list: ');
  outputList('1> ', list);  //Вывод списка

  writeln('Insert "0": ');
  insert(list, 0);          //Вставка в начало списка элемента "0"
  outputList('2> ', list);  //Вывод списка

  writeln('Delete first element: ');
  deleteNext(list);         //Удаление элемента списка
  outputList('3> ', list);  //Вывод списка

  writeln('Position of "3": ', findInList(list, 3));  //Поиск элемента "3" в списке
  writeln('Length: ', getListLength(list));  //Вывод длины списка
  writeln;

  writeln('Elements after position "3": ');
  outputList('4> ', getRest(list, 3)); //Вывод списка, находящегося после элемента "3"

  writeln('Insert "10" on "third" position: ');
  insertOn(list, 10, 3);    //Вставка элемента "10" на позицию 3
  outputList('5> ', list);  //Вывод списка

  writeln('Delete element on "third" position: ');
  deleteOn(list, 3);        //Удаление элемента с позиции 3
  outputList('6> ', list);  //Вывод списка

  writeln('Clear list: ');
  clearList(list);          //Освобождениие памяти от элементов списка
  outputList('7> ', list);  //Вывод списка

  dispose(list);            //Освобождение верхушки списка

  readln;
end.
