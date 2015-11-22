{$APPTYPE CONSOLE}

uses
  Windows;

var
  curN, ans, n, res, lenC, copy: int64;
  lastLen, fc, lenM, lastI, i: int64;
  flag: boolean;
  cy: extended;

begin
  { ������� ���� � ������� }
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  { ���� �������� ������ }
  write('������� N: ');
  readln(n);

  { ������������� ��������� }
  CurN:=1;
  ans:=0;

  { ����� �����, ���� �� ����� n-��� }
  while ans<n do
  begin
    flag:=true;
    i:=2;
    { �������� ����������� �������� � extended }
    cy:=CurN;

    { ����� ������� ����� }
    while (flag) and (i<sqrt(cy)) do
    begin
      if CurN mod i = 0 then
        flag:=false;
      inc(i);
    end;

    { ���� ������� ����� ������� }
    if flag then
    begin
	
      { ���������� ����� ���� �������� �������� ����� }
      lenC:=0;
      fc:=curN*curN;
      while fc>0 do
      begin
        lenC:=lenC+(fc mod 10);
        fc:=fc div 10;
      end;

      { ���������� ����� ���� �������� ����� }
      lenM:=0;
      fc:=curN;
      while fc>0 do
      begin
        lenM:=lenM+(fc mod 10);
        fc:=fc div 10;
      end;

      { ���� ����� ���� �������� ����� }
      { � 2 ���� ������ ����� ���� ��� �������� }
      if 2*lenM=lenC then
      begin
        i:=2;
        { lastI � lastLen ��������� �������� }
        { I � ����� ���� I, ��� �������������� ������ ����������}
        lastI:=2;
        lastLen:=2;
        res:=0;
        copy:=lenC;
        { ������� ����� ���� ������� ���������� ����� ������� }
        { ����� ���� �������� �������� ����� }
        while copy>1 do
        begin
          { ���� I �������� ��������� copy }
          if copy mod i = 0 then
          begin
            copy:=copy div i;
            { ���� I ����������, �� ������������ ��� ����� ���� }
            if i<>lastI then
            begin
              lastLen:=0;
              fc:=i;
              { ���������� ����� ����� ���� }
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
        { ���������� ����� ���� ����� ������� }
        { ����� ���� �������� �������� �����  }
        lenM:=0;
        fc:=lenC;
        while fc>0 do
        begin
          lenM:=lenM+(fc mod 10);
          fc:=fc div 10;
        end;
        { ���� ��� ����� ���� �������� ������ ����� }
        { ������ �� ����� ���� �� ������� ����� }
        { ����������� ���������� ��������� ����� �� 1 }
        if res=lenM then
          inc(ans);
      end;
    end;
    { ��������� � �������� ���������� ����� }
    inc(CurN);
  end;

  { ���� ����� ��������� �����, �� ������� ��� }
  writeln(n, '-�� ����� ����� = ', (curN-1)*(curN-1));
  readln;
end.
