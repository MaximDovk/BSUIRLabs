unit UBorrowList;

interface
          
var
  borrowsLen: Integer = 0;

type
  // ������ � ������ ����� �� ����������
  TBorrow = packed record
    code: Integer;
    visitorID: Integer;
    bookCode: Integer;
    borrowDate: TDateTime;
    expReturnDate: TDateTime;
    realReturnDate: TDateTime;
  end;
  TBorrows = array of TBorrow;

// ����������� TBorrow
function toBorrow(const code,
                        visitorID,
                        bookCode: Integer;
                  const borrowDate,
                        expReturnDate,
                        realReturnDate:
                        TDateTime):TBorrow;

// ���������� ������ � ������ �����
procedure addBorrow(borrow: TBorrow);

// ���������� ������ � ���� ������ ������ ����������
function returnAllBorrows:TBorrows;

// ���������� ������ � �������� �������
function returnOpenBorrows:TBorrows;

// ���������� ������ � �������� �������
function returnClosedBorrows:TBorrows;

// ��������� ������ �� ����
procedure changeByBorrowCode(code: Integer; newBorrow: TBorrow);

// ����� ������ �� ����
function findByBorrowCode(code: Integer):TBorrow;

// ����� ������ �� ���� ����������
procedure deleteByVisitorCode(code: Integer);

// ����� ������ �� ���� �����
procedure deleteByBookCode(code: Integer);

// �������� ������ �� ����
procedure deleteByBorrowCode(code: Integer);

// ���������, ���������� �� ������ � �����
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

// ����������� TBorrow
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

// ���������� ������ � ������ �����
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

// ���������� ������ � ���� ������ ������ ����������
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

// ���������� ������ � �������� �������
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

// ���������� ������ � �������� �������
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

// ��������� ������ �� ����
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

// ����� ������ �� ����
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

// �������� �������� �� ������
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

// �������� ������ �� ����
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

// �������� ������ �� ���� ����������
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

// �������� ������ �� ���� �����
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

// ���������, ���������� �� ������ � �����
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

// ������� ������
procedure clear(list: TBorrowList);
begin
  while list^.next <> nil do
    delete(list);
end;

// �������� ������
procedure create(var list: TBorrowList);
begin
  new(list);
  list^.next := nil;
end;

// �������� ������
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
