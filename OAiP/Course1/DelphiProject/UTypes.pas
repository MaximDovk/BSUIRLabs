unit UTypes;

interface

const
  { ������ ��� ���������� ��������� }
  errRANK                = 1;
  errBRACKETS            = 2;
  errNOT_ENOUGH_OPERANDS = 4;
  errBAD_OPERANDS        = 8;
  errTG_PI_2             = 16;
  errCTG0                = 32;
  errASIN                = 64;
  errACOS                = 128;
  errLN                  = 256;
  errLG                  = 512;
  errLOG                 = 1024;
  errFACT                = 2048;
  errDIV0                = 4096;

type                           
  { �������������� �������� }
  TCalcOperation = (opNONE, opADD, opSUB, opMUL, opDIV, opPOWER, opROOT,
                    opCOS, opSIN, opSQRT, opSQR, opLOG, opLN, opLG, op1DIVX);
  { ������� ������� ����������� �������� }
  THistoryItem = packed record
    operation: TCalcOperation;
    operandA, operandB, res: Extended;
  end;
  { ����������� � ���� ������ ������� }
  THistoryCell = packed record
    code: Integer;
    date: TDateTime;
    item: THistoryItem;
  end;
  { ������ ��������� ������� }
  THistoryArray = array of THistoryItem;
  { ������� ��������� }
  TCountSystem = (csBIN, csOCT, csDEC, csHEX);
  { ����� � ��� ������������� � �������� ��������� }
  TNumber = record
    hex: String;
    dec: String;
    oct: String;
    bin: String;
  end;
  { ��������� ����������� �������� }
  TLastButton = (lbTEXT, lbBACK, lbBUTTON);   
  { ������� ������� ����� ��������� }
  TLocalHistory = record
    textShot: String;
    selStartShot: Integer;
  end;
  { ������ ��������� �� ������� }
  TErrorsArray = array of String;

{ ���������� ������ � ����� �� ������� ��������� �� ������ TNumber }
function hexFromNumber(number: TNumber):String;
function decFromNumber(number: TNumber):String;
function octFromNumber(number: TNumber):String;
function binFromNumber(number: TNumber):String;

{ ��������� ����� ������ � ������ ��������� �� ������� }
function errorToArray(error: Integer):TErrorsArray;

{ ��������� �������� � ������ }
function operationToString(operation: TCalcOperation):String;

{ ��������� ������ ��������� �� ������� � ���� ������ }
function arrayToString(errors: TErrorsArray):String;
{ ��������� ������� ������� � ������ }
function historyItemToString(historyItem: THistoryItem):String;
{ ������� ������ ���� �� ������ }
function deleteTrash(str: String): String;

{ ����������� THistoryItem }
function toHistoryItem(operation: TCalcOperation; operandA, operandB, res: Extended):THistoryItem;

implementation

uses
  SysUtils;

{ ���������� ����� � ����������������� ������� ��������� �� ������ TNumber }
function hexFromNumber(number: TNumber):String;
var
  i: Integer;
begin
  result := number.hex;
  i := length(result) + 1;
  while i > 0 do
  begin
    dec(i, 2);
    insert(' ', result, i);
  end;
  if result = ' ' then
    result := '0';
end;
             
{ ���������� ����� � ������������ ������� ��������� �� ������ TNumber }
function decFromNumber(number: TNumber):String;   
var
  i: Integer;
begin
  result := number.dec;
  i := length(result) + 1;
  while i > 0 do
  begin
    dec(i, 3);
    insert(' ', result, i);
  end;
  if result = ' ' then
    result := '0';
end;
                       
{ ���������� ����� � ������������ ������� ��������� �� ������ TNumber }
function octFromNumber(number: TNumber):String;  
var
  i: Integer;
begin
  result := number.oct;
  i := length(result) + 1;
  while i > 0 do
  begin
    dec(i, 3);
    insert(' ', result, i);
  end;
  if result = ' ' then
    result := '0';
end;
                       
{ ���������� ����� � �������� ������� ��������� �� ������ TNumber }
function binFromNumber(number: TNumber):String;   
var
  i: Integer;
