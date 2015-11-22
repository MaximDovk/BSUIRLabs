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
  SetConsoleCP(1251);             //������� �����
  SetConsoleOutputCP(1251);       //  � �������

  { ���� ������, ���� �������� ���� �� 1 ��� }
  repeat
    { ��������� �������� � ��������� ������� ������� ������ ����� }
    lena:=51;
    lenb:=51;
    for i:=1 to 50 do
    begin
      a[i]:=0;
      b[i]:=0;
    end;

    { ���� ������� ��������� }
    writeln('������� ������:');
    write('������� ���������: ');
    repeat
      readln(osn);
      { ��������� ������� ��������� �� 2 �� 20 }
      if (osn>20) or (osn<2) then
        flag1:=false
      else
        flag1:=true;
      if not flag1 then
        write('������� ������� ��������� (�� 2 �� 20): ');
    until flag1=true;
    flag1:=true;

    { ���� ������ A }
    { �������� �� ���������� ������ � ������������ ������� }
    while lena>50 do
    begin
      write('������� A:  ');
      readln(str);
      { ���������� ������ ����� A }
      lena:=length(str);
      { ���� ������ A ������� 50 ��������, �� ����� ���������� }
      if lena>50 then
        writeln('����� �� ����� ����� ����� 50 ������');
      for i:=1 to lena do
        { �������� �� ������������ ������� }
        if ord(str[i])-48<0 then
          flag1:=false;
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
    for i:=lena downto 1 do
    begin
      a[50-lena+i]:=ord(str[i])-48;   //������� ���� 0-9
      { ������� �������� A+ }
      { ���������� ��� �������� � ������ 48-64 }
      if a[50-lena+i]>9 then
        if a[50-lena+i]<17 then
          flag1:=false
        else
          dec(a[50-lena+i], 7);
      if a[50-lena+i]>osn-1 then
        flag1:=false;
    end;

    { ���� ������ B }
    { �������� �� ���������� ������ � ������������ ������� }
    while (lenb>50) and flag1 do
    begin
      write('������� B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>50 then
        writeln('����� �� ����� ����� ����� 50 ������');
      for i:=1 to lenb do
        if ord(str[i])-48<0 then
          flag1:=false;
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
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

    { ����� ���������� }
    if flag1=false then
      writeln('������������ ��� ������ ������� ��������� �����');
  until flag1=true;

  i:=1;
  { ����� �������� ����� � ������������, ���� ����������� }
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

  { ������� �������� ��������������� ��������� ������� }
  { ������� � ��������� ������ }
  for i:=50 downto 1 do
  begin
    c[i]:=a[i]-b[i]+c[i];
    if c[i]<0 then
    begin
      inc(c[i], osn);
      dec(c[i-1], 1);
    end;
  end;

  { ���������� ������������ ������ ������ }
  { ���� ������ ���� ����� ����� ����, �� max:=1 }
  max:=lena;
  if lenb>max then
    max:=lenb;
  if max=0 then
    max:=1;

  { ����� ����� �� ���� ����� }
  if not flag1 then
  begin
    for i:=1 to 50 do
    begin
      temp:=a[i];
      a[i]:=b[i];
      b[i]:=temp;
    end;
  end;

  { ���� ������ + ������� A-J }
  writeln('�����:');
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

  { ���� ������ ����� ������ �������, �� - }
  write('���������: ');
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



