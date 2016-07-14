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

{ ������ ������� ����� }
procedure createStack(var stack: TStack);

{ ���������, ���� �� ���� }
function isEmpty(stack: TStack):Boolean;

{ ����� �� ������� ����� ������ �������� }
procedure push(stack: TStack; operation: Char); overload;
{ ����� �� ������� ����� ������� }
procedure push(stack: TStack; operand: String); overload;

{ ������� ������� � ������� ����� }
function pop(stack: TStack):TElem;

{ ��������� ������� � ������ }
function elemToString(elem: TElem):String;

{ ���������� ������� ������� ����� }
function viewTop(stack: TStack):TElem;

{ ������� ���� }
procedure clearStack(stack: TStack);

{ ��������� ���� }
procedure destroyStack(var stack: TStack);

implementation
          
{ ������ ������� ����� }
procedure createStack(var stack: TStack);
begin
  new(stack);
  stack^.next := nil;
end;
                 
{ ���������, ���� �� ���� }
function isEmpty(stack: TStack):Boolean;
begin
  result := stack^.next = nil;
end;
                     
{ ����� �� ������� ����� ������ �������� }
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
                      
{ ����� �� ������� ����� ������� }
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
                    
{ ������� ������� � ������� ����� }
function pop(stack: TStack):TElem;
var
  temp: TStack;
begin
  temp := stack^.next;
  stack^.next := temp^.next;
  result := temp^;
  dispose(temp);
end;
             
{ ��������� ������� � ������ }
function elemToString(elem: TElem):String;
begin
  if elem.isOperand then
    result := elem.operand
  else
    result := elem.operation;
end;
                    
{ ���������� ������� ������� ����� }
function viewTop(stack: TStack):TElem;
begin
  result := stack^.next^;
end;
           
{ ������� ���� }
procedure clearStack(stack: TStack);
begin
  while stack^.next <> nil do
    pop(stack);
end;
       
{ ��������� ���� }
procedure destroyStack(var stack: TStack);
begin
  clearStack(stack);
  dispose(stack);
  stack := nil;
end;

end.
 