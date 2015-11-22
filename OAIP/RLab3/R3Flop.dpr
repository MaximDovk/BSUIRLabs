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
  SetConsoleCP(1251);           //������� �����
  SetConsoleOutputCP(1251);     //  � �������

  { ���� ����� }
  repeat
  begin
    exc:=false;
    write('������� ���-�� ������: ');
    readln(amoFloppy);
    { ��� ������������, ������������� ��� ������� ������� }
    { �������� ������ ������� ������ }
    if (IOResult<>0) or (amoFloppy<=0) or
      (amoFloppy>High(int64)/11.5) then
    begin
      writeln('������� ���������� �������� ������');
      exc:=true;
    end;
  end;
  until not exc;

  { ���������� ������ ���� }
  badP:=amoFloppy*priceS;

  { ���������� ������� ���� }
  B:=amoFloppy div 144;
  M:=amoFloppy mod 144 div 12;
  S:=amoFloppy mod 144 mod 12;
  goodP:=B*priceB+M*priceM+S*priceS;

  { ���������� ������ ���� }
  B1:=B;
  M1:=M;
  S1:=S;
  { ���� ������ ����� 11, �� �������� ������ ������ ������� }
  if S1 >= 10 then
  begin
    s1:=0;
    inc(M1);
  end;
  { ���� ������� ����� 12, �� �������� ������ ������� ���� }
  if M1 >= 11 then
  begin
    m1:=0;
    s1:=0;
    inc(B1);
  end;
  bestP:=B1*priceB+M1*priceM+S1*priceS;

  { ���� ������ }
  { ������������� ��������� ��������� }
  { ����� ���� ��� "0 ������" }
  { ������� ��������� �� ��������� ������ }
  { ���� ��� ���� �����, �� ����������� "���� 1" � ������� ���� 1 ��� }
  { ���� ������� ���� ����� ������, �� ����������� "���� 2" }
  { ���� ��� ���� ��������, �� ����������� "���� 3" }
  { ����� ������ � ������� � �����, ����� ������� � ������ }

  if (bestP=goodP) and (goodP=badP) then      //���� 1
  begin
    { ����� ����� ���� ��� ������ }
    write('������ ���� - ', Trunc(bestP), ' ���. ');
    { ���� ���-�� ������ ������ 0, �� ����� }
    if Round(Frac(bestP)*100)=50 then
      write('50 ���.');
    writeln;
    write('�� ');
    { ���������, "�������" ��� 2, "�������" ��� 1}
    if S1=2 then
      write(S1, ' �������')
    else
      if S1=1 then
        write(S1, ' �������')
      else
        write(S1, ' ������');
    writeln;
  end

  else
  begin
    if (goodP=badP) or (bestP=goodP) then     //���� 2
    begin
      { ����� ������ ����, �.�. ��� ���������� �� ������ }
      write('������ ���� - ', Trunc(badP), ' ���. ');
      if Round(Frac(badP)*100)=50 then
        write('50 ���.');
      writeln;
      writeln;

      { ����� ����� 1 + ��������� "�����" � "�������"}
      write('������ ���� - ', Trunc(bestP), ' ���. ');
      if Round(Frac(bestP)*100)=50 then
        write('50 ���.');
      writeln;
      write('�� ');
      if B1>0 then
      begin     //��� 2, 22.., 3, 23.., 4, 24.. ����� "�����"
        if ((B1 mod 10 = 2) or (B1 mod 10 = 3) or
          (B1 mod 10 = 4)) and ((B1>=22) or (B1=2) or
          (B1=3) or (B1=4)) then
          write(B1, ' ����� ')
        else    //��� 1, 21.. ����� "����"
          if (B1 mod 10 = 1) and ((B1>=21) or (B1=1)) then
            write(B1, ' ���� ')
          else
            write(B1, ' ������ ');
      end;

      if M1>0 then
      begin
        if (M1=2) or (M1=3) or (M1=4) then
          write(M1, ' ������� ')
        else
          if M1=1 then
            write(M1, ' ������� ')
          else
            write(M1, ' ������� ');
      end;

      if S1>0 then
        begin
        if (S1=2) or (S1=3) or (S1=4) then
          write(S1, ' ������� ')
        else
          if S1=1 then
            write(S1, ' ������� ')
          else
            write(S1, ' ������ ');
      end;
    end
    else
    begin   //���� 3
      { ����� ������ ���� }
      write('������ ���� - ', Trunc(badP), ' ���. ');
      if Round(Frac(badP)*100)=50 then
        write('50 ���.');
      writeln;
      writeln;

      {����� ������� ����, ����� ����������� ����}
      write('������� ���� - ', Trunc(goodP), ' ���. ');
      if Round(Frac(goodP)*100)=50 then
        write('50 ���.');
      writeln;
      write('�� ');
      if B>0 then
      begin
        if ((B mod 10 = 2) or (B mod 10 = 3) or
          (B mod 10 = 4)) and ((B>=22) or (B=2) or
          (B=3) or (B=4)) then
          write(B, ' ����� ')
        else
          if (B mod 10 = 1) and ((B>=21) or (B=1)) then
            write(B, ' ���� ')
          else
            write(B, ' ������ ');
      end;
      if M>0 then
      begin
        if (M=2) or (M=3) or (M=4) then
          write(M, ' ������� ')
        else
          if M=1 then
            write(M, ' ������� ')
          else
            write(M, ' ������� ');
      end;
      if S>0 then
      begin
        if (S=2) or (S=3) or (S=4) then
          write(S, ' ������� ')
        else
          if S=1 then
            write(S, ' ������� ')
          else
            write(S, ' ������ ');
      end;
      writeln;
      writeln;

      { ����� ������ ���� }
      write('������ ���� - ', Trunc(bestP), ' ���. ');
      if Round(Frac(bestP)*100)=50 then
        write('50 ���.');
      writeln;
      write('�� ');
      if B1>0 then
      begin
        if ((B1 mod 10 = 2) or (B1 mod 10 = 3) or
          (B1 mod 10 = 4)) and ((B1>=22) or (B1=2) or
          (B1=3) or (B1=4)) then
          write(B1, ' ����� ')
        else
          if (B1 mod 10 = 1) and ((B1>=21) or (B1=1)) then
            write(B1, ' ���� ')
          else
            write(B1, ' ������ ');
      end;
      if M1>0 then
      begin
        if (M1=2) or (M1=3) or (M1=4) then
          write(M1, ' ������� ')
        else
          if M1=1 then
            write(M1, ' ������� ')
          else
            write(M1, ' ������� ');
      end;
      if S1>0 then
      begin
        if (S1=2) or (S1=3) or (S1=4) then
          write(S1, ' ������� ')
        else
          if S1=1 then
            write(S1, ' ������� ')
          else
            write(S1, ' ������ ');
      end;
      writeln;

      { ������� ������, ������� ����� ������� � ������ ������ }
      if B1*144+M1*12+S1>amoFloppy then
        writeln('�� �������� ������������� ', B1*144+M1*12+S1-amoFloppy, ' �������(�) � �� ', goodP-bestP:4:2, ' ���. �������');
    end;
  end;

  readln;    //�����
end.

