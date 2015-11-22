{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

var
  lastTime, time: integer;
  amoRed, amoGreen, temp: int64;
  flag1, flag2, exc: boolean;  //����� ����������

begin
  SetConsoleCP(1251);             //������� �����
  SetConsoleOutputCP(1251);       //  � �������

  flag1:=false; flag2:=false;

  { ���� ����� }
  repeat
  begin
    exc:=false;
    write('������� ������������ ����: ');
    readln(lastTime);
    write('������� ��������� ���-�� ������� ��������: ');
    readln(amoRed);
    write('������� ��������� ���-�� ������ ��������: ');
    readln(amoGreen);
    { IOResult ���������� ��� ������ }
    if IOResult<>0 then
    begin
      writeln('������� ���������� �������� ������.');
      exc:=true;
    end;
  end;
  until not exc;

  { �������� �������� ������ }
  if (lastTime<=0) or (amoRed<0) or (amoGreen<0) then
    flag1:=true;

  { ���� ���������� }
  { ��������� ���-�� ������� �������� }
  { ����������� ���-�� ������� �� ���-�� ������� }
  { ������� ����� ���������� ����� ������������ � ������� }
  time:=1;
  while (time<=lastTime) and not flag2 and not flag1 do
  begin
    temp:=amoGreen;
    inc(amoGreen, amoRed);
    amoRed:=temp;
    { �������� � ��������� ����� }
    { ��� ������ �� ������� ���� ������ }
    if (amoRed<0) or (amoGreen<0) then
      flag2:=true;
    inc(time);
  end;

  { ���� ������ + ���������� }
  if flag2=true then
    writeln('����� �� ������� ���� ������, ���������� ������� �������� ������')
  else
  begin
    if flag1=true then
      writeln('�������� ������ ������ ���� ������ ����')
    else
    begin
      if amoRed+amoGreen<0 then
        writeln('�� ', lastTime, '-�� ����� ', amoRed, ' ������� �������� � ', amoGreen, ' ������')
      else
        writeln('�� ', lastTime, '-�� ����� ', amoRed+amoGreen, ' ��������: ', amoRed, ' ������� � ', amoGreen, ' ������');
    end;
  end;

  readln;   //�����
end.

 
