{$APPTYPE CONSOLE}
uses
  Windows;

var
  amoBish, amoAns, y, z, x, exception: integer;
  amoCake, amoX, amoY, amoZ: real;
  str: string;
  e: boolean;

begin
  SetConsoleCP(1251);             //Русский текст
  SetConsoleOutputCP(1251);       //  в консоли

  x:=0;
  amoAns:=0;

  { Блок ввода, ввод проверяется на корректность }
  repeat
  begin
    e:=false;

    { Ввод кол-ва пирогов, исключение сохраняем в e }
    { Используем val для получения кода ошибки }
    { Т.к. val вернёт 0 при корректном вводе в след. блоке }
    write('Введите кол-во пирогов: ');
    readln(str);
    val(str, amoCake, exception);
    if exception<>0 then
      e:=true;

    write('Введите кол-во монахов: ');
    readln(str);
    val(str, amoBish, exception);
    if exception<>0 then
      e:=true;

    write('Сколько пирогов съедает верховный монах: ');
    readln(str);
    val(str, amoX, exception);
    if exception<>0 then
      e:=true;

    write('Сколько пирогов съедает простой монах: ');
    readln(str);
    val(str, amoY, exception);
    if exception<>0 then
      e:=true;

    write('Сколько пирогов съедает ученик: ');
    readln(str);
    val(str, amoZ, exception);
    if exception<>0 then
      e:=true;

    if e then
      exception:=1   //Возвращаем код ошибки
    else
      exception:=0;

    { Различные сообщения об ошибке ввода }
    if exception<>0 then
      writeln('Вы должны ввести корректные данные, попробуйте заново');
    if (amoBish<=0) and (exception=0) then
      writeln('Кол-во монахов должно быть больше 0');
    if (amoCake<=0) and (exception=0) then
      writeln('Кол-во пирогов должно быть больше 0');
    if (amoX<0) and (exception=0) then
      writeln('Верховные монахи не могут есть отрицательное кол-во пирогов');
    if (amoY<0) and (exception=0) then
      writeln('Простые монахи не могут есть отрицательное кол-во пирогов');
    if (amoZ<0) and (exception=0) then
      writeln('Ученики не могут есть отрицательное кол-во пирогов');
    if (amoX=0) and (amoY=0) and (amoZ=0) and (exception=0) then
      writeln('Хотя бы один из монахов должен есть пироги');
  end;
  until (exception=0) and (amoCake>0) and (amoBish>0) and
    (amoZ>=0) and (amoX>=0) and (amoY>=0) and not
    ((amoX=amoY) and (amoY=amoZ) and (amoY=0));

  { Блок обработки исключений }
  exception:=0;
  if (amoY=amoZ) then
    exception:=1;
  if (amoY=amoZ) and (amoZ=amoX) then
    exception:=2;
  if (amoX=amoZ) and (amoX=0) and (amoY<>0) then
    exception:=3;
  if (amoX=amoY) and (amoX=0) and (amoZ<>0) then
    exception:=4;

  { Блок вычислений + вывод решений }
  case exception of
    { Основной код }
    { Вывод формул в приложении }
    0:
      while x<=amoBish do
      begin
        y:=Round((amoCake-amoZ*amoBish+(amoZ-amoX)*x)/(amoY-amoZ));
        z:=amoBish-y-x;
        { Проверка, являются ли данные x, y, z - решением }
        { Проверка с учётом погрешностей real }
        if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001) and
          (y>=0) and (z>=0) and (x>=0) then
        begin
          writeln('Ведущие: ', x, ' Простые: ', y, ' Ученики: ', z);
          inc(amoAns);    //Подсчёт кол-ва решений
        end;
        inc(x);
      end;
    { Исключение 1, два типа монахов едят равное кол-во пирогов }
    1:
      begin
        x:=Round((amoY*amoBish-amoCake)/(amoY-amoX));
        for y:=0 to amoBish-x do
        begin
          z:=amoBish-x-y;
          if (abs(amoX*x+amoY*y+amoZ*z-amoCake)<0.000000001) and
            (y>=0) and (z>=0) and (x>=0) then
          begin
            writeln('Ведущие: ', x, ' Простые: ', y, ' Ученики: ', z);
            inc(amoAns);
          end;
        end;
      end;
    { Исключение 2, три типа монахов едят равное кол-во пирогов }
    { Вложенный цикл перебирает пары y и z, внешний - x }
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
                writeln('Ведущие: ', x, ' Простые: ', y, ' Ученики: ', z);
                inc(amoAns);
              end;
            end;
          end;
        end;
      end;
    { Исключение 3, если два вида монахов не едят, а третий ест }
    { Проверка, может ли 1 тип монахов съесть все пироги }
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
              writeln('Ведущие: ', x, ' Простые: ', y, ' Ученики: ', z);
              inc(amoAns);
            end;
          end;
        end;
      end;
    { Исключение 4, копия третьего, но с другой парой монахов }
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
              writeln('Ведущие: ', x, ' Простые: ', y, ' Ученики: ', z);
              inc(amoAns);
            end;
          end;
        end;
      end;
  end;

  { Блок вывода кол-ва решений }
  if amoAns=0 then
    writeln('Нет решений')
  else
    writeln('Найдено решений: ', amoAns);

  readln;       //Пауза по завершении программы
end.

