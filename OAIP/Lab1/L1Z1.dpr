{$APPTYPE CONSOLE}

var
  x, y, sum: real;
  n: integer;

begin
  x:=0.5;   //������������� ���������

  { ���� �������� x �� 0.5 �� 1.4 }
  while x<=1.4 do
  begin
    sum:=0;

    { ��������� ���� �������� n �� 1 �� 15 }
    for n:=1 to 15 do
    begin
      { ���������� ����� }
      sum:=sum+sqrt(exp(-n*x)+exp((n-1)*ln(x)))/(cos(n*x)+sin(n*x));

      { ������� y ��� �������� ����� � ����� }
      if n>=10 then
      begin
        y:=arctan(x)+sqrt(n*exp(ln(x)/3))-sum;
        writeln('x=', x:0:2, ' n=', n, ' y=', y:9:4);
      end;
    end;
    x:=x+0.15;   //��������� ��������� �����
  end;

  readln;   //�����
end.
