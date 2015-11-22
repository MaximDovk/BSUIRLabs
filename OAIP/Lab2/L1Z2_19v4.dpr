{$APPTYPE CONSOLE}

uses
  Windows;

var
  curN, ans, n, res, lenC, copy: int64;
  lastLen, fc, lenM, lastI, i: int64;
  flag: boolean;
  cy: extended;

begin
  { Русский язык в консоли }
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  { Ввод исходных данных }
  write('Введите N: ');
  readln(n);

  { Инициализация перменных }
  CurN:=1;
  ans:=0;

  { Поиск чисел, пока не найдём n-ное }
  while ans<n do
  begin
    flag:=true;
    i:=2;
    { Копируем проверяемое значение в extended }
    cy:=CurN;

    { Поиск простых чисел }
    while (flag) and (i<sqrt(cy)) do
    begin
      if CurN mod i = 0 then
        flag:=false;
      inc(i);
    end;

    { Если текущее число простое }
    if flag then
    begin
	
      { Вычисление суммы цифр квадрата простого числа }
      lenC:=0;
      fc:=curN*curN;
      while fc>0 do
      begin
        lenC:=lenC+(fc mod 10);
        fc:=fc div 10;
      end;

      { Вычисление суммы цифр простого числа }
      lenM:=0;
      fc:=curN;
      while fc>0 do
      begin
        lenM:=lenM+(fc mod 10);
        fc:=fc div 10;
      end;

      { Если сумма цифр простого числа }
      { В 2 раза меньше суммы цифр его квадрата }
      if 2*lenM=lenC then
      begin
        i:=2;
        { lastI и lastLen сохраняют значения }
        { I и суммы цифр I, для предотвращения лишних пересчётов}
        lastI:=2;
        lastLen:=2;
        res:=0;
        copy:=lenC;
        { Находим сумму цифр простых множителей числа равного }
        { Сумме цифр квадрата простого числа }
        while copy>1 do
        begin
          { Если I является делителем copy }
          if copy mod i = 0 then
          begin
            copy:=copy div i;
            { Если I изменилось, то пересчитваем его сумму цифр }
            if i<>lastI then
            begin
              lastLen:=0;
              fc:=i;
              { Вычисление новой суммы цифр }
              while fc>0 do
              begin
                lastLen:=lastLen+(fc mod 10);
                fc:=fc div 10;
              end;
              lastI:=i;
			end;
            res:=res+lastLen;
          end
          else
            inc(i);
        end;
        { Вычисление суммы цифр числа равного }
        { Сумме цифр квадрата простого числа  }
        lenM:=0;
        fc:=lenC;
        while fc>0 do
        begin
          lenM:=lenM+(fc mod 10);
          fc:=fc div 10;
        end;
        { Если эта сумма цифр является числом Смита }
        { Значит мы нашли одно из искомых чисел }
        { Увеличиваем количество найденных чисел на 1 }
        if res=lenM then
          inc(ans);
      end;
    end;
    { Переходим к проверке следующего числа }
    inc(CurN);
  end;

  { Если нашли последнее число, то выводим его }
  writeln(n, '-ое число Смита = ', (curN-1)*(curN-1));
  readln;
end.
