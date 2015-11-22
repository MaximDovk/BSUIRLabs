{$APPTYPE CONSOLE}

var
  x, y, sum: real;
  n: integer;

begin
  x:=0.5;   //Инициализация параметра

  { Цикл перебора x от 0.5 до 1.4 }
  while x<=1.4 do
  begin
    sum:=0;

    { Вложенный цикл перебора n от 1 до 15 }
    for n:=1 to 15 do
    begin
      { Вычисление суммы }
      sum:=sum+sqrt(exp(-n*x)+exp((n-1)*ln(x)))/(cos(n*x)+sin(n*x));

      { Подсчёт y для заданной суммы и вывод }
      if n>=10 then
      begin
        y:=arctan(x)+sqrt(n*exp(ln(x)/3))-sum;
        writeln('x=', x:0:2, ' n=', n, ' y=', y:9:4);
      end;
    end;
    x:=x+0.15;   //Изменение параметра цикла
  end;

  readln;   //Пауза
end.
