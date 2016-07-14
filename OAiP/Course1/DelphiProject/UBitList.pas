unit UBitList;

interface

type
  TBitList = ^TBit;
  TBit = record
    bit: Boolean;
    next: TBitList;
  end;

procedure createList(var bitList: TBitList);

procedure insertList(bitList: TBitList; bit: Boolean);

procedure deleteList(bitList: TBitList);

procedure clearList(bitList: TBitList);

procedure clearAfterN(bitList: TBitList; num: Integer);

procedure destroyList(var bitList: TBitList);

function toString(bitList: TBitList):String;

function lengthList(bitList: TBitList):Integer;

function isEmptyList(bitList: TBitList):Boolean;

implementation

procedure createList(var bitList: TBitList);
begin
  new(bitList);
  bitList^.next := nil;
end;

procedure insertList(bitList: TBitList; bit: Boolean);
var
  temp: TBitList;
begin
  new(temp);
  temp^.bit := bit;
  temp^.next := bitList^.next;
  bitList^.next := temp;
end;

procedure deleteList(bitList: TBitList);
var
  temp: TBitList;
begin
  if bitList^.next <> nil then
  begin
    temp := bitList^.next;
    bitList^.next := temp^.next;
    dispose(temp);
  end;
end;

procedure clearList(bitList: TBitList);
begin
  if bitList <> nil then
    while bitList^.next <> nil do
      deleteList(bitList);
end;

procedure clearAfterN(bitList: TBitList; num: Integer);
begin
  while (bitList^.next <> nil) and (num > 0) do
  begin
    dec(num);
    bitList := bitList^.next;
  end;
  clearList(bitList);
end;

procedure destroyList(var bitList: TBitList);
begin
  if bitList^.next <> nil then
    clearList(bitList);
  dispose(bitList);
  bitList := nil;
end;

function toString(bitList: TBitList):String;
var
  i: Integer;
begin
  result := '';
  while bitList^.next <> nil do
  begin
    if bitList^.next^.bit then
      result := '1' + result
    else
      result := '0' + result;
    if ((length(result) + 1) mod 9 = 0) then
      result := ' ' + result;
    bitList := bitList^.next;
  end;
end;

function lengthList(bitList: TBitList):Integer;
begin
  result := 1;
  while bitList^.next <> nil do
  begin
    inc(result);
    bitList := bitList^.next;
  end;
end;    

function isEmptyList(bitList: TBitList):Boolean;
begin
  result := bitList^.next = nil;
end;

end.
 