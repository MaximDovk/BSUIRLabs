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
    writeln('���������� ��������� = nil');

  new(x);
  if x <> nil then
    writeln('����� new �� �������� ����� � �� ����� nil');

  writeln('������ ������� ����� � ������� "writeln(x)"');

  x^ := 5;
  inc(x^);
  x^ := sqr(x^);
  writeln('X^ - �������� ������. X^ ����� ������������ ��� ����� ����������');

  new(y);
  y^ := 10;

  x^ := y^;
  writeln('����� ���������� �������� ����������');
  writeln('������ X^ = Y^, �� X <> Y');

  z := y; //Z ��� nil
  writeln('����� ���������� ������');
  writeln('������ Z^ = Y^ � Z = Y');

  z^ := 5; //y^ = 5
  writeln('�� ���� �� �������� z^, y^ ���� ����������');

  y := x;
  writeln('�� ����� �������� ���������, ������� ��� ��������� ����-��');
  writeln('!!! �� ���� ������ �� ��������� �� ����������');
  writeln('�� �� �������� �, �� ��� �� ����� ����� �������� ������!!!');

  writeln(Integer(y), ' ����� ����� ������� ��� ���');

  // x = y

  dispose(x);
  writeln(Integer(y), ' y �� ��� ������ � �������, �� ��� ������ ������� y^');
  writeln('������ ��� �� ���������� ��� ������ � ������� dispose(x)');

  inc(y);
  writeln(Integer(y), ' �� ����� ����������� � ��������� ��������� �� n, �� ���� �������� ������������� �� n*sizeOf(y^) = 4');
  dec(y, 2);

  readln;
end.
 