unit UStack;

interface

type
  TStack = ^TElem;
  TElem = record
    next: TStack;
    case isOperand:Boolean of
      true:  (operand: String[25]);
      false: (operation: Char);
  end;

{ Создаёт вершину стека }
procedure createStack(var stack: TStack);

{ Проверяет, пуст ли стек }
function isEmpty(stack: TStack):Boolean;

{ Кладёт на вершину стека символ операции }
procedure push(stack: TStack; operation: Char); overload;
{ Кладёт на вершину стека операнд }
procedure push(stack: TStack; operand: String); overload;

{ Снимает элемент с вершины стека }
function pop(stack: TStack):TElem;

{ Переводит элемент в строку }
function elemToString(elem: TElem):String;

{ Возвращает верхний элемент стека }
function viewTop(stack: TStack):TElem;

{ Очищает стек }
procedure clearStack(stack: TStack);

{ Разрушает стек }
procedure destroyStack(var stack: TStack);

implementation
          
{ Создаёт вершину стека }
procedure createStack(var stack: TStack);
begin
  new(stack);
  stack^.next := nil;
end;
                 
{ Проверяет, пуст ли стек }
function isEmpty(stack: TStack):Boolean;
begin
  result := stack^.next = nil;
end;
                     
{ Кладёт на вершину стека символ операции }
procedure push(stack: TStack; operation: Char); overload;
var
  temp: TStack;
begin
  new(temp);
  temp^.isOperand := false;
  temp^.operation := operation;
  temp^.next := stack^.next;
  stack^.next := temp;
end;
                      
{ Кладёт на вершину стека операнд }
procedure push(stack: TStack; operand: String); overload;
var
  temp: TStack;
begin
  new(temp);
  temp^.isOperand := true;
  temp^.operand := operand;
  temp^.next := stack^.next;
  stack^.next := temp;
end;
                    
{ Снимает элемент с вершины стека }
function pop(stack: TStack):TElem;
var
  temp: TStack;
begin
  temp := stack^.next;
  stack^.next := temp^.next;
  result := temp^;
  dispose(temp);
end;
             
{ Переводит элемент в строку }
function elemToString(elem: TElem):String;
begin
  if elem.isOperand then
    result := elem.operand
  else
    result := elem.operation;
end;
                    
{ Возвращает верхний элемент стека }
function viewTop(stack: TStack):TElem;
begin
  result := stack^.next^;
end;
           
{ Очищает стек }
procedure clearStack(stack: TStack);
begin
  while stack^.next <> nil do
    pop(stack);
end;
       
{ Разрушает стек }
procedure destroyStack(var stack: TStack);
begin
  clearStack(stack);
  dispose(stack);
  stack := nil;
end;

end.
 