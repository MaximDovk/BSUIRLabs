program lab2v2;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TList = ^TElem;
  TElem = record
    num: Integer;
    next: TList;
  end;

var
  list: TList;
  i, n, k: Integer;

function getNum(const note: String):Integer;
begin
  write(note);
  readln(result);
end;

procedure insert(list: TList; number: Integer);
var
  temp: TList;
begin
  new(temp);
  temp^.num := number;
  temp^.next := list^.next;
  list^.next := temp;
end;

procedure makeCircle(list: TList);
var
  temp: TList;
begin
  temp := list;
  while list^.next <> nil do
    list := list^.next;
  list^.next := temp^.next;
end;

procedure createList(const list: TList; const n: Integer);
var
  i: Integer;
begin
  for i := n downto 1 do
    insert(list, i);
  makeCircle(list);
end;

procedure delete(list: TList);
var
  temp: TList;
begin
  temp := list^.next;
  list^.next := temp^.next;
  dispose(temp);
end;

procedure countList(list: TList; n: Integer; const k: Integer; output: boolean);
var
  i: Integer;
begin
  while n > 1 do
  begin
    for i := 1 to k - 1 do
      list := list^.next;
    if output then
      writeln('Выбыл ', list^.next^.num, ' участник');
    delete(list);
    dec(n);
  end;
  writeln('Остался ', list^.next^.num, ' участник');
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  n := getNum('Введите количество участников: ');
  k := getNum('Введите шаг выбывания: ');
  if n = 64 then
  begin
    for i := 1 to 64 do
    begin
      write(i, ': ');
      new(list);
      list^.next := nil;
      createList(list, i);
      countList(list, i, k, false);
      list := nil;
    end;
  end
  else
  begin
    new(list);
    createList(list, n);
    countList(list, n, k, true);
    dispose(list);
  end;

  readln;
end.
