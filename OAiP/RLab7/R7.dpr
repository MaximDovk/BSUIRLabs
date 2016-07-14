program R7;

{$APPTYPE CONSOLE}

uses
  Windows;

var
  n: integer;

function inputN():Integer;
begin
  repeat
    writeln('������� ���������� �������: ');
    readln(result);
  until result >= 0;
end;

function getVariants(const n: integer; const str: String):integer;
begin
  case n of
    0, 1:
      result := 0;
    2:
    begin
      result := 1;
      writeln(str + '�');
    end;
    3:
    begin
      result := 1;
      writeln(str + '�');
    end
    else
      result := getVariants(n - 2, str + '�') + getVariants(n - 3, str + '�');
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  n := inputN();
  writeln('��������: ');
  writeln('���������� ���������: ', getVariants(n, ''));
  readln;
end.
 