{$APPTYPE CONSOLE}

uses
  Windows;

const
  n = 15;
  A: array [1..n] of integer = (15, 8, 31, 3, 8, 1, -5, 12, -5, 31, 33, 3, 8, -15, 0);

type
  TResArray = array [1..n] of integer;

var
  i, k, x: integer;
  B, C: TResArray;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  k:=1;
  writeln('��� ������: ');
  for i:=1 to n do
  begin
    write(A[i], ' '); //����� �������

    x:=1;
    { ��������, �������� �� ������� }
    { ������ I-��� � ��������� }
    { ���� x=k, ������ �� �������� }
    { ���� x=k, ������ x ����� ������� � ������� ���������� }
    while (B[x]<>A[i]) and (x<k) do
      inc(x);

    { ��������� ������� � ������ ���������� }
    if x=k then
    begin
      B[k]:=A[i];
      C[k]:=1;
      inc(k);
    end
    { �����, ����������� ���������� ��������� ������ I-��� }
    else
      inc(C[x]);
  end;

  { ������� ������� ���������� }
  writeln;
  writeln('������� | ����������');
  writeln('| ����������':20);
  for i:=1 to k-1 do
    writeln(B[i]:7, ' | ', C[i]:10);
  readln;
end.
