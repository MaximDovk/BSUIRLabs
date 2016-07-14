unit UMath;

interface

function addition(a, b: Extended):Extended;
function subtract(a, b: Extended):Extended;
function division(a, b: Extended):Extended;
function multiply(a, b: Extended):Extended;
function longMOD(a, b: Extended):Extended;
function longDIV(a, b: Extended):Extended;
function longSIN(a: Extended):Extended;
function longCOS(a: Extended):Extended;
function longTG(a: Extended):Extended;
function longCTG(a: Extended):Extended;
function longASIN(a: Extended):Extended;
function longACOS(a: Extended):Extended;
function longATG(a: Extended):Extended;
function longACTG(a: Extended):Extended;
function longLG(a: Extended):Extended;
function longLOG(a: Extended):Extended;
function longLN(a: Extended):Extended;
function longABS(a: Extended):Extended;
function longFact(a: Extended):Extended;
function longPower(a, b: Extended):Extended;

implementation

uses
  Math;

function addition(a, b: Extended):Extended;
begin
  result := a + b;
end;

function subtract(a, b: Extended):Extended;
begin
  result := a - b;
end;

function division(a, b: Extended):Extended;
begin
  result := a / b;
end;

function multiply(a, b: Extended):Extended;
begin
  result := a * b;
end;

function longMOD(a, b: Extended):Extended;
begin
  while a > b do
    a := a - b;
  result := a;
end;

function longDIV(a, b: Extended):Extended;
begin
  result := 0;
  while a > b do
  begin
    a := a - b;
    result := result + 1;
  end;
end;

function longSIN(a: Extended):Extended;
begin
  result := sin(a);
end;

function longCOS(a: Extended):Extended;
begin
  result := cos(a);
end;

function longTG(a: Extended):Extended;
begin
  result := tan(a);
end;

function longCTG(a: Extended):Extended;
begin
  result := cotan(a);
end;

function longASIN(a: Extended):Extended;
begin
  result := arcSin(a);
end;

function longACOS(a: Extended):Extended;
begin
  result := arcCos(a);
end;

function longATG(a: Extended):Extended;
begin
  result := arcTan(a);
end;

function longACTG(a: Extended):Extended;
begin
  result := arcCot(a);
end;

function longLG(a: Extended):Extended;
begin
  result := log10(a);
end;

function longLOG(a: Extended):Extended;
begin
  result := log2(a);
end;

function longLN(a: Extended):Extended;
begin
  result := ln(a);
end;

function longABS(a: Extended):Extended;
begin
  result := abs(a);
end;

function longFact(a: Extended):Extended;
var
  i: Integer;
begin
  result := 1;
  for i := 1 to round(a) do
    result := result * i;
end;

function longPower(a, b: Extended):Extended;
begin
  result := power(a, b);
end;

end.
 