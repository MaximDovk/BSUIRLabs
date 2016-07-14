unit UPostfix;

interface

function toPostfix(str: String):String;
function calcRank(str: String):Integer;

implementation

type
  TList = ^TElem;
  TElem = record
    sym: Char;
    next: TList;
  end;
 
var
  stack: TList;

procedure createList(var stack: TList);
begin
  new(stack);
end;

procedure push(stack: TList; sym: Char);
var
  temp: TList;
begin
  new(temp);
  temp^.sym := sym;
  temp^.next := stack^.next;
  stack^.next := temp;
end;

function pop(stack: TList):Char;
var
  temp: TList;
begin
  temp := stack^.next;
  stack^.next := temp^.next;
  result := temp^.sym;
end;

procedure destroyList(var stack: TList);
begin
  while (stack <> nil) and (stack^.next <> nil) do
    pop(stack);
  dispose(stack);
  stack := nil;
end;

function getPriority(ch: Char):Integer;
begin
  case ch of
    '(':
      result := 0;
    '+', '-':
      result := 2;
    '*', '/':
      result := 4;
    '^':
      result := 5;
    else
      result := 8;
  end;
end;

function getPriorityBase(ch: Char):Integer;
begin
  case ch of
    ')':
      result := 0;
    '(':
      result := 9;
    '+', '-':
      result := 1;
    '*', '/':
      result := 3;
    '^':
      result := 6;
    else
      result := 7;
  end;
end;

function getBiggerPart(stack: TList; ch: Char):String;
var
  pr: Integer;
  temp: Char;
begin
  result := '';
  pr := getPriorityBase(ch);
  if pr = 0 then
  begin
    while (stack^.next <> nil) and (stack^.next^.sym <> '(') do
      result := result + pop(stack);
    pop(stack);
  end
  else
  begin
    while (stack^.next <> nil) and (getPriority(stack^.next^.sym) >= pr) do
    begin
      temp := pop(stack);
      if temp <> '(' then
        result := result + temp;
    end;
  end;
end;

function toPostfix(str: String):String;
var
  i: Integer;
begin
  i := 1;
  result := '';
  while i <= length(str)do
  begin
    case str[i] of
      '+', '-', '/', '*', '^', 'a'..'z', '0'..'9':
      begin
        result := result + getBiggerPart(stack, str[i]);
        push(stack, str[i]);
      end;
      '(':
      begin
        push(stack, '(');
      end;
      ')':
      begin
        result := result + getBiggerPart(stack, ')');
      end;
    end;
    inc(i);
  end;
  while stack^.next <> nil do
    result := result + pop(stack);
end;

function calcRank(str: String):Integer;
const
  oper: set of char = ['a'..'z', 'A'..'Z', '0'..'9', 'À'..'ß', 'à'..'ÿ'];
var
  i: Integer;
  error: Boolean;
begin
  i := 1;
  error := false; 
  result := 0;

  while i <= length(str) do
  begin
    if i < length(str) then
      if (str[i] in oper) and (str[i + 1] in oper) then
        error := true;

    if str[i] = ')' then
      dec(result);
    if str[i] = '(' then
      inc(result);
    if result < 0 then
      error := true;
    inc(i);
  end;
  if result <> 0 then
    error := true;

  result := 0;
  if not error then
  begin
    for i := 1 to length(str) do
    begin
      case str[i] of
        '+', '-', '*', '/', '^':
          dec(result);
        '(', ')':
          ;
        else
          inc(result);
      end;
    end;
  end;
end;

initialization
  createList(stack);

finalization
  destroyList(stack);

end.
