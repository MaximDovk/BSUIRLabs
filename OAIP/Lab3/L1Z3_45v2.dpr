{$APPTYPE CONSOLE}

uses
  Windows;

const
  en = 1000;

type
  TArray = array [1..en] of integer;

var
  n, i, k, x: integer;
  A, B, C: TArray;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  randomize;
  write('Введите количество элементов: ');
  readln(n);

  k:=1;
  writeln('Наш массив: ');
  for i:=1 to n do
  begin
    { Заполнение массива случайными числами }
    A[i]:=random(10);
    write(A[i], ' '); //Вывод полученного массива

    x:=1;
    { Проверка, добавлен ли элемент }
    { Равный I-ому в результат }
    { Если x=k, значит не добавлен }
    { Если x=k, значит x равен индексу в массиве результата }
    while (B[x]<>A[i]) and (x<k) do
      inc(x);

    { Добавляем элемент в массив результата }
    if x=k then
    begin
      B[k]:=A[i];
      C[k]:=1;
      inc(k);
    end
    { Иначе, увеличиваем количество элементов равных I-ому }
    else
      inc(C[x]);
  end;

  { Выводим массивы результата }
  writeln;
  writeln('Элемент | Количество');
  writeln('| повторений':20);
  for i:=1 to k-1 do
    writeln(B[i]:7, ' | ', C[i]:10);
  readln;
end.