begin
  result := number.bin;
  i := length(result) + 1;
  while i > 0 do
  begin
    dec(i, 8);
    insert(' ', result, i);
  end;
  while (length(result) > 0) and (result[1] = ' ') do
    delete(result, 1, 1);
  if length(result) > 35 then
  begin
    delete(result, length(result) - 35, 1);
    insert(#13, result, length(result) - 34);
  end;
  if result = '' then
    result := '0';
end;
                          
{ ��������� ������� � ����� ������������� ������� }
procedure arrayAdd(var errors: TErrorsArray; str: String);
begin
  SetLength(errors, length(errors) + 1);
  errors[length(errors) - 1] := str;
end;
                                        

{ ��������� ����� ������ � ������ ��������� �� ������� }
function errorToArray(error: Integer):TErrorsArray;
begin
  SetLength(result, 0);
  if error and 1 <> 0 then
    arrayAdd(result, '�������� ���� ���������');
  if error and 2 <> 0 then
    arrayAdd(result, '������������ ������ � ���������');
  if error and 4 <> 0 then
    arrayAdd(result, '������������ ���������');
  if error and 8 <> 0 then
    arrayAdd(result, '�������� ������ ������ ���������');
  if error and 16 <> 0 then
    arrayAdd(result, 'tg Pi/2');
  if error and 32 <> 0 then
    arrayAdd(result, 'ctg 0');
  if error and 64 <> 0 then
    arrayAdd(result, 'asin');
  if error and 128 <> 0 then
    arrayAdd(result, 'acos');
  if error and 256 <> 0 then
    arrayAdd(result, 'Ln(x), x <= 0');
  if error and 512 <> 0 then
    arrayAdd(result, 'Lg(x), x <= 0');
  if error and 1024 <> 0 then
    arrayAdd(result, 'Log(x), x <= 0');
  if error and 2048 <> 0 then
    arrayAdd(result, 'x! , x > 10');
  if error and 4096 <> 0 then
    arrayAdd(result, '������� �� ����');
end;

{ ��������� �������� � ������ }
function operationToString(operation: TCalcOperation):String;
begin
  case operation of
    opADD:
      result := ' +';
		opSUB:
      result := ' -';
		opMUL:
      result := ' *';
		opDIV:
      result := ' /';
		opPOWER:
      result := ' ^';
		opROOT:
      result := ' ^(1/';
    else
      result := '';
	end;
end;

{ ��������� ������ ��������� �� ������� � ���� ������ }
function arrayToString(errors: TErrorsArray):String;
var
  i: Integer;
begin
  result := errors[0];
  for i := 1 to length(errors) - 1 do
    result := result + #13 + #10 + errors[i];
end;

{ ��������� ������� ������� � ������ }
function historyItemToString(historyItem: THistoryItem):String;
begin
  with historyItem do
  begin
    case operation of
      opADD:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' + ' +  deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
      opSUB:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' - ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
      opMUL:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' * ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
      opDIV:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' / ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
      opPOWER:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' ^ ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
      opROOT:
        result := deleteTrash(FloatToStrF(operandB, ffFixed, 5, 5)) + ' ^ (1 / ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opCOS:
        result := 'cos(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opSIN:
        result := 'sin(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opSQRT:
        result := 'sqrt(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opSQR:
        result := 'sqr(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opLOG:
        result := 'log(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opLN:
        result := 'ln(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      opLG:
        result := 'lg(' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5)) + ')';
      op1DIVX:
        result := '1 / ' + deleteTrash(FloatToStrF(operandA, ffFixed, 5, 5));
    end;
  end;
end;

function deleteTrash(str: String): String;
begin
  result := str;
  while (pos('.', result) <> 0) and (pos('E', result) = 0) and (length(result) >= 1) and (result[length(result)] = '0') do
    delete(result, length(result), 1);
  if (length(result) >= 1) and (result[length(result)] = '.') then
    delete(result, length(result), 1);
end;

{ ����������� THistoryItem }
function toHistoryItem(operation: TCalcOperation; operandA, operandB, res: Extended):THistoryItem;
begin
  result.operation := operation;
  result.operandA := operandA;
  result.operandB := operandB;
  result.res := res;
end;

end.
