unit UBookList;

interface

var
  booksLen: Integer = 0;

type
  // ���� ������� �����
  TLang = (RU, EN, CH, BY, JP, SP);
  // ������ � �����
  TBook = packed record
    code: Integer;
    authorSurname: String[30];
    bookTitle: String[20];
    publishYear: Integer;
    publishLang: TLang;
  end;
  TBooks = array of TBook;

// ����������� TBook
function toBook(const code: Integer;
                const authorSurname, bookTitle: String;
                const publishYear: Integer;
                const publishLang: TLang):TBook;

// ���������� �����
procedure addBook(book: TBook);

// �������� ����� �� ����
procedure deleteByCode(code: Integer);

// ����� ����� �� ����� ������
function findByAuthor(name: String):TBooks;

// ����� ����� �� ��������
function findByTitle(title: String):TBooks;

// ����� ����� �� ����
function findByCode(code: Integer):TBook;

// ��������� ����� �� ����
procedure changeByCode(code: Integer; newBook: TBook);

// ���������� ��� ����� ����������
function returnAllBooks:TBooks;

// ��������� TLang � ������
function langToStr(lang: TLang):String;

// ���������, ���������� �� ����� � �����
function bookExist(code: Integer):Boolean;

implementation

uses
  UMain;

type
  // ������ ���� � ����������
  TBookList = ^TBookElem;
  TBookElem = packed record
    book: TBook;
    next: TBookList;
  end;

var
  books: TBookList;
                 
// ��������� TLang � ������
function langToStr(lang: TLang):String;
begin
  case lang of
    RU:
      result := sLANG_RU;
    EN:              
      result := sLANG_EN;
    CH:
      result := sLANG_CH;
    BY:
      result := sLANG_BY;
    JP: 
      result := sLANG_JP;
    SP: 
      result := sLANG_SP;
  end;
end;

// ����������� TBook
function toBook(const code: Integer;
                const authorSurname, bookTitle: String;
                const publishYear: Integer;
                const publishLang: TLang):TBook;
begin
  result.code := code;
  result.authorSurname := authorSurname;
  result.bookTitle := bookTitle;
  result.publishYear := publishYear;
  result.publishLang := publishLang;
end;

// ���������� �������� � ������
procedure insert(list: TBookList; book: TBook);
var
  temp: TBookList;
begin
  new(temp);
  temp^.book := book;
  temp^.next := list^.next;
  list^.next := temp;
end;

// ���������� �����
procedure addBook(book: TBook);
var
  list: TBookList;
begin
  list := books;
  while (list^.next <> nil) and (list^.next^.book.bookTitle < book.bookTitle) do
    list := list^.next;
  insert(list, book);
  if book.code > booksLen then
    booksLen := book.code;
end;
               
// ��������� ����� �� ����
procedure changeByCode(code: Integer; newBook: TBook);
var
  list: TBookList;
begin
  list := books;
  while (list^.next <> nil) and (list^.next^.book.code <> code) do
    list := list^.next;
  if list^.next <> nil then
    list^.next^.book := newBook;
end;
               
// ����� ����� �� ����� ������
function findByAuthor(name: String):TBooks;
var
  list: TBookList;
begin
  list := books;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.book.authorSurname = name then
    begin
      SetLength(result, length(result) + 1);
      result[length(result) - 1] := list^.book;
    end;
  end;
end;
                
// ����� ����� �� ��������
function findByTitle(title: String):TBooks;
var
  list: TBookList;
begin
  list := books;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.book.bookTitle = title then
    begin
      SetLength(result, length(result) + 1);
      result[length(result) - 1] := list^.book;
    end;
  end;
end;
            
// ����� ����� �� ����
function findByCode(code: Integer):TBook;
var
  list: TBookList;
begin
  list := books;
  result.code := code - 1;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.book.code = code then
      result := list^.book;
  end;
end;

// �������� �������� ������
procedure delete(list: TBookList);
var
  temp: TBookList;
begin
  if list^.next <> nil then
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;         

// �������� ����� �� ����
procedure deleteByCode(code: Integer);
var
  list: TBookList;
begin
  list := books;
  while list^.next <> nil do
  begin
    if list^.next^.book.code = code then
      delete(list)
    else
      list := list^.next;
  end;
end;

// ���������� ��� ����� ����������
function returnAllBooks:TBooks;
var
  list: TBookList;
begin
  list := books;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    SetLength(result, length(result) + 1);
    result[length(result) - 1] := list^.book;
  end;
end;

// ���������, ���������� �� ����� � �����
function bookExist(code: Integer):Boolean;
var
  list: TBookList;
begin
  list := books;
  result := false;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.book.code = code then
      result := true;
  end;
end;

// ������� �������
procedure clear(list: TBookList);
begin
  while list^.next <> nil do
    delete(list);
end;

// �������� ������
procedure create(var list: TBookList);
begin
  new(list);
  list^.next := nil;
end;

// �������� ������
procedure destroy(var list: TBookList);
begin
  clear(list);
  dispose(list);
  list := nil;
end;

initialization
  create(books);

finalization
  destroy(books);
  
end.
