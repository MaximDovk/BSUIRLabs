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

  { Блок ввода }
  write('Введите год: ');
  {$I-}
  readln(year);
  while (IOResult<>0) or (year<1) do
  begin
    write('Введите корректный год Н.Э.: ');
    readln(year);
  end;
  {$I+}

  { Находим порядковый номер года в серии из 28 лет }
  { Дни недели повторяются каждые 28 лет }
  yearShift:=year mod 28;
  if yearShift = 0 then yearShift:=28;

  { Находим сдвиг дней недели из-за невискосных лет }
  { Относительно 01.01.01 }
  notVisYearShift:=0;
  i:=100;
  while i<year do
  begin
    if not (i mod 400 = 0) then
      inc(notVisYearShift);
    inc(i, 100);
  end;

  { Определяем насколько нужно сдвинуть даты вперёд }
  { Чтобы найти день недели 1 января проверяемого года }
  notVisYearShift:=notVisYearShift mod 7;
  yearShift:=(((yearShift-1) div 4) + (yearShift-1)) mod 7;
  dateShift:=7 + yearShift - notVisYearShift;

  { Сдвигаем день недели 01.01 проверяемого года }
  firstJan:=MON;
  for i:=1 to dateShift do
  begin
    if firstJan=SUN then
      firstJan:=MON
    else
      firstJan:=succ(firstJan);
  end; 

  { Если год невискосный день недели 1 октября совпадает с 1 января }
  if ((year mod 4 = 0) and (year mod 100 <> 0)) or (year mod 400 = 0) then
    if firstJan=SUN then
      firstOct:=MON 
    else
      firstOct:=succ(firstJan)
  else
    firstOct:=firstJan;

  { Находим 1 воскресенье в октябре }
  firstOctSun:=ord(SUN)-ord(firstOct)+1;

  writeln('Первое воскресенье октября ', year, ' года приходится на ', firstOctSun, ' число.');
  readln;
end.
