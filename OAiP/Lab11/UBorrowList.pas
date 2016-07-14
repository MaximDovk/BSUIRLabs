unit UBorrowList;

interface
          
var
  borrowsLen: Integer = 0;

type
  // Запись о взятии книги из библиотеки
  TBorrow = packed record
    code: Integer;
    visitorID: Integer;
    bookCode: Integer;
    borrowDate: TDateTime;
    expReturnDate: TDateTime;
    realReturnDate: TDateTime;
  end;
  TBorrows = array of TBorrow;

// Конструктор TBorrow
function toBorrow(const code,
                        visitorID,
                        bookCode: Integer;
                  const borrowDate,
                        expReturnDate,
                        realReturnDate:
                        TDateTime):TBorrow;

// Добавление записи о взятии книги
procedure addBorrow(borrow: TBorrow);

// Возвращает записи о всех взятых книгах библиотеки
function returnAllBorrows:TBorrows;

// Возвращает записи о открытых записях
function returnOpenBorrows:TBorrows;

// Возвращает записи о закрытых записях
function returnClosedBorrows:TBorrows;

// Изменение записи по коду
procedure changeByBorrowCode(code: Integer; newBorrow: TBorrow);

// Поиск записи по коду
function findByBorrowCode(code: Integer):TBorrow;

// Поиск записи по коду посетителя
procedure deleteByVisitorCode(code: Integer);

// Поиск записи по коду книги
procedure deleteByBookCode(code: Integer);

// Удаление записи по коду
procedure deleteByBorrowCode(code: Integer);

// Проверяет, существует ли запись с кодом
function borrowExist(code: Integer):Boolean;

implementation

type
  TBorrowList = ^TBorrowElem;
  TBorrowElem = packed record
    borrow: TBorrow;
    next: TBorrowList;
  end;

var
  borrows: TBorrowList;

// Конструктор TBorrow
function toBorrow(const code,
                        visitorID,
                        bookCode: Integer;
                  const borrowDate,
                        expReturnDate,
                        realReturnDate:
                        TDateTime):TBorrow;
begin
  result.code := code;
  result.visitorID := visitorID;
  result.bookCode := bookCode;
  result.borrowDate := borrowDate;
  result.expReturnDate := expReturnDate;
  result.realReturnDate := realReturnDate;
end;

// Добавление записи о взятии книги
procedure addBorrow(borrow: TBorrow);
var
  temp: TBorrowList;
begin
  new(temp);
  temp^.borrow := borrow;
  temp^.next := borrows^.next;
  borrows^.next := temp;
  inc(borrowsLen);
end;

// Возвращает записи о всех взятых книгах библиотеки
function returnAllBorrows:TBorrows;
var
  list: TBorrowList;
begin
  list := borrows;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    SetLength(result, length(result) + 1);
    result[length(result) - 1] := list^.borrow;
  end;
end;

// Возвращает записи о открытых записях
function returnOpenBorrows:TBorrows;
var
  list: TBorrowList;
begin
  list := borrows;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.borrow.realReturnDate = -1 then
    begin
      SetLength(result, length(result) + 1);
      result[length(result) - 1] := list^.borrow;
    end;
  end;
end;

// Возвращает записи о закрытых записях
function returnClosedBorrows:TBorrows; 
var
  list: TBorrowList;
begin
  list := borrows;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.borrow.realReturnDate <> -1 then
    begin
      SetLength(result, length(result) + 1);
      result[length(result) - 1] := list^.borrow;
    end;
  end;
end;

// Изменение записи по коду
procedure changeByBorrowCode(code: Integer; newBorrow: TBorrow);
var
  list: TBorrowList;
begin
  list := borrows;
  while (list^.next <> nil) and (list^.next^.borrow.code <> code) do
    list := list^.next;
  if list^.next <> nil then
    list^.next^.borrow := newBorrow;
end;

// Поиск записи по коду
function findByBorrowCode(code: Integer):TBorrow;
var
  list: TBorrowList;
begin
  list := borrows;
  result.code := code - 1;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.borrow.code = code then
      result := list^.borrow;
  end;
end;

// Удаление элемента из списка
procedure delete(list: TBorrowList);
var
  temp: TBorrowList;
begin
  if list^.next <> nil then
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;

// Удаление записи по коду
procedure deleteByBorrowCode(code: Integer);
var
  list: TBorrowList;
begin
  list := borrows;
  while list^.next <> nil do
  begin
    if list^.next^.borrow.code = code then
      delete(list)
    else
      list := list^.next;
  end;
end;           

// Удаление записи по коду посетителя
procedure deleteByVisitorCode(code: Integer);
var
  list: TBorrowList;
begin
  list := borrows;
  while list^.next <> nil do
  begin
    if list^.next^.borrow.visitorID = code then
      delete(list)
    else
      list := list^.next;
  end;
end;       

// Удаление записи по коду книги
procedure deleteByBookCode(code: Integer);
var
  list: TBorrowList;
begin
  list := borrows;
  while list^.next <> nil do
  begin
    if list^.next^.borrow.bookCode = code then
      delete(list)
    else
      list := list^.next;
  end;
end;    

// Проверяет, существует ли запись с кодом
function borrowExist(code: Integer):Boolean;
var
  list: TBorrowList;
begin
  list := borrows;
  result := false;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.borrow.code = code then
      result := true;
  end;
end;

// Очистка списка
procedure clear(list: TBorrowList);
begin
  while list^.next <> nil do
    delete(list);
end;

// Создание списка
procedure create(var list: TBorrowList);
begin
  new(list);
  list^.next := nil;
end;

// Удаление списка
procedure destroy(var list: TBorrowList);
begin
  clear(list);
  dispose(list);
  list := nil;
end;

initialization
  create(borrows);

finalization
  destroy(borrows);
  
end.
