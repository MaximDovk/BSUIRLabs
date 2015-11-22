{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

var
  amoFloppy, S, M, B, S1, M1, B1: int64;
  exc: boolean;
  badP, goodP, bestP: real;
const
  priceS=11.5; priceM=114.5; priceB=1255;
begin
  SetConsoleCP(1251);           //Русский текст
  SetConsoleOutputCP(1251);     //  в консоли

  { Блок ввода }
  repeat
  begin
    exc:=false;
    write('Введите кол-во дискет: ');
    readln(amoFloppy);
    { При некорректных, отрицательных или слишком больших }
    { Исходных данных выводим ошибку }
    if (IOResult<>0) or (amoFloppy<=0) or
      (amoFloppy>High(int64)/11.5) then
    begin
      writeln('Введите корректные исходные данные');
      exc:=true;
    end;
  end;
  until not exc;

  { Вычисление худшей цены }
  badP:=amoFloppy*priceS;

  { Вычисление средней цены }
  B:=amoFloppy div 144;
  M:=amoFloppy mod 144 div 12;
  S:=amoFloppy mod 144 mod 12;
  goodP:=B*priceB+M*priceM+S*priceS;

  { Вычисление лучшей цены }
  B1:=B;
  M1:=M;
  S1:=S;
  { Если дискет менее 11, то покупаем вместо дискет коробку }
  if S1 >= 10 then
  begin
    s1:=0;
    inc(M1);
  end;
  { Если коробок менее 12, то покупаем вместо коробок ящик }
  if M1 >= 11 then
  begin
    m1:=0;
    s1:=0;
    inc(B1);
  end;
  bestP:=B1*priceB+M1*priceM+S1*priceS;

  { Блок вывода }
  { Предусмотрены различные склонения }
  { Вывод цены без "0 копеек" }
  { Разделён условиями на несколько блоков }
  { Если все цены равны, то выполняется "Блок 1" и выводит цену 1 раз }
  { Если средняя цена равна другой, то выполняется "Блок 2" }
  { Если все цены различны, то выполняется "Блок 3" }
  { Вывод бонуса и разницы в ценах, между средней и лучшей }

  if (bestP=goodP) and (goodP=badP) then      //Блок 1
  begin
    { Вывод лучше цены без копеек }
    write('Лучшая цена - ', Trunc(bestP), ' руб. ');
    { Если кол-во копеек больше 0, то вывод }
    if Round(Frac(bestP)*100)=50 then
      write('50 коп.');
    writeln;
    write('За ');
    { Склонение, "дискеты" при 2, "дискету" при 1}
    if S1=2 then
      write(S1, ' дискеты')
    else
      if S1=1 then
        write(S1, ' дискету')
      else
        write(S1, ' дискет');
    writeln;
  end

  else
  begin
    if (goodP=badP) or (bestP=goodP) then     //Блок 2
    begin
      { Вывод худшей цены, т.к. она отличается от лучшей }
      write('Худшая цена - ', Trunc(badP), ' руб. ');
      if Round(Frac(badP)*100)=50 then
        write('50 коп.');
      writeln;
      writeln;

      { Копия блока 1 + склонение "ящика" и "коробки"}
      write('Лучшая цена - ', Trunc(bestP), ' руб. ');
      if Round(Frac(bestP)*100)=50 then
        write('50 коп.');
      writeln;
      write('За ');
      if B1>0 then
      begin     //При 2, 22.., 3, 23.., 4, 24.. вывод "ящика"
        if ((B1 mod 10 = 2) or (B1 mod 10 = 3) or
          (B1 mod 10 = 4)) and ((B1>=22) or (B1=2) or
          (B1=3) or (B1=4)) then
          write(B1, ' ящика ')
        else    //При 1, 21.. вывод "ящик"
          if (B1 mod 10 = 1) and ((B1>=21) or (B1=1)) then
            write(B1, ' ящик ')
          else
            write(B1, ' ящиков ');
      end;

      if M1>0 then
      begin
        if (M1=2) or (M1=3) or (M1=4) then
          write(M1, ' коробки ')
        else
          if M1=1 then
            write(M1, ' коробку ')
          else
            write(M1, ' коробок ');
      end;

      if S1>0 then
        begin
        if (S1=2) or (S1=3) or (S1=4) then
          write(S1, ' дискеты ')
        else
          if S1=1 then
            write(S1, ' дискету ')
          else
            write(S1, ' дискет ');
      end;
    end
    else
    begin   //Блок 3
      { Вывод худшей цены }
      write('Худшая цена - ', Trunc(badP), ' руб. ');
      if Round(Frac(badP)*100)=50 then
        write('50 коп.');
      writeln;
      writeln;

      {Вывод среднец цены, копия предыдущего кода}
      write('Средняя цена - ', Trunc(goodP), ' руб. ');
      if Round(Frac(goodP)*100)=50 then
        write('50 коп.');
      writeln;
      write('За ');
      if B>0 then
      begin
        if ((B mod 10 = 2) or (B mod 10 = 3) or
          (B mod 10 = 4)) and ((B>=22) or (B=2) or
          (B=3) or (B=4)) then
          write(B, ' ящика ')
        else
          if (B mod 10 = 1) and ((B>=21) or (B=1)) then
            write(B, ' ящик ')
          else
            write(B, ' ящиков ');
      end;
      if M>0 then
      begin
        if (M=2) or (M=3) or (M=4) then
          write(M, ' коробки ')
        else
          if M=1 then
            write(M, ' коробку ')
          else
            write(M, ' коробок ');
      end;
      if S>0 then
      begin
        if (S=2) or (S=3) or (S=4) then
          write(S, ' дискеты ')
        else
          if S=1 then
            write(S, ' дискету ')
          else
            write(S, ' дискет ');
      end;
      writeln;
      writeln;

      { Вывод лучшей цены }
      write('Лучшая цена - ', Trunc(bestP), ' руб. ');
      if Round(Frac(bestP)*100)=50 then
        write('50 коп.');
      writeln;
      write('За ');
      if B1>0 then
      begin
        if ((B1 mod 10 = 2) or (B1 mod 10 = 3) or
          (B1 mod 10 = 4)) and ((B1>=22) or (B1=2) or
          (B1=3) or (B1=4)) then
          write(B1, ' ящика ')
        else
          if (B1 mod 10 = 1) and ((B1>=21) or (B1=1)) then
            write(B1, ' ящик ')
          else
            write(B1, ' ящиков ');
      end;
      if M1>0 then
      begin
        if (M1=2) or (M1=3) or (M1=4) then
          write(M1, ' коробки ')
        else
          if M1=1 then
            write(M1, ' коробку ')
          else
            write(M1, ' коробок ');
      end;
      if S1>0 then
      begin
        if (S1=2) or (S1=3) or (S1=4) then
          write(S1, ' дискеты ')
        else
          if S1=1 then
            write(S1, ' дискету ')
          else
            write(S1, ' дискет ');
      end;
      writeln;

      { Подсчёт бонуса, разницы между средней и лучшей ценами }
      if B1*144+M1*12+S1>amoFloppy then
        writeln('Вы получите дополнительно ', B1*144+M1*12+S1-amoFloppy, ' дискету(ы) и на ', goodP-bestP:4:2, ' руб. дешевле');
    end;
  end;

  readln;    //Пауза
end.

