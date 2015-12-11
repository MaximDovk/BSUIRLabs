{$APPTYPE CONSOLE}

uses
  Windows;

type
  TDayOfWeek = (MON, TUR, WED, THU, FRI, SAT, SUN);
  TDay = 1..31;

var
  year, dateShift, yearShift, i, notVisYearShift: integer;
  firstOctSun: TDay;
  firstJan, firstOct: TDayOfWeek;

begin 
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  { ���� ����� }
  write('������� ���: ');
  {$I-}
  readln(year);
  while (IOResult<>0) or (year<1) do
  begin
    write('������� ���������� ��� �.�.: ');
    readln(year);
  end;
  {$I+}

  { ������� ���������� ����� ���� � ����� �� 28 ��� }
  { ��� ������ ����������� ������ 28 ��� }
  yearShift:=year mod 28;
  if yearShift = 0 then yearShift:=28;

  { ������� ����� ���� ������ ��-�� ����������� ��� }
  { ������������ 01.01.01 }
  notVisYearShift:=0;
  i:=100;
  while i<year do
  begin
    if not (i mod 400 = 0) then
      inc(notVisYearShift);
    inc(i, 100);
  end;

  { ���������� ��������� ����� �������� ���� ����� }
  { ����� ����� ���� ������ 1 ������ ������������ ���� }
  notVisYearShift:=notVisYearShift mod 7;
  yearShift:=(((yearShift-1) div 4) + (yearShift-1)) mod 7;
  dateShift:=7 + yearShift - notVisYearShift;

  { �������� ���� ������ 01.01 ������������ ���� }
  firstJan:=MON;
  for i:=1 to dateShift do
  begin
    if firstJan=SUN then
      firstJan:=MON
    else
      firstJan:=succ(firstJan);
  end; 

  { ���� ��� ����������� ���� ������ 1 ������� ��������� � 1 ������ }
  if ((year mod 4 = 0) and (year mod 100 <> 0)) or (year mod 400 = 0) then
    if firstJan=SUN then
      firstOct:=MON 
    else
      firstOct:=succ(firstJan)
  else
    firstOct:=firstJan;

  { ������� 1 ����������� � ������� }
  firstOctSun:=ord(SUN)-ord(firstOct)+1;

  writeln('������ ����������� ������� ', year, ' ���� ���������� �� ', firstOctSun, ' �����.');
  readln;
end.
