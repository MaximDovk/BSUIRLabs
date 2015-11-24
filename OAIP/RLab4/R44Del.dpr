Program R44Del;
{$APPTYPE CONSOLE}
{$I-}

uses
  Windows;

const
  n = 50;

var
  a, b: array [1..n] of integer;
  c: array [0..n] of integer;
  str: ansistring;
  j, i, lena, lenb, temp, osn: integer;
  flag1, flag2, flag3: boolean;

begin
  SetConsoleCP(1251);             //������� �����
  SetConsoleOutputCP(1251);       //  � �������

  { ���� ������, ���� �������� ���� �� 1 ��� }
  repeat
    { ��������� �������� � ��������� ������� ������� ������ ����� }
    lena:=n+1;
    lenb:=n+11;
    for i:=1 to n do
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

    { ���� ������ A }
    { �������� �� ���������� ������ � ������������ ������� }
    while lena>n do
    begin
      write('������� A:  ');
      readln(str);
      { ���������� ������ ����� A }
      lena:=length(str);
      { ���� ������ A ������� n ��������, �� ����� ���������� }
      for i:=1 to lena do
        { �������� �� ������������ ������� }
        if ord(str[i])-48<0 then
          flag1:=false;
      if lena>n then
        writeln('����� �� ����� ����� ����� ', n, ' ������');
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
    for i:=lena downto 1 do
    begin
      a[n-lena+i]:=ord(str[i])-48;      //������� ���� 0-9
      { ������� �������� A+ }
      { ���������� ��� �������� � ������ 48-64 }
      if a[n-lena+i]>9 then
        if a[n-lena+i]<17 then
          flag1:=false
        else
          dec(a[n-lena+i], 7);
      if a[n-lena+i]>osn-1 then
        flag1:=false;
    end;

    { ���� ������ B }
    { �������� �� ���������� ������ � ������������ ������� }
    { ����������, ���� B=0 }
    while (lenb>n) and flag1 do
    begin
      flag1:=true;
      write('������� B:  ');
      readln(str);
      lenb:=length(str);
      if lenb>n then
        writeln('����� �� ����� ����� ����� ', n, ' ������');

      flag3:=true;
      for i:=lenb downto 1 do
      begin
        if str[i]<>'0' then
          flag3:=false;
      end;

      if flag3 then
      begin
        lenb:=n+1;
        writeln('�� 0 ������ ������');
      end;
    end;

    { ������� � ������ �������, ������� �������� A-J � ���������� ��� }
    { �������� �������� �� ������� � ���� ������� ��������� }
    for i:=lenb downto 1 do
    begin
      b[n-lenb+i]:=ord(str[i])-48;
      if b[n-lenb+i]>9 then
        if b[n-lenb+i]<17 then
          flag1:=false
        else
          dec(b[n-lenb+i], 7);
      if b[n-lenb+i]>osn-1 then
        flag1:=false;
    end;

    { ����� ���������� }
    if flag1=false then
      writeln('������������ ��� ������ ������� ��������� �����');
  until flag1=true;

  { �������� B ������, ���� ������������ ������� �� �������� }
  for i:=1 to lena-lenb do
  begin
    for j:=1 to n-1 do
    begin
      b[j]:=b[j+1];
    end;
    b[n]:=0;
  end;

  { ��������� �� ������� ������� }
  { ���������� ���������� ���� ������� �����, ������ ������� }
  for i:=lena-lenb downto 0 do
  begin
    repeat
      j:=1;
      flag1:=true;
      flag2:=true;
      while (j<=n-i) and flag2 do
      begin
        if a[j]<b[j] then
        begin
          flag1:=false;
          flag2:=false;
        end;
        if a[j]>b[j] then
        begin
          flag1:=true;
          flag2:=false;
        end;
        inc(j);
      end;
      if flag1 then
      begin
        inc(c[n-i]);
        for j:=n-i downto 1 do
        begin
          dec(a[j], b[j]);
          if a[j]<0 then
          begin
            inc(a[j], osn);
            dec(a[j-1]);
          end;
        end;
      end;
    until flag1=false;
    for j:=n downto 2 do
    begin
      b[j]:=b[j-1];
    end;
    b[1]:=0;
  end;

  for i:=n downto 1 do
  begin
    if c[i]>osn-1 then
    begin
      dec(c[i], osn);
      inc(c[i-1]);
    end;
  end;

  { ���� ������ + ������� A-J }
  writeln('�����:');
  write('�������: ');
  i:=1;
  flag1:=false;
  while i<=n do begin
    if a[i]>0 then flag1:=true;
    if flag1 then begin
      if a[i]>9 then write(chr(a[i]+55))
      else write(a[i]);
    end;
    inc(i);
  end;
  if not flag1 then write('0');
  writeln;

  write('���������:   ');
  i:=1;
  flag1:=false;
  while i<=n do begin
    if c[i]>0 then flag1:=true;
    if flag1 then begin
      if c[i]>9 then write(chr(c[i]+55))
      else write(c[i]);
    end;
    inc(i);
  end;
  if not flag1 then write('0');

  readln;
end.



