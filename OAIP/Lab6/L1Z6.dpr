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

  { ������������� ������� ���������� ������� }
  for i:=1 to 8 do
    for j:=1 to 10 do
      X[i, j]:=random(100)+1;

  { ����� ������� }
  writeln(' �������� �������: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;

  { ���������� ��������� ����� �� ������������� }
  { ��������� � ��������� ��������� }
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

  { ����� ������� }
  writeln(chr(10), ' �������, ���������� ����� ���������� ��������� ����� �� �������������: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;

  { ���������� ����� ������� ������� �� 10 �������� }
  { ������������ ������ ����������� � X[0] }
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

  { ����� ������� }
  writeln(chr(10), ' ���������� �������: ');
  for i:=1 to 8 do
  begin
    for j:=1 to 10 do
      write(' ', X[i, j]:3);
    writeln;
  end;
  readln;
end.