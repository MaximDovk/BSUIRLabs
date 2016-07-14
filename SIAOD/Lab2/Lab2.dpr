program lab2;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TDoubleList = ^TDoubleElem;
  TDoubleElem = record
    number: String[7];
    next, prev: TDoubleList;
  end;
  TSingleList = ^TSingleElem;
  TSingleElem = record
    number: String[7];
    next: TSingleList;
  end;

var
  fullList: TDoubleList;
  abonentList: TSingleList;

{ Добавление элемента в двунаправленный список }
procedure insert(list: TDoubleList; const number: String); overload;
var
  temp: TDoubleList;
begin
  new(temp);
  if list^.next <> nil then
    list^.next^.prev := temp;
  temp^.number := number;
  temp^.next := list^.next;
  temp^.prev := list;
  list^.next := temp;
end;

{ Добавление элемента в однонаправленный список }
procedure insert(list: TSingleList; const number: String); overload;
var
  temp: TSingleList;
begin
  new(temp);
  temp^.number := number;
  temp^.next := list^.next;
  list^.next := temp;
end;

{ Ввод номеров с клавиатуры }
procedure inputList(list: TDoubleList);
var
  i, n: integer;
  str: String;
begin
  write('Введите количество номеров: ');
  readln(n);
  for i := 1 to n do
  begin
    write('Введите номер телефона: ');
    readln(str);
    insert(list, str);
  end;
end;

{ Стандартный список номеров }
procedure defaultInput(list: TDoubleList);
begin
  insert(list, '1932289');
  insert(list, '101');
  insert(list, '6041917');
  insert(list, '102');
  insert(list, '1238840');
  insert(list, '103');
  insert(list, '5580702');
  insert(list, '104');
end;

{ Поиск конца списка }
function findEnd(list: TDoubleList):TDoubleList;
begin
  while list^.next <> nil do
    list := list^.next;
  result := list;
end;

{ Поиск позиции для вставки номера }
function findPos(list: TSingleList; const number: String):TSingleList;
begin
  while (list^.next <> nil) and (list^.next^.number < number) do
    list := list^.next;
  result := list;
end;

{ Поиск семизначных номеров }
procedure findAbonents(fullList: TDoubleList; list: TSingleList);
begin
  fullList := findEnd(fullList);
  while fullList^.prev <> nil do
  begin
    if length(fullList^.number) = 7 then
      insert(findPos(list, fullList^.number), fullList^.number);
    fullList := fullList^.prev
  end;
end;

{ Вывод двунаправленного списка }
procedure outputList(const note: String; list: TDoubleList); overload;
begin
  writeln(note);
  if list^.next = nil then
    writeln('Пустой');
  while list^.next <> nil do
  begin
    list := list^.next;
    writeln(list^.number);
  end;
end;

{ Вывод однонаправленного списка }
procedure outputList(const note: String; list: TSingleList); overload;
begin
  writeln(note);
  if list^.next = nil then
    writeln('Пустой');
  while list^.next <> nil do
  begin
    list := list^.next;
    writeln(list^.number);
  end;
end;

{ Удаление двунаправленного списка }
procedure clearList(list: TDoubleList); overload;
var
  temp: TDoubleList;
begin
  while list^.next <> nil do
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;

{ Удаление однонаправленного списка }
procedure clearList(list: TSingleList); overload;
var
  temp: TSingleList;
begin
  while list^.next <> nil do
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  new(fullList);
  new(abonentList);

  inputList(fullList);
  //defaultInput(fullList);
  outputList('Исходный список', fullList);

  findAbonents(fullList, abonentList);
  outputList('Полученный список', abonentList);

  clearList(fullList);
  clearList(abonentList);

  dispose(fullList);
  dispose(abonentList);
  readln;
end.
