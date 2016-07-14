program lab4;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TPriorities = array [1..3] of Integer;
  TOperations = array of Integer;
  TUser = record
    amount: Integer;
    priority: Integer;
    operations: TOperations;
    miss: Integer;
  end;
  TUsers = array of TUser;
  TRes = record
    efficiency: Extended;
    downtime: Integer;
  end;
  TResult = array [1..10, 1..10] of TRes;

var
  res: TResult;
  users: TUsers;
  priorities: TPriorities;

{ Копирует из константы в динамический массив }
procedure copyArray(var dest: TOperations; num: Integer);
var
  i: Integer;
const
  { Время, затрачиваемое пользователями в обратном порядке }
  user1: array [0..7] of Integer =  (4, 5, 2, 3, 6, 1, 2, 3);
  user2: array [0..8] of Integer =  (4, 6, 2, 1, 3, 3, 2, 1, 2);
  user3: array [0..9] of Integer =  (2, 1, 3, 2, 4, 5, 8, 6, 1, 4);
  user4: array [0..9] of Integer =  (9, 5, 6, 1, 2, 3, 9, 8, 4, 2);
  user5: array [0..10] of Integer = (2, 3, 1, 5, 4, 1, 3, 2, 7, 6, 9);
  user6: array [0..10] of Integer = (1, 3, 2, 1, 4, 3, 6, 1, 2, 3, 2);
  user7: array [0..11] of Integer = (2, 1, 6, 1, 2, 1, 4, 3, 1, 3, 2, 3);
  user8: array [0..11] of Integer = (2, 2, 2, 4, 8, 3, 6, 1, 3, 3, 3, 2);
begin
  case num of
    0:
      for i := 0 to length(user1) - 1 do
        dest[i] := user1[i];
    1:
      for i := 0 to length(user2) - 1 do
        dest[i] := user2[i];
    2:
      for i := 0 to length(user3) - 1 do
        dest[i] := user3[i];
    3:
      for i := 0 to length(user4) - 1 do
        dest[i] := user4[i];
    4:
      for i := 0 to length(user5) - 1 do
        dest[i] := user5[i];
    5:
      for i := 0 to length(user6) - 1 do
        dest[i] := user6[i];
    6:
      for i := 0 to length(user7) - 1 do
        dest[i] := user7[i];
    7:
      for i := 0 to length(user8) - 1 do
        dest[i] := user8[i];
  end;
end;

{ Заполняет пользователей данными }
procedure setUsers(var users: TUsers);
var
  i: Integer;
begin
  SetLength(users, 8);

  { Заполнение данных пользователей системы }
  users[0].amount := 8;
  users[1].amount := 9;
  users[2].amount := 10;
  users[3].amount := 10;
  users[4].amount := 11;
  users[5].amount := 11;
  users[6].amount := 12;
  users[7].amount := 12;

  { Заполнение приоритетов пользователей }
  users[0].priority := 1;
  users[1].priority := 1;
  users[2].priority := 1;
  users[3].priority := 2;
  users[4].priority := 2;
  users[5].priority := 3;
  users[6].priority := 3;
  users[7].priority := 3;

  users[0].miss := 0;
  users[1].miss := 0;
  users[2].miss := 0;
  users[3].miss := 0;
  users[4].miss := 0;
  users[5].miss := 0;
  users[6].miss := 0;
  users[7].miss := 0;

  for i := 0 to length(users) - 1 do
    SetLength(users[i].operations, users[i].amount);

  { Заполнение пользователей }
  copyArray(users[0].operations, 0);
  copyArray(users[1].operations, 1);
  copyArray(users[2].operations, 2);
  copyArray(users[3].operations, 3);
  copyArray(users[4].operations, 4);
  copyArray(users[5].operations, 5);
  copyArray(users[6].operations, 6);
  copyArray(users[7].operations, 7);
end;

{ Устанавливает начальные приоритеты }
procedure setPriorities(var priorities: TPriorities; len: Integer);
begin
  priorities[1] := len - 1;
  priorities[2] := len - 1;
  priorities[3] := len - 1;
end;

