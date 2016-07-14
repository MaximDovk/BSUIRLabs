program R7;

{$APPTYPE CONSOLE}

uses
  Windows;

var
  n: integer;

function inputN():Integer;
begin
  repeat
    writeln('Введите количество крючков: ');
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
      writeln(str + 'И');
    end;
    3:
    begin
      result := 1;
      writeln(str + 'Ш');
    end
    else
      result := getVariants(n - 2, str + 'И') + getVariants(n - 3, str + 'Ш');
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  n := inputN();
  writeln('Варианты: ');
  writeln('Количество вариантов: ', getVariants(n, ''));
  readln;
end.
 