program stacks;

{$APPTYPE CONSOLE}

type
  TValue = Integer;
  TStack = ^TElement;
  TElement = record
    value: TValue;
    next: TStack;
  end;

var
  stack: TStack;
  i: Integer;

function isStackExists(const stack: TStack):Boolean;
begin
  if stack = nil then
    result := false
  else
    result := true;
end;

function isStackEmpty(const stack: TStack):Boolean;
begin
  if isStackExists(stack) then
  begin
    if stack^.next = nil then
      result := true
    else
      result := false;
  end
  else
    result := true;
end;

function pop(stack: TStack): TValue;
var
  temp: TStack;
begin
  if not isStackEmpty(stack) then
  begin
    temp := stack^.next;
    stack^.next := temp^.next;
    result := temp^.value;
    dispose(temp);
  end
  else
  begin
    result := MaxInt;                                               //Change result if TValue <> Integer!
    writeln('Stack is empty or does not exists, can`t pop')
  end;
end;

procedure clear(stack: TStack);
begin
  while not isStackEmpty(stack) do
    pop(stack);
end;

procedure deleteHead(var stack: TStack);
begin
  clear(stack);
  dispose(stack);
  stack := nil;
end;

procedure createHead(var stack: TStack);
begin
  if isStackExists(stack) then
    deleteHead(stack);
  new(stack);
end;

procedure push(stack: TStack; value: TValue);
var
  temp: TStack;
begin
  if isStackExists(stack) then
  begin
    new(temp);
    temp^.value := value;
    temp^.next := stack^.next;
    stack^.next := temp;
  end
  else
    writeln('Stack is not exist, can`t push');
end;

begin
  createHead(stack);
  for i := 1 to 10 do
    push(stack, i);
  while not isStackEmpty(stack) do
    writeln(pop(stack));
  deleteHead(stack);
  readln;
end.

