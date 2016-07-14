program L9;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TMatrix = array [1..3, 1..3] of real;

var
  a, b, c, temp1, temp2: TMatrix;

{ Ввод матриц А и B }
procedure inputAB(var a, b: TMatrix);
begin
  a[1, 1] := 2;
  a[1, 2] := 3;
  a[1, 3] := -1;
  a[2, 1] := 4;
  a[2, 2] := 5;
  a[2, 3] := 2;
  a[3, 1] := -1;
  a[3, 2] := 0;
  a[3, 3] := 7;
  
  b[1, 1] := -1;
  b[1, 2] := 0;
  b[1, 3] := 5;
  b[2, 1] := 0;
  b[2, 2] := 1;
  b[2, 3] := 3;
  b[3, 1] := 2;
  b[3, 2] := -2;
  b[3, 3] := 4;
end;
              
{ Произведение матриц }
function productMM(const a, b: TMatrix):TMatrix;
var
  i, j, k: integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      result[i, j] := 0;
      for k := 1 to 3 do
      begin
        result[i, j] := result[i, j] + a[i, k] * b[k, j];
      end;
    end;
  end;
end;

{ Произведение матрицы и числа }
function productNM(const num: Real; const a: TMatrix):TMatrix;
var
  i, j: integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      result[i, j] := num * a[i, j];
    end;
  end;
end;

{ Сумма матриц }
function addMM(const a, b: TMatrix; const sign: integer):TMatrix;
var
  i, j: integer;
begin
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      result[i, j] := a[i, j] + sign * b[i, j];
    end;
  end;
end;

{ Вывод матрицы }
procedure outputMatrix(const note: String; const a: TMatrix);
var
  i, j: integer;
begin
  writeln(note);
  for i := 1 to 3 do
  begin
    for j := 1 to 3 do
    begin
      write(a[i, j]:7:2, ' ');
    end;
    writeln;
  end;
  writeln;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  inputAB(a, b);
  outputMatrix('Матрица A', a);
  outputMatrix('Матрица B', b);
	temp1 := productNM(2, b);
	temp2 := addMM(temp1, a, -1);
	temp1 := addMM(temp1, a, 2);
  c := productMM(temp1, temp2);
  outputMatrix('Результат', c);
  readln;
end.
