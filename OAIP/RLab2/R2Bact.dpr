{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

var
  lastTime, time: integer;
  amoRed, amoGreen, temp: int64;
  flag1, flag2, exc: boolean;  //Флаги исключений

begin
  SetConsoleCP(1251);             //Русский текст
  SetConsoleOutputCP(1251);       //  в консоли

  flag1:=false; flag2:=false;

  { Блок ввода }
  repeat
  begin
    exc:=false;
    write('Введите интересующий такт: ');
    readln(lastTime);
    write('Введите начальное кол-во красных бактерий: ');
    readln(amoRed);
    write('Введите начальное кол-во зелёных бактерий: ');
    readln(amoGreen);
    { IOResult возвращает код ошибки }
    if IOResult<>0 then
    begin
      writeln('Введите корректные исходные данные.');
      exc:=true;
    end;
  end;
  until not exc;

  { Проверка введённых данных }
  if (lastTime<=0) or (amoRed<0) or (amoGreen<0) then
    flag1:=true;

  { Блок вычислений }
  { Сохраняем кол-во зеленых бактерий }
  { Увеличиваем кол-во зеленых на кол-во красных }
  { Зеленые после последнего цикла превращаются в красные }
  time:=1;
  while (time<=lastTime) and not flag2 and not flag1 do
  begin
    temp:=amoGreen;
    inc(amoGreen, amoRed);
    amoRed:=temp;
    { Проверка и остановка цикла }
    { При выходе за пределы типа данных }
    if (amoRed<0) or (amoGreen<0) then
      flag2:=true;
    inc(time);
  end;

  { Блок вывода + исключения }
  if flag2=true then
    writeln('Выход за пределы типа данных, попробуйте меньшие исходные данные')
  else
  begin
    if flag1=true then
      writeln('Исходные данные должны быть больше нуля')
    else
    begin
      if amoRed+amoGreen<0 then
        writeln('На ', lastTime, '-ом такте ', amoRed, ' красных бактерий и ', amoGreen, ' зелёных')
      else
        writeln('На ', lastTime, '-ом такте ', amoRed+amoGreen, ' бактерий: ', amoRed, ' красных и ', amoGreen, ' зелёных');
    end;
  end;

  readln;   //Пауза
end.

 
