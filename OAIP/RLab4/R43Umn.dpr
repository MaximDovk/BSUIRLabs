Program R43Umn;
{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

const
  n = 50;

var
  a, b: array [1..n] of integer;
  c: array [1..2*n] of integer;
  str: ansistring;
  j, i, lena, lenb, temp, max, osn: integer;
  flag: boolean;

begin
  SetConsoleCP(1251);             //Русский текст
  SetConsoleOutputCP(1251);       //  в консоли

  { Ввод данных, цикл проходит хотя бы 1 раз }
  repeat
    { Обнуление массивов и установка слишком большой длинны строк }
    lena:=n+1;
    lenb:=n+1;
    for i:=1 to n do
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
    flag:=true;

    { Ввод строки A }
    { Проверка на подходящую длинну и недопустимые символы }
    while lena>n do
    begin
      write('Введите A:  ');
      readln(str);
      { Вычисление длинны числа A }
      lena:=length(str);
      { Если строка A длиннее n символов, то вывод исключения }
      if lena>50 then
        writeln('Число не может иметь более ', n, ' знаков');
      for i:=1 to lena do
        { Проверка на недопустимые символы }
        if ord(str[i])-48<0 then
          flag:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lena downto 1 do
    begin
      a[n-lena+i]:=ord(str[i])-48;      //Перевод цифр 0-9
      { Перевод символов A+ }
      { Исключение для символов с кодами 48-64 }
      if a[n-lena+i]>9 then
        if a[n-lena+i]<17 then
          flag:=false
        else
          dec(a[n-lena+i], 7);
      if a[n-lena+i]>osn-1 then
        flag:=false;
    end;

    { Ввод строки B }
    { Проверка на подходящую длинну и недопустимые символы }
    while (lenb>n) and flag do
    begin
      write('Введите B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>n then
        writeln('Число не может иметь более ', n, ' знаков');
      for i:=1 to lenb do
        if ord(str[i])-48<0 then
          flag:=false;
    end;

    { Перевод в формат массива, перевод символов A-J в десятичный вид }
    { Проверка подходят ли символы к этой системе счисления }
    for i:=lenb downto 1 do
    begin
      b[n-lenb+i]:=ord(str[i])-48;
      if b[n-lenb+i]>9 then
        if b[n-lenb+i]<17 then
          flag:=false
        else
          dec(b[n-lenb+i], 7);
      if b[n-lenb+i]>osn-1 then
        flag:=false;
    end;

    { Вывод исключения }
    if flag=false then
      writeln('Недопустимые для данной системы счисления знаки');
  until flag=true;

  { Подсчёт произведения соответствующих элементов массива }
  { Перенос в следующий разряд }
  for i:=n downto n+1-lenb do
  begin
    temp:=0;
    for j:=n downto n+1-lena do
    begin
      c[i+j]:=c[i+j]+temp+a[j]*b[i];
      if c[i+j]>osn-1 then
      begin
        temp:=c[i+j] div osn;
        dec(c[i+j], temp*osn);
      end
      else
        temp:=0;
    end;
    inc(c[i+n-lena], temp);
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
  for i:=n+1-max to n do
  begin
    if a[i]>9 then
      write(chr(a[i]+55))
    else
      write(a[i]);
  end;
  writeln;

  write('B:          ');
  for i:=n+1-max to n do
  begin
    if b[i]>9 then
      write(chr(b[i]+55))
    else
      write(b[i]);
  end;
  writeln;


  { Выводим до 2*n символов }
  { Начальные нули отбрасываем }
  write('Результат:  ');
  i:=1;
  flag:=false;
  while i<=2*n do
  begin
    if c[i]>0 then
      flag:=true;
    if flag then
    begin
      if c[i]>9 then
        write(chr(c[i]+55))
      else
        write(c[i]);
    end;
    inc(i);
  end;
  if not flag then write('0');

  readln;
end.



