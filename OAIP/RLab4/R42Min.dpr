Program R42Min;
{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

var
  a, b: array [1..50] of integer;
  c: array [0..50] of integer;
  str: ansistring;
  i, lena, lenb, temp, max, osn: integer;
  flag1, flag2: boolean;

begin
  SetConsoleCP(1251);             //Русский текст
  SetConsoleOutputCP(1251);       //  в консоли

  { Ввод данных, цикл проходит хотя бы 1 раз }
  repeat
    { Обнуление массивов и установка слишком большой длинны строк }
    lena:=51;
    lenb:=51;
    for i:=1 to 50 do
    begin
      a[i]:=0;
      b[i]:=0;
    end;

    { Ввод системы счисления }
    writeln('Введите данные:');
    write('Система счисления: ');
    repeat
      readln(osn);
      { Допустимы системы счисления от 2 до 20 }
      if (osn>20) or (osn<2) then
        flag1:=false
      else
        flag1:=true;
      if not flag1 then
        write('Введите систему счисления (от 2 до 20): ');
    until flag1=true;
    flag1:=true;

    { Ввод строки A }
    { Проверка на подходящую длинну и недопустимые символы }
    while lena>50 do
    begin
      write('Введите A:  ');
      readln(str);
      { Вычисление длинны числа A }
      lena:=length(str);
      { Если строка A длиннее 50 символов, то вывод исключения }
      if lena>50 then
        writeln('Число не может иметь более 50 знаков');
      for i:=1 to lena do
        { Проверка на недопустимые символы }
        if ord(str[i])-48<0 then
          flag1:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lena downto 1 do
    begin
      a[50-lena+i]:=ord(str[i])-48;   //Перевод цифр 0-9
      { Перевод символов A+ }
      { Исключение для символов с кодами 48-64 }
      if a[50-lena+i]>9 then
        if a[50-lena+i]<17 then
          flag1:=false
        else
          dec(a[50-lena+i], 7);
      if a[50-lena+i]>osn-1 then
        flag1:=false;
    end;

    { Ввод строки B }
    { Проверка на подходящую длинну и недопустимые символы }
    while (lenb>50) and flag1 do
    begin
      write('Введите B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>50 then
        writeln('Число не может иметь более 50 знаков');
      for i:=1 to lenb do
        if ord(str[i])-48<0 then
          flag1:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lenb downto 1 do
    begin
      b[50-lenb+i]:=ord(str[i])-48;
      if b[50-lenb+i]>9 then
        if b[50-lenb+i]<17 then
          flag1:=false
        else
          dec(b[50-lenb+i], 7);
      if b[50-lenb+i]>osn-1 then
        flag1:=false;
    end;

    { Вывод исключения }
    if flag1=false then
      writeln('Недопустимые для данной системы счисления знаки');
  until flag1=true;

  i:=1;
  { Поиск большего числа и перестановка, если потребуется }
  while (i<=50) and flag1 do
  begin
    if (a[i]<b[i]) or (a[i]>b[i]) then
      flag1:=false;
    inc(i);
  end;
  if a[i-1]>=b[i-1] then
    flag1:=true
  else
    flag1:=false;

  if not flag1 then
  begin
    for i:=1 to 50 do
    begin
      temp:=a[i];
      a[i]:=b[i];
      b[i]:=temp;
    end;
  end;

  { Подсчёт разности соответствующих элементов массива }
  { Перенос в следующий разряд }
  for i:=50 downto 1 do
  begin
    c[i]:=a[i]-b[i]+c[i];
    if c[i]<0 then
    begin
      inc(c[i], osn);
      dec(c[i-1], 1);
    end;
  end;

  { Вычисление максимальной длинны строки }
  { Если длинна двух строк равна нулю, то max:=1 }
  max:=lena;
  if lenb>max then
    max:=lenb;
  if max=0 then
    max:=1;

  { Вернём числа на свои места }
  if not flag1 then
  begin
    for i:=1 to 50 do
    begin
      temp:=a[i];
      a[i]:=b[i];
      b[i]:=temp;
    end;
  end;

  { Блок вывода + символы A-J }
  writeln('Вывод:');
  write('A:          ');
  for i:=51-max to 50 do
  begin
    if a[i]>9 then
      write(chr(a[i]+55))
    else
      write(a[i]);
  end;
  writeln;

  write('B:          ');
  for i:=51-max to 50 do
  begin
    if b[i]>9 then
      write(chr(b[i]+55))
    else
      write(b[i]);
  end;
  writeln;

  { Если первое число меньше второго, то - }
  write('Результат: ');
  if not flag1 then
    write('-')
  else
    write(' ');
  for i:=51-max to 50 do
  begin
    if c[i]>9 then
      write(chr(c[i]+55))
    else
      write(c[i]);
  end;

  readln;
end.



