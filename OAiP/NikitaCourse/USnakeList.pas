unit USnakeList;

interface

uses
  UTypes;

type
  TSnakeList = ^TSnakeItem;
  TSnakeItem = record
    data: TSnakeData;
    next: TSnakeList;
  end;

procedure addHeadItem(snake: TSnakeList; data: TSnakeData);

function deleteTailItem(snake: TSnakeList):TSnakeData;

function returnHead(snake: TSnakeList):TSnakeData;

procedure createSnake(var snake: TSnakeList);

procedure destroySnake(var snake: TSnakeList);

function returnSnake(snake: TSnakeList):TSnake;

procedure fillSnake(snakeArray: TSnake; snake: TSnakeList);

implementation

function isEmpty(snake: TSnakeList):Boolean;
begin
  result := snake^.next = nil;
end;

procedure insert(snake: TSnakeList; data: TSnakeData);
var
  temp: TSnakeList;
begin
  new(temp);
  temp^.data := data;
  temp^.next := snake^.next;
  snake^.next := temp;
end;

procedure delete(snake: TSnakeList);
var
  temp: TSnakeList;
begin
  temp := snake^.next;
  snake^.next := temp^.next;
  dispose(temp);
end;

procedure addHeadItem(snake: TSnakeList; data: TSnakeData);
begin
  insert(snake, data);
end;

function returnHead(snake: TSnakeList):TSnakeData;
begin
  result := snake^.next^.data;
end;

function deleteTailItem(snake: TSnakeList):TSnakeData;
begin
  while not isEmpty(snake^.next) do
    snake := snake^.next;
  result := snake^.next^.data;
  delete(snake);
end;

procedure clearSnake(snake: TSnakeList);
begin
  while not isEmpty(snake) do
    delete(snake);
end;

procedure createSnake(var snake: TSnakeList);
begin
  new(snake);
  snake^.next := nil;
end;

procedure destroySnake(var snake: TSnakeList);
begin
  clearSnake(snake);
  dispose(snake);
  snake := nil;
end;

function returnSnake(snake: TSnakeList):TSnake;
var
  i: Integer;
begin
  i := 1;
  while not isEmpty(snake) do
  begin
    result[i] := snake^.next^.data;
    snake := snake^.next;
    inc(i);
  end;
  while i <= length(result) do
  begin
    result[i].cell.x := -1;
    inc(i);
  end;
end;

procedure fillSnake(snakeArray: TSnake; snake: TSnakeList);
var
  i: Integer;
begin
  for i := length(snakeArray) downto 1 do
  begin
    if snakeArray[i].cell.x <> -1 then
      addHeadItem(snake, snakeArray[i]);
  end;
end;

end.
 