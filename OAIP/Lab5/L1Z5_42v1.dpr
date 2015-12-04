program L1Z5_42v1;
{$APPTYPE CONSOLE}

uses
  Windows;
  
var
  n, m: integer;
  i, j: integer;
  y: integer;
  X: array [1..1000, 1..1000] of integer;
  delCol, delRow: array [1..1000] of boolean;
  
begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  
  { ���� ������� ������� }
  {$I-}
  repeat
    write('������� N: ');
    readln(n);
  until IOResult=0;
  repeat
    write('������� M: ');
    readln(m);
  until IOResult=0;

  { ���������� ������� }
  for i:=1 to n do
  begin
    for j:=1 to m do
    begin
      repeat
        write('������� X[', i, '][', j, ']: ');
        readln(X[i, j]);
      until IOResult=0;
    end;
  end;
  {$I+}

  { ��������� �������� }
  for i:=1 to n do
    delRow[i]:=false;
  for j:=1 to m do
    delCol[j]:=false;

  { ������� ������� �������� }
  { ���������� ��������� ���� }
  for i:=1 to n do
  begin
    for j:=1 to m do
    begin
      if X[i, j]=0 then
      begin
        delCol[j]:=true;
        delRow[i]:=true;
      end;
    end;
  end;

  { �������� ���� �� ����� ���������� }
  { ��� �������� ��������� ������������ ������ }
  i:=n;
  while i>=1 do
  begin
    if delRow[i] then
    begin
      for y:=i to n-1 do
      begin
        for j:=1 to m do
        begin
          X[y, j]:=X[y+1, j];
        end;
      end;
      dec(n);
    end;
    dec(i);
  end;

  { �������� ������� �� ����� ���������� }
  { ��� �������� ��������� �������������� ������ }
  j:=m;
  while j>=1 do
  begin
    if delCol[j] then
    begin
      for y:=j to m-1 do
      begin
        for i:=1 to n do
        begin
          X[i, y]:=X[i, y+1];
        end;
      end;
      dec(m);
    end;
    dec(j);
  end;

  { ����� ���������� ������� }
  writeln(chr(10), chr(13), '���������� �������:');
  for i:=1 to n do
  begin
    for j:=1 to m do
      write(X[i, j]:2, ' ');
    writeln;
  end;
  
  readln;
end.