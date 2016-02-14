program Pointers;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TPointer = ^Integer;
  TSimpleArray = array [1..10] of TPointer;
  TDoubleArray = array [1..10] of TSimpleArray;

var
  x, y, z: TPointer;
  A: TSimpleArray;
  B: TDoubleArray;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  if x = nil then
    writeln('Изначально указатель = nil');

  new(x);
  if x <> nil then
    writeln('После new он получает адрес и не равен nil');

  writeln('Нельзя вывести адрес с помошью "writeln(x)"');

  x^ := 5;
  inc(x^);
  x^ := sqr(x^);
  writeln('X^ - Открытие ссылки. X^ можно использовать как любую переменную');

  new(y);
  y^ := 10;

  x^ := y^;
  writeln('Можно копировать ЗНАЧЕНИЕ переменной');
  writeln('Теперь X^ = Y^, НО X <> Y');

  z := y; //Z был nil
  writeln('Можно копировать ССЫЛКУ');
  writeln('Теперь Z^ = Y^ и Z = Y');

  z^ := 5; //y^ = 5
  writeln('Но если мы поменяем z^, y^ тоже поменяется');

  y := x;
  writeln('Мы можем изменить указатель, который уже указывает куда-то');
  writeln('!!! НО если только он указывает на переменную');
  writeln('То мы потеряем её, но она всё равно будет занимать память!!!');

  writeln(Integer(y), ' Адрес можно вывести вот так');

  // x = y

  dispose(x);
  writeln(Integer(y), ' y всё ещё связан с памятью, но его нельзя открыть y^');
  writeln('Потому что мы освободили эту память с помощью dispose(x)');

  inc(y);
  writeln(Integer(y), ' Мы можем увеличивать и уменьшать указатель на n, но само значение увеличивается на n*sizeOf(y^) = 4');
  dec(y, 2);

  readln;
end.
 