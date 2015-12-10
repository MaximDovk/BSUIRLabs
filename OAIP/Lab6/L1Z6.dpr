{$APPTYPE CONSOLE}

uses
  Windows;

var
  i, j, k, max: integer;
  X: array [0..8, 0..10] of integer;
  
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  randomize;

  { Инициализация матрицы случайными числами }
  for i:=1 to 8 do
    for j:=1 to 10 do
      X[i, j]:=random(100)+1;

  { Вывод матрицы }
  writeln(' Исходная матрица: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;

  { Сортировка элементов строк по невозрастанию }
  { Вставками с барьерным элементом }
  for i:=1 to 8 do
  begin
    for j:=2 to 10 do
    begin
      k:=j;
      X[i, 0]:=X[i, j];
      while X[i, k-1]<X[i, 0] do
      begin
        X[i, k]:=X[i, k-1];
        dec(k);
      end;
      X[i, k]:=X[i, 0];
    end;
  end;

  { Вывод матрицы }
  writeln(chr(10), ' Матрица, полученная после сортировки элементов строк по невозрастанию: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;

  { Сортировка строк простым выбором по 10 элементу }
  { Запоминаемая строка сохраняется в X[0] }
  for i:=8 downto 2 do
  begin
    max:=1;
    for j:=1 to i do
      if X[j, 10]>X[max, 10] then
        max:=j;
    X[0]:=X[max];
    X[max]:=X[i];
    X[i]:=X[0];
  end;

  { Вывод матрицы }
  writeln(chr(10), ' Полученная матрица: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;
  readln;
end.