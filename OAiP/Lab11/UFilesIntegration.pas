unit UFilesIntegration;

interface

uses
  UBookList, UVisitorList, UBorrowList;

implementation

uses SysUtils;

// Пути к файлам записей
const
  BOOK_PATH = 'books.dat';
  VISITOR_PATH = 'visitors.dat';
  BORROW_PATH = 'borrows.dat';

type
  TBookFile = file of TBook;
  TVisitorFile = file of TVisitor;
  TBorrowFile = file of TBorrow;

// Создаёт несуществующие файлы
procedure checkFiles;
var
  bookFile: TBookFile;
  visitorFile: TVisitorFile;
  borrowFile: TBorrowFile;
begin
  if not FileExists(BOOK_PATH) then
  begin
    AssignFile(bookFile, BOOK_PATH);
    Rewrite(bookFile);
    CloseFile(bookFile);
  end;  
  if not FileExists(VISITOR_PATH) then
  begin
    AssignFile(visitorFile, VISITOR_PATH);
    Rewrite(visitorFile);
    CloseFile(visitorFile);
  end;
  if not FileExists(BORROW_PATH) then
  begin
    AssignFile(borrowFile, BORROW_PATH);
    Rewrite(borrowFile);
    CloseFile(borrowFile);
  end;
end;

// Прочитывает файлы и записывает в списки
procedure readFiles;
var
  bookFile: TBookFile;
  visitorFile: TVisitorFile;
  borrowfile: TBorrowFile;
  tempBook: TBook;
  tempVisitor: TVisitor;
  tempBorrow: TBorrow;
begin
  checkFiles;
  AssignFile(bookFile, BOOK_PATH);
  AssignFile(visitorFile, VISITOR_PATH);
  AssignFile(borrowfile, BORROW_PATH);
  Reset(bookFile);
  Reset(visitorFile);
  Reset(borrowfile);

  while not eof(bookFile) do
  begin
    read(bookFile, tempBook);
    addBook(tempBook);
  end;

  while not eof(visitorFile) do
  begin
    read(visitorFile, tempVisitor);
    addVisitor(tempVisitor);
  end;

  while not eof(borrowFile) do
  begin
    read(borrowFile, tempBorrow);
    addBorrow(tempBorrow);
  end;

  CloseFile(bookFile);
  CloseFile(visitorFile);
  CloseFile(borrowfile);
end;

// Сохраняет файлы из списков
procedure saveFiles;
var
  arBooks: TBooks;
  arVisitors: TVisitors;
  arBorrows: TBorrows;
  bookFile: TBookFile;
  visitorFile: TVisitorFile;
  borrowfile: TBorrowFile;
  i: Integer;
begin
  arBooks := returnAllBooks;
  arVisitors := returnAllVisitors;
  arBorrows := returnAllBorrows;

  AssignFile(bookFile, BOOK_PATH);
  AssignFile(visitorFile, VISITOR_PATH);
  AssignFile(borrowfile, BORROW_PATH);
  Rewrite(bookFile);
  Rewrite(visitorFile);
  Rewrite(borrowfile);

  for i := 0 to length(arBooks) - 1 do
  begin
    write(bookFile, arBooks[i]);
  end;
  
  for i := 0 to length(arVisitors) - 1 do
  begin
    write(visitorFile, arVisitors[i]);
  end;

  for i := 0 to length(arBorrows) - 1 do
  begin
    write(borrowFile, arBorrows[i]);
  end;

  CloseFile(bookFile);
  CloseFile(visitorFile);
  CloseFile(borrowfile);
end;

initialization
  readFiles;

finalization
  saveFiles;

end.
