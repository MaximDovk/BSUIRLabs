program Lab10;

{$APPTYPE CONSOLE}

uses
  Windows, Math;

type
  TArray = array of integer;
  TArrayType = (SORT, RAND, BACK);
  TResult = array [1..6, 1..6] of Integer;
  TArrayLength = array [1..6] of Integer;

const
  arrayLength: TArrayLength = (100, 250, 500, 1000, 2000, 3000);

var
  res: TResult;

{ ���������� ������, ��� ���������� ������� �� arType }
function getArray(len: Integer; arType: TArrayType):TArray;
var
  i: Integer;
begin
  randomize;
  setLength(result, len);
  case arType of
    SORT:
      for i := 0 to len - 1 do
        result[i] := i;
    RAND:  
      for i := 0 to len - 1 do
        result[i] := random(10 * len);
    BACK:
      for i := 0 to len - 1 do
        result[i] := len - i;
  end;
end;

{ ������ ������� ��� �������� � ������� }
procedure swap(var ar: TArray; i, j: Integer);
var
  temp: Integer;
begin
  temp := ar[i];
  ar[i] := ar[j];
  ar[j] := temp;
end;
                                      
{ �������� ������� ����������, �� �������� ���������� ������ }
{ ���������� ���������� ��������� }
function qSort(ar: TArray):Integer;
var
  steps: array of record
    l, r: Integer;
  end;
  i, j, l, r, x: Integer;
begin
  result := 0;
  setLength(steps, 1);
  steps[0].l := 0;
  steps[0].r := length(ar) - 1;
  repeat
    l := steps[length(steps) - 1].l;
    r := steps[length(steps) - 1].r;
    setLength(steps, length(steps) - 1);
    repeat
      i := l;
      j := r;
      x := ar[(i + j) div 2];
      while i <= j do
      begin
        inc(result, 2);
        while ar[i] < x do
        begin
          inc(i);
          inc(result);
        end;
        while ar[j] > x do
        begin
          dec(j);
          inc(result);
        end;    
        inc(result);
        if i <= j then
        begin
          swap(ar, i, j);
          inc(i);
          dec(j);
        end;
      end;
      inc(result);
      if i < r then
      begin
        setLength(steps, length(steps) + 1); 
        steps[length(steps) - 1].l := i;
        steps[length(steps) - 1].r := r;
      end;
      r := j;    
      inc(result);
    until r <= l;
    inc(result);
  until length(steps) = 0;
end;

{ �������� ��������� ����������, �� �������� ���������� ������ }  
{ ���������� ���������� ��������� }
function sSort(ar: TArray):Integer;
var
  l, r, j: Integer;
begin
  result := 0;
  l := 1;
  r := length(ar) - 1;
  repeat
    for j := r downto l do
    begin          
      inc(result, 2);
      if ar[j - 1] > ar[j] then
        swap(ar, j - 1, j);
    end;
    inc(l);
    for j := l to r do
    begin           
      inc(result, 2);
      if ar[j - 1] > ar[j] then
        swap(ar, j - 1, j);
    end;
    dec(r);
    inc(result);
  until l > r;
end;

{ �������� ������������ �������� � ���������� ������� }
{ ���������� ���������� ��������� � ������� ������� }
function calculateChecks(len: TArrayLength):TResult;
var
  i, j: Integer;
  ar: TArray;
begin
  for i := 1 to 6 do
  begin
    ar := getArray(len[i], SORT);
    result[i][1] := qSort(ar);
    result[i][4] := sSort(ar);

    ar := getArray(len[i], BACK);
    result[i][2] := qSort(ar);
    result[i][5] := sSort(ar);

    result[i][3] := 0;
    result[i][6] := 0;
    for  j := 1 to 100 do
    begin
      ar := getArray(len[i], RAND);
      inc(result[i][3], qSort(ar));
      inc(result[i][6], sSort(ar));
    end;
    result[i][3] := result[i][3] div 100;
    result[i][6] := result[i][6] div 100;
  end;
end;

{ ������� ������� ����������� }
procedure outputTable(res: TResult; len: TArrayLength);
var
  i: Integer;
begin
  writeln('     ������      |   ������� ����������    |  ��������� ���������� ');
  writeln('-----------------|               ���������� ���������              ');
  writeln(' ������ |  ���   | �������� |    ������    | �������� |  ������    ');
  writeln('-------------------------------------------------------------------');
  for i := 1 to 6 do
  begin
    writeln('        |  ����. | ', res[i][1]:8, ' | ���.', len[i] * log2(len[i]):8:0, ' | ', res[i][4]:8, ' | ');

    writeln(len[i]:7, ' | �����. | ', res[i][2]:8, ' | ��.', 2 * ln(2) * len[i] * log2(len[i]):9:0, ' | ', res[i][5]:8, ' | ', sqr(len[i]):9);

    writeln('        |  ����. | ', res[i][3]:8, ' | ���.', sqr(len[i]):8, ' | ', res[i][6]:8, ' | ');

    writeln('-------------------------------------------------------------------');
  end;

  writeln('  � ������ ������ (��������������� ������, ���������� ��������� ����� ������� ������) ');
  writeln('                                    ������� ���������� �������� � n*log2(n) ��������� ');
  writeln('  � ������� ������ ���������� ��������� ������������� �� 2*ln(2)*n*log2(n)');
  writeln('  � ������ ������, ������� ���������� ���������� n^2 ���');
end;

begin   
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  res := calculateChecks(arrayLength);
  outputTable(res, arrayLength);

  readln;
end.
