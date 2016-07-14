unit UCountSystems;

interface

uses
  UTypes;
                         
{ Переводит число из одной системы счисления во все другие }
procedure convertToCountSystems(var number: TNumber; countSystem: TCountSystem);

implementation

uses
  SysUtils;

const
  { Таблицы перевода }
  BIN_HEX_CONVERT: array [1..2, 1..16] of String =
      (('0000', '0001', '0010', '0011',
        '0100', '0101', '0110', '0111',
        '1000', '1001', '1010', '1011',
        '1100', '1101', '1110' ,'1111'),
       ('0', '1', '2', '3', '4', '5', '6', '7',
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'));
  BIN_OCT_CONVERT: array [1..2, 1..8] of String =
      (('000', '001', '010', '011',
        '100', '101', '110', '111'),
       ('0', '1', '2', '3', '4', '5', '6', '7'));

{ Переводит двоичное число в шестнадцатеричное }
function binToHex(bin: String): String;
var
  i, j: Integer;
  tempStr: String;
begin
  while length(bin) mod 4 <> 0 do
    insert('0', bin, 1);
  i := 1;
  result := '';
  while i <= length(bin) do
  begin
    tempStr := copy(bin, i, 4);
    j := 1;
    while BIN_HEX_CONVERT[1, j] <> tempStr do
      inc(j);
    result := result + BIN_HEX_CONVERT[2, j];
    inc(i, 4);
  end;
end;    
            
{ Переводит двоичное число в десятичное }
function binToDec(bin: String): String;
var
  pow, res: int64;
  i: Integer;
begin
  res := 0;
  pow := 1;
  for i := length(bin) downto 1 do
  begin
    if bin[i] = '1' then
      res := res + pow;
    pow := pow * 2;
  end;
  result := IntToStr(res);
  if result = '0' then
    result := '';
end;

{ Переводит двоичное число в восьмеричное }
function binToOct(bin: String): String;
var
  i, j: Integer;
  tempStr: String;
begin
  while length(bin) mod 3 <> 0 do
    insert('0', bin, 1);
  i := 1;
  result := '';
  while i <= length(bin) do
  begin
    tempStr := copy(bin, i, 3);
    j := 1;
    while BIN_OCT_CONVERT[1, j] <> tempStr do
      inc(j);
    result := result + BIN_OCT_CONVERT[2, j];
    inc(i, 3);
  end;
end;

{ Переводит шестнадцатеричное число в двоичное }
function hexToBin(hex: String): String;
var
  i, j: Integer;
begin
  for i := 1 to length(hex) do
  begin
    j := 1;
    while BIN_HEX_CONVERT[2, j] <> hex[i] do
      inc(j);
    result := result + BIN_HEX_CONVERT[1, j];
  end;
  while (length(result) >= 1) and (result[1] = '0') do
    delete(result, 1, 1);
end;
                
{ Переводит восьмеричное число в двоичное }
function octToBin(oct: String): String;
var
  i, j: Integer;
begin
  for i := 1 to length(oct) do
  begin
    j := 1;
    while BIN_OCT_CONVERT[2, j] <> oct[i] do
      inc(j);
    result := result + BIN_OCT_CONVERT[1, j];
  end;
  while (length(result) >= 1) and (result[1] = '0') do
    delete(result, 1, 1);
end;
               
{ Переводит десятичное число в двоичное }
function decToBin(dec: String): String;
var
  res: int64;
begin
  if length(dec) > 0 then
    res := StrToInt64(dec)
  else
    res := 0;
  result := '';
  while res <> 0 do
  begin
    if res mod 2 = 0 then
      result := '0' + result
    else
      result := '1' + result;
    res := res div 2;
  end;
end;

{ Переводит число из одной системы счисления во все другие }
procedure convertToCountSystems(var number: TNumber; countSystem: TCountSystem);
begin
  case countSystem of
    csHEX:
    begin
      number.bin := hexToBin(number.hex);
      number.dec := binToDec(number.bin);
      number.oct := binToOct(number.bin);
    end;
    csDEC:
    begin
      number.bin := decToBin(number.dec);
      number.hex := binToHex(number.bin);
      number.oct := binToOct(number.bin);
    end;
    csOCT:
    begin
      number.bin := octToBin(number.oct);
      number.hex := binToHex(number.bin);
      number.dec := binToDec(number.bin);
    end;
    csBIN:
    begin
      number.hex := binToHex(number.bin);
      number.dec := binToDec(number.bin);
      number.oct := binToOct(number.bin);
    end;
  end;
end;

end.
 