{ Очищает массив результата }
procedure clearResult(var res: TResult);
var
  tTact, tInput: Integer;
begin
  for tTact := 1 to 10 do
  begin
    for tInput := 1 to 10 do
    begin
      res[tTact, tInput].efficiency := 0;
      res[tTact, tInput].downtime := 0;
    end;
  end;
end;

{ Проверяет на пустоту задачи пользователей }
function isEmpty(users: TUsers):Boolean;
var
  i: Integer;
begin
  result := true;
  for i := 0 to length(users) - 1 do
  begin
    if users[i].amount <> 0 then
      result := false
    else
      if users[i].operations[0] <> 0 then
        result := false;
  end;
end;

{ Ищет следующего по приоритету пользователя }
function findNext(var users: TUsers; var priorities: TPriorities):Integer;
var
  pr, i, num: Integer;
begin
  result := -1;
  pr := 1;
  while (pr <= 3) and (result = -1) do
  begin
    num := 0;
    i := priorities[pr] + 1;
    if i = length(users) then
      i := 0;
    while (result = -1) and (num <= 8) do
    begin
      if users[i].priority = pr then
      begin
        if users[i].miss = 0 then
        begin
          if users[i].amount <> 0 then
          begin
            result := i;
          end
          else
            if users[i].operations[0] <> 0 then
              result := i;
        end;
      end;
      inc(num);
      inc(i);
      if i = length(users) then
        i := 0;
    end;
    inc(pr);
  end;
  if result <> -1 then
  begin
    dec(pr);
    priorities[pr] := result;
  end;
end;

{ Пропускает такт }
procedure tact(var users: TUsers);
var
  i: Integer;
begin
  for i := 0 to length(users) - 1 do
  begin
    if users[i].miss > 0 then
      dec(users[i].miss);
  end;
end;

{ Вычисляет лучшее время обработки }
function calcBest(users: TUsers):Integer;
var
  i, j: Integer;
begin
  result := 0;
  for i := 0 to length(users) - 1 do
  begin
    for j := 0 to length(users[i].operations) - 1 do
      inc(result, users[i].operations[j]);
  end;
end;

{ Вычисляет КПД и время простоя процессора }
procedure process(var users: TUsers; var res: TResult);
var
  next: Integer;
  tTact, tInput, wait, best: Integer;
begin           
  setUsers(users);
  best := calcBest(users);
  for tTact := 1 to 10 do
  begin
    for tInput := 1 to 10 do
    begin
      setUsers(users);
      setPriorities(priorities, length(users));
      while not isEmpty(users) do
      begin
        next := findNext(users, priorities);
        if next <> -1 then
        begin
          if users[next].operations[users[next].amount - 1] > tTact then
          begin
            dec(users[next].operations[users[next].amount - 1], tTact);
            tact(users);
          end
          else
          begin
            wait := tTact - users[next].operations[users[next].amount - 1];
            inc(res[tTact, tInput].downtime, wait);
            users[next].operations[users[next].amount - 1] := 0;
            dec(users[next].amount);
            tact(users);
            if wait = tInput then
              users[next].miss := 0
            else
              users[next].miss := (tInput - wait) div tTact + 1;
            if tInput - wait = tTact then
              dec(users[next].miss);
          end;
        end
        else
        begin
          tact(users);
          inc(res[tTact, tInput].downtime, tTact);
        end;
        res[tTact, tInput].efficiency := res[tTact, tInput].efficiency + tTact;
      end;
      res[tTact, tInput].efficiency := best / res[tTact, tInput].efficiency;
    end;
  end;
end;

{ Выводит таблицу результатов }
procedure outputTable(res: TResult);
var
  tTact: Integer;
begin
  for tTact := 0 to 99 do
  begin
    writeln(tTact div 10 + 1:2, ' ', tTact mod 10 + 1:2, ' ', res[tTact div 10 + 1, tTact mod 10 + 1].efficiency:0:2, ' ', res[tTact div 10 + 1, tTact mod 10 + 1].downtime);
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  clearResult(res);
  process(users, res);
  outputTable(res);
  readln;
end.

