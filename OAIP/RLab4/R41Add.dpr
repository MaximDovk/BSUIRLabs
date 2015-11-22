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
        flag:=false
      else
        flag:=true;
      if not flag then
        write('������� ������� ��������� (�� 2 �� 20): ');
    until flag=true;

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
          flag:=false;
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
    for i:=lena downto 1 do
    begin
      a[50-lena+i]:=ord(str[i])-ord('0');     //������� ���� 0-9
      { ������� �������� A+ }
      { ���������� ��� �������� � ������ 48-64 }
      if a[50-lena+i]>9 then
        if a[50-lena+i]<17 then
          flag:=false
        else
          dec(a[50-lena+i], 7);
      if (a[50-lena+i]>osn-1) or (a[50-lena+i]<0) then
        flag:=false;
    end;

    { ���� ������ B }
    { �������� �� ���������� ������ � ������������ ������� }
    while (lenb>50) and flag do
    begin
      write('������� B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>50 then
      writeln('����� �� ����� ����� ����� 50 ������');
      for i:=1 to lenb do
        if ord(str[i])-48<0 then
          flag:=false;
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
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

    { ����� ���������� }
    if flag=false then
      writeln('������������ ��� ������ ������� ��������� �����');
  until flag=true;

  temp:=0;

  { ������� ����� ��������������� ��������� ������� }
  { ������� � ��������� ������ }
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

  { ���������� ������������ ������ ������ }
  { ���� ������ ���� ����� ����� ����, �� max:=1 }
  max:=lena;
  if lenb>max then
    max:=lenb;
  if max=0 then
    max:=1;

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

  write('���������: ');
  { ������� �� 1 ������ � ������ ������ }
  { ���� �� ���������� � ����� ������ }
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



