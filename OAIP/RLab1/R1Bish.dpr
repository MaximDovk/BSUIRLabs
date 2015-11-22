{$APPTYPE CONSOLE}
uses
  Windows;

var
  amoBish, amoAns, y, z, x, exception: integer;
  amoCake, amoX, amoY, amoZ: real;
  str: string;
  e: boolean;

begin
  SetConsoleCP(1251);             //������� �����
  SetConsoleOutputCP(1251);       //  � �������

  x:=0;
  amoAns:=0;

  { ���� �����, ���� ����������� �� ������������ }
  repeat
  begin
    e:=false;

    { ���� ���-�� �������, ���������� ��������� � e }
    { ���������� val ��� ��������� ���� ������ }
    { �.�. val ����� 0 ��� ���������� ����� � ����. ����� }
    write('������� ���-�� �������: ');
    readln(str);
    val(str, amoCake, exception);
    if exception<>0 then
      e:=true;

    write('������� ���-�� �������: ');
    readln(str);
    val(str, amoBish, exception);
    if exception<>0 then
      e:=true;

    write('������� ������� ������� ��������� �����: ');
    readln(str);
    val(str, amoX, exception);
    if exception<>0 then
      e:=true;

    write('������� ������� ������� ������� �����: ');
    readln(str);
    val(str, amoY, exception);
    if exception<>0 then
      e:=true;

    write('������� ������� ������� ������: ');
    readln(str);
    val(str, amoZ, exception);
    if exception<>0 then
      e:=true;

    if e then
      exception:=1   //���������� ��� ������
    else
      exception:=0;

    { ��������� ��������� �� ������ ����� }
    if exception<>0 then
      writeln('�� ������ ������ ���������� ������, ���������� ������');
    if (amoBish<=0) and (exception=0) then
      writeln('���-�� ������� ������ ���� ������ 0');
    if (amoCake<=0) and (exception=0) then
      writeln('���-�� ������� ������ ���� ������ 0');
    if (amoX<0) and (exception=0) then
      writeln('��������� ������ �� ����� ���� ������������� ���-�� �������');
    if (amoY<0) and (exception=0) then
      writeln('������� ������ �� ����� ���� ������������� ���-�� �������');
    if (amoZ<0) and (exception=0) then
      writeln('������� �� ����� ���� ������������� ���-�� �������');
    if (amoX=0) and (amoY=0) and (amoZ=0) and (exception=0) then
      writeln('���� �� ���� �� ������� ������ ���� ������');
  end;
  until (exception=0) and (amoCake>0) and (amoBish>0) and
    (amoZ>=0) and (amoX>=0) and (amoY>=0) and not
    ((amoX=amoY) and (amoY=amoZ) and (amoY=0));

  { ���� ��������� ���������� }
  exception:=0;
  if (amoY=amoZ) then
    exception:=1;
  if (amoY=amoZ) and (amoZ=amoX) then
    exception:=2;
  if (amoX=amoZ) and (amoX=0) and (amoY<>0) then
    exception:=3;
  if (amoX=amoY) and (amoX=0) and (amoZ<>0) then
    exception:=4;

  { ���� ���������� + ����� ������� }
  case exception of
    { �������� ��� }
    { ����� ������ � ���������� }
    0:
      while x<=amoBish do
      begin
        y:=Round((amoCake-amoZ*amoBish+(amoZ-amoX)*x)/(amoY-amoZ));
        z:=amoBish-y-x;
        { ��������, �������� �� ������ x, y, z - �������� }
        { �������� � ������ ������������ real }
        if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001) and
          (y>=0) and (z>=0) and (x>=0) then
        begin
          writeln('�������: ', x, ' �������: ', y, ' �������: ', z);
          inc(amoAns);    //������� ���-�� �������
        end;
        inc(x);
      end;
    { ���������� 1, ��� ���� ������� ���� ������ ���-�� ������� }
    1:
      begin
        x:=Round((amoY*amoBish-amoCake)/(amoY-amoX));
        for y:=0 to amoBish-x do
        begin
          z:=amoBish-x-y;
          if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001) and
            (y>=0) and (z>=0) and (x>=0) then
          begin
            writeln('�������: ', x, ' �������: ', y, ' �������: ', z);
            inc(amoAns);
          end;
        end;
      end;
    { ���������� 2, ��� ���� ������� ���� ������ ���-�� ������� }
    { ��������� ���� ���������� ���� y � z, ������� - x }
    2:
      begin
        if amoBish*amoX=amoCake then
        begin
          for x:=0 to amoBish do
          begin
            for y:=0 to amoBish-x do
            begin
              z:=amoBish-x-y;
              if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001)
              and (y>=0) and (z>=0) and (x>=0) then
              begin
                writeln('�������: ', x, ' �������: ', y, ' �������: ', z);
                inc(amoAns);
              end;
            end;
          end;
        end;
      end;
    { ���������� 3, ���� ��� ���� ������� �� ����, � ������ ��� }
    { ��������, ����� �� 1 ��� ������� ������ ��� ������ }
    3:
      begin
        if amoCake/amoY = Round(amoCake/amoY) then
        begin
          y:=Round(amoCake/amoY);
          for x:=0 to amoBish-y do
          begin
            z:=amoBish-x-y;
            if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001)
            and (y>=0) and (z>=0) and (x>=0) then
            begin
              writeln('�������: ', x, ' �������: ', y, ' �������: ', z);
              inc(amoAns);
            end;
          end;
        end;
      end;
    { ���������� 4, ����� ��������, �� � ������ ����� ������� }
    4:
      begin
        if amoCake/amoZ = Round(amoCake/amoZ) then
        begin
          z:=Round(amoCake/amoZ);
          for x:=0 to amoBish-z do
          begin
            y:=amoBish-x-z;
            if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001)
            and (y>=0) and (z>=0) and (x>=0) then
            begin
              writeln('�������: ', x, ' �������: ', y, ' �������: ', z);
              inc(amoAns);
            end;
          end;
        end;
      end;
  end;

  { ���� ������ ���-�� ������� }
  if amoAns=0 then
    writeln('��� �������')
  else
    writeln('������� �������: ', amoAns);

  readln;       //����� �� ���������� ���������
end.

