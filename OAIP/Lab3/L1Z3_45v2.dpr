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
  write('������� ���������� ���������: ');
  readln(n);

  k:=1;
  writeln('��� ������: ');
  for i:=1 to n do
  begin
    { ���������� ������� ���������� ������� }
    A[i]:=random(10);
    write(A[i], ' '); //����� ����������� �������

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
