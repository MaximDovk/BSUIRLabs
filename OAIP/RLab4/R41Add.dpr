Program R41Add;
{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

var
  a, b: array [1..50] of integer;
  c: array [0..50] of integer;
  str: ansistring;
  i, lena, lenb, temp, max, osn: integer;
  flag: boolean;

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
        flag:=false
      else
        flag:=true;
      if not flag then
        write('Введите систему счисления (от 2 до 20): ');
    until flag=true;

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
          flag:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lena downto 1 do
    begin
      a[50-lena+i]:=ord(str[i])-ord('0');     //Перевод цифр 0-9
      { Перевод символов A+ }
      { Исключение для символов с кодами 48-64 }
      if a[50-lena+i]>9 then
        if a[50-lena+i]<17 then
          flag:=false
        else
          dec(a[50-lena+i], 7);
      if (a[50-lena+i]>osn-1) or (a[50-lena+i]<0) then
        flag:=false;
    end;

    { Ввод строки B }
    { Проверка на подходящую длинну и недопустимые символы }
    while (lenb>50) and flag do
    begin
      write('Введите B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>50 then
      writeln('Число не может иметь более 50 знаков');
      for i:=1 to lenb do
        if ord(str[i])-48<0 then
          flag:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lenb downto 1 do
    begin
      b[50-lenb+i]:=ord(str[i])-48;
      if b[50-lenb+i]>9 then
        if b[50-lenb+i]<17 then
          flag:=false
        else
          dec(b[50-lenb+i], 7);
      if (b[50-lenb+i]>osn-1) then
        flag:=false;
    end;

    { Вывод исключения }
    if flag=false then
      writeln('Недопустимые для данной системы счисления знаки');
  until flag=true;

  temp:=0;

  { Подсчёт суммы соответствующих элементов массива }
  { Перенос в следующий разряд }
  for i:=50 downto 1 do
  begin
    c[i]:=temp+a[i]+b[i];
    if c[i]>osn-1 then
    begin
      dec(c[i], osn);
      temp:=1;
    end
    else
      temp:=0;
  end;

  { Вычисление максимальной длинны строки }
  { Если длинна двух строк равна нулю, то max:=1 }
  max:=lena;
  if lenb>max then
    max:=lenb;
  if max=0 then
    max:=1;

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

  write('Результат: ');
  { Выводим на 1 символ в ответе больше }
  { Если мы переносили в новый разряд }
  if c[50-max]>0 then
    temp:=50
  else
  begin
    temp:=51;
    write(' ');
  end;
  for i:=temp-max to 50 do
  begin
    if c[i]>9 then
      write(chr(c[i]+55))
    else
      write(c[i]);
  end;

  readln;
end.



