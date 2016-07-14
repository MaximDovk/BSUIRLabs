unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UBookList, UVisitorList, UBorrowList, Menus, ActnList, ComCtrls,
  ExtCtrls, StdCtrls, Buttons;

resourcestring
  sCODE = 'Код';
  sTITLE = 'Название';
  sAUTHOR = 'Автор';
  sPUBLISH_YEAR = 'Год издания';
  sPUBLISH_LANG = 'Язык публикации';
  sNAME = 'ФИО';
  sADDRESS = 'Адрес проживания';
  sPHONE = 'Телефон';
  sBOOK_TITLE = 'Название книги';
  sBORROW_DATE = 'Дата выдачи';
  sEXP_RETURN_DATE = 'Дата возврата';
  sREAL_RETURN_DATE = 'Возврат';

  sALL_BOOKS = 'Все книги';
  sNOT_BORROWED_BOOKS = 'Невзятые книги';
  sBORROWED_BOOKS = 'Взятые книги';    
  sADD_BOOK = 'Добавить книгу';
  sDELETE_BOOK = 'Удалить книгу';
  sCHANGE_BOOK = 'Изменить информацию о книге';
  sSHOW_ALL_BOOKS = 'Показать все книги';
  sSHOW_BORROWED_BOOKS = 'Показать взятые книги';
  sSHOW_NOT_BORROWED_BOOKS = 'Показать невзятые книги';

  sALL_VISITORS = 'Все посетители';
  sDEBTS = 'Должники';
  sBAD_VISITORS = 'Недоверенные'; 
  sADD_VISITOR = 'Добавить посетителя';
  sDELETE_VISITOR = 'Удалить посетителя';
  sCHANGE_VISITOR = 'Изменить информацию о посетителе';
  sSHOW_ALL_VISITORS = 'Показать всех посетителей';
  sSHOW_DEBTS = 'Показать должников';
  sSHOW_BAD_VISITORS = 'Показать недоверенных';

  sALL_BORROWS = 'Все записи';
  sOPEN_BORROWS = 'Открытые записи';
  sCLOSED_BORROWS = 'Закрытые записи'; 
  sADD_BORROW = 'Записать книгу на посетителя';
  sCHANGE_BORROW = 'Изменить запись';
  sCLOSE_BORROW = 'Закрыть запись';
  sSHOW_ALL_BORROWS = 'Показать все записи';
  sSHOW_OPEN_BORROWS = 'Показать открытые записи';
  sSHOW_CLOSED_BORROWS = 'Показать закрытые записи';

  sINCORRECT_VISITOR_ID = 'Вы выбрали несуществующего посетителя';
  sINCORRECT_BOOK_CODE = 'Вы выбрали несуществующую книгу';
  sINCORRECT_BORROW_CODE = 'Вы выбрали несуществующую запись';
  sFIELD_MUST_BE_FILLED = 'Поле должно быть заполнено';

  sENTER_CORRECT_DATA = 'Введите корректные данные';
  sENTER_HOUSE_NUMBER = 'Введите номер дома';
  sENTER_PUBLISH_YEAR = 'Введите год публикации';
  sENTER_BOOK_TITLE = 'Введите название книги';
  sENTER_BOOK_AUTHOR = 'Введите фамилию автора';
  sENTER_VISITOR_NAME = 'Введите имя посетителя';
  sENTER_CODE = 'Введите код';

  sTITLE_BOOK_SEARCH = 'Поиск книг по названию'; 
  sAUTHOR_BOOK_SEARCH = 'Поиск книг по автору';
  sNAME_VISITOR_SEARCH = 'Поиск посетителей по фамилии';  
  sFIND_BOOKS_BY_AUTHOR = 'Найти книги по автору';
  sFIND_BOOKS_BY_TITLE = 'Найти книги по названию';
  sFIND_VISITORS_BY_NAME = 'Найти посетителей по имени';

  sERROR = 'Ошибка';
  sSELECT = 'Выбрать';

  sLANG_RU = 'Русский';
  sLANG_EN = 'Английский';
  sLANG_CH = 'Китайский';
  sLANG_BY = 'Белорусский';
  sLANG_JP = 'Японский';
  sLANG_SP = 'Испанский';

  sCITY_SHORT = 'г.';
  sHOUSE_SHORT = 'д.';
  sFLAT_SHORT = 'кв.';

  sBOOK_CODE = 'Код книги';
  sVISITOR_ID = 'Код посетителя';
  sRETURN_PERIOD = 'Срок возврата (дней)';
  sFIRST_NAME = 'Имя';
  sMIDDLE_NAME = 'Отчество';
  sLAST_NAME = 'Фамилия';
  sSTREET = 'Улица';
  sCITY = 'Город';
  sHOUSE = 'Дом';
  sFLAT = 'Квартира';

type
  TListType = (cBOOKS, cVISITORS, cBORROWS);
  TListAttribute = (cFULL, cOPEN, cCLOSE, cTITLE, cNAME);
  TDialogType = (cADD, cCHANGE, cDELETE);
  TfrmMain = class(TForm)
    alMain: TActionList;
    aAddBook: TAction;
    aDeleteBook: TAction;
    aChangeBook: TAction;
    aAddVisitor: TAction;
    aDeleteVisitor: TAction;
    aChangeVisitor: TAction;
    aAddBorrow: TAction;
    aChangeBorrow: TAction;
    menuMain: TMainMenu;
    miBooks: TMenuItem;
    miVisitors: TMenuItem;
    miBorrows: TMenuItem;
    msiAddBook: TMenuItem;
    msiAddVisitor: TMenuItem;
    msiAddBorrow: TMenuItem;
    pnlControls: TPanel;
    btnShowBadVisitors: TBitBtn;
    aShowDebts: TAction;
    aShowBadVisitors: TAction;
    aShowBorrowedBooks: TAction;
    aFindBooksByAuthor: TAction;
    aFindBooksByTitle: TAction;
    btnShowDebts: TButton;
    btnShowBorrowedBooks: TButton;
    btnFindBooksByAuthor: TButton;
    editBooksAuthor: TEdit;
    editBooksTitle: TEdit;
    btnFindBooksByTitle: TButton;
    btnShowAllBooks: TButton;
    aShowAllBooks: TAction;
    btnShowAllVisitors: TButton;
    aShowAllVisitors: TAction;
    editVisitorsName: TEdit;
    btnFindVisitorsByName: TButton;
    aFindVisitorsByName: TAction;
    bevelLineTop: TBevel;
    btnShowNotBorrowedBooks: TButton;
    aShowNotBorrowedBooks: TAction;
    bevelLineBottom: TBevel;
    btnShowAllBorrows: TButton;
    btnShowOpenBorrows: TButton;
    btnShowClosedBorrows: TButton;
    aShowAllBorrows: TAction;
    aShowOpenBorrows: TAction;
    aShowClosedBorrows: TAction;
    pnlLists: TPanel;
    labelCurrentList: TLabel;
    lvCurrentList: TListView;
    msiChangeBook: TMenuItem;
    msiChangeVisitor: TMenuItem;
    msiDeleteVisitor: TMenuItem;
    msiDeleteBook: TMenuItem;
    msiChangeBorrow: TMenuItem;
    aCloseBorrow: TAction;
    msiCloseBorrow: TMenuItem;
    msiBookSplitter: TMenuItem;
    msiShowAllBooks: TMenuItem;
    msiShowBorrowedBooks: TMenuItem;
    msiShowNotBorrowedBooks: TMenuItem;
    msiVisitorSplitter: TMenuItem;
    msiShowAllVisitors: TMenuItem;
    msiShowDebts: TMenuItem;
    msiShowBadVisitors: TMenuItem;
    msiBorrowSplitter: TMenuItem;
    msiShowAllBorrows: TMenuItem;
    msiShowOpenBorrows: TMenuItem;
    msiShowClosedBorrows: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure aAddBookExecute(Sender: TObject);
    procedure aShowAllVisitorsExecute(Sender: TObject);
    procedure aShowAllBooksExecute(Sender: TObject);
    procedure aShowAllBorrowsExecute(Sender: TObject);
    procedure aAddVisitorExecute(Sender: TObject);
    procedure aAddBorrowExecute(Sender: TObject);
    procedure aFindBooksByTitleExecute(Sender: TObject);
    procedure aFindBooksByAuthorExecute(Sender: TObject);
    procedure aFindVisitorsByNameExecute(Sender: TObject);
    procedure aShowOpenBorrowsExecute(Sender: TObject);
    procedure aShowClosedBorrowsExecute(Sender: TObject);
    procedure aShowNotBorrowedBooksExecute(Sender: TObject);
    procedure aShowBorrowedBooksExecute(Sender: TObject);
    procedure aShowDebtsExecute(Sender: TObject);
    procedure aShowBadVisitorsExecute(Sender: TObject);
    procedure aChangeBookExecute(Sender: TObject);
    procedure aDeleteBookExecute(Sender: TObject);
    procedure aDeleteVisitorExecute(Sender: TObject);
    procedure aChangeVisitorExecute(Sender: TObject);
    procedure aChangeBorrowExecute(Sender: TObject);
    procedure aCloseBorrowExecute(Sender: TObject);
  private
    // Тип текущего выведенного списка
    currentListType: TListType;

    // Определяет какие записи требуется вывести
    currentListAttribute: TListAttribute;

    // Устанавливает заголовки компонентов
    procedure setCaptions;

    // Заполняет столбцы listView
    procedure setColumnsBooks;   
    procedure setColumnsVisitors;
    procedure setColumnsBorrows;

    // Выводит список
    procedure showBooksList;
    procedure showVisitorsList;
    procedure showBorrowsList;

  public
    // Тип вызываемого диалога
    dialogType: TDialogType;

    //Определяет, какой список необходимо вывести
    procedure showList;
  end;

var
  frmMain: TfrmMain;

implementation

uses DateUtils, UAddBook, UAddVisitor, UAddBorrow;

{$R *.dfm}

procedure TfrmMain.setCaptions;
begin
  editBooksAuthor.Text := sENTER_BOOK_AUTHOR;
  editBooksTitle.Text := sENTER_BOOK_TITLE;
  editVisitorsName.Text := sENTER_VISITOR_NAME;
  aAddBook.Caption := sADD_BOOK;
  aDeleteBook.Caption := sDELETE_BOOK;
  aChangeBook.Caption := sCHANGE_BOOK;
  aAddVisitor.Caption := sADD_VISITOR;
  aDeleteVisitor.Caption := sDELETE_VISITOR;
  aChangeVisitor.Caption := sCHANGE_VISITOR;
  aAddBorrow.Caption := sADD_BORROW;
  aChangeBorrow.Caption := sCHANGE_BORROW;
  aCloseBorrow.Caption := sCLOSE_BORROW;
  aShowAllVisitors.Caption := sSHOW_ALL_VISITORS;
  aShowDebts.Caption := sSHOW_DEBTS;
  aShowBadVisitors.Caption := sSHOW_BAD_VISITORS;
  aShowAllBooks.Caption := sSHOW_ALL_BOOKS;
  aShowBorrowedBooks.Caption := sSHOW_BORROWED_BOOKS;
  aShowNotBorrowedBooks.Caption := sSHOW_NOT_BORROWED_BOOKS;
  aShowAllBorrows.Caption := sSHOW_ALL_BORROWS;
  aShowOpenBorrows.Caption := sSHOW_OPEN_BORROWS;
  aShowClosedBorrows.Caption := sSHOW_CLOSED_BORROWS;
  aFindBooksByAuthor.Caption := sFIND_BOOKS_BY_AUTHOR;
  aFindBooksByTitle.Caption := sFIND_BOOKS_BY_TITLE;
  aFindVisitorsByName.Caption := sFIND_VISITORS_BY_NAME;
end;
        
// Заполняет столбцы listView
procedure TfrmMain.setColumnsBooks;     
var
  listColumn: TListColumn;
begin
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sCODE;
  listColumn.Width := 50;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sTITLE;
  listColumn.Width := 150;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sAUTHOR;
  listColumn.Width := 150;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sPUBLISH_YEAR;
  listColumn.Width := 125;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sPUBLISH_LANG;
  listColumn.Width := 125;
end;        

// Заполняет столбцы listView
procedure TfrmMain.setColumnsVisitors;
var
  listColumn: TListColumn;
begin
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sCODE;
  listColumn.Width := 50;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sNAME;
  listColumn.Width := 200;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sADDRESS;
  listColumn.Width := 200;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sPHONE;
  listColumn.Width := 125;
end;
 
// Заполняет столбцы listView
procedure TfrmMain.setColumnsBorrows;
var
  listColumn: TListColumn;
begin
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sCODE;
  listColumn.Width := 40;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sBOOK_TITLE;
  listColumn.Width := 150;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sNAME;
  listColumn.Width := 200;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sBORROW_DATE;
  listColumn.Width := 100;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sEXP_RETURN_DATE;
  listColumn.Width := 100;
  listColumn := lvCurrentList.Columns.Add;
  listColumn.Caption := sREAL_RETURN_DATE;
  listColumn.Width := 100;
end;           
       
// Выводит список книг
procedure TfrmMain.showBooksList;
var
  book: TBooks; 
  borrow: TBorrows;
  i, j: Integer;
  listItem: TListItem;
  error: Boolean;
begin
  SetLength(book, 0); 
  SetLength(borrow, 0);
  error := false;
  case currentListAttribute of
    // Вывод всех книг
    cFULL:
    begin
      labelCurrentList.Caption := sALL_BOOKS;
      book := returnAllBooks;
    end;
    // Вывод невзятых книг
    cOPEN:
    begin
      labelCurrentList.Caption := sNOT_BORROWED_BOOKS;
      book := returnAllBooks;
      borrow := returnOpenBorrows;
      for i := 0 to length(book) - 1 do
      begin
        error := false;
        for j := 0 to length(borrow) - 1 do
        begin
          if book[i].code = borrow[j].bookCode then
            error := true;
        end;
        if not error then
          book[i].code := -1;
      end;
      error := false;
    end;
    // Вывод взятых книг
    cCLOSE:
    begin             
      labelCurrentList.Caption := sBORROWED_BOOKS;
      book := returnAllBooks;
      borrow := returnOpenBorrows;
      for i := 0 to length(book) - 1 do
      begin
        error := false;
        for j := 0 to length(borrow) - 1 do
        begin
          if book[i].code = borrow[j].bookCode then
            error := true;
        end;
        if error then
          book[i].code := -1;
      end;
      error := false;
    end;         
    // Поиск по названию
    cTITLE:
    begin
      labelCurrentList.Caption := sTITLE_BOOK_SEARCH;
      if editBooksTitle.Text <> sENTER_BOOK_TITLE then
      begin
        book := findByTitle(editBooksTitle.Text);
      end
      else
      begin
        error := true;
        MessageBox(Handle, PChar(sENTER_BOOK_TITLE), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end;
    end;
    // Поиск по автору
    cNAME:
    begin
      labelCurrentList.Caption := sAUTHOR_BOOK_SEARCH;
      if editBooksAuthor.Text <> sENTER_BOOK_AUTHOR then
      begin
        book := findByAuthor(editBooksAuthor.Text);
      end
      else
      begin
        error := true;
        MessageBox(Handle, PChar(sENTER_BOOK_AUTHOR), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end;
    end;
  end;
  if not error then
  begin
    // Очистка listView
    lvCurrentList.Clear;
    lvCurrentList.Columns.Clear;
    setColumnsBooks;
    // Вывод элементов
    for i := 0 to length(book) - 1 do
    begin
      if book[i].code <> -1 then
      begin
        listItem := lvCurrentList.Items.Add;
        listItem.Caption := IntToStr(book[i].code);
        listItem.SubItems.Add(book[i].bookTitle);
        listItem.SubItems.Add(book[i].authorSurname);
        listItem.SubItems.Add(IntToStr(book[i].publishYear));
        listItem.SubItems.Add(langToStr(book[i].publishLang));
      end;
    end;
  end;
end;
   
// Выводит список посетителей
procedure TfrmMain.showVisitorsList;
var
  visitor: TVisitors;  
  borrow: TBorrows;
  i, j: Integer;
  listItem: TListItem;
  error: Boolean;
  today: TDateTime;
begin
  error := false;
  SetLength(visitor, 0);
  SetLength(borrow, 0);
  case currentListAttribute of
    // Вывод всех посетителей
    cFULL:
    begin
      labelCurrentList.Caption := sALL_VISITORS;
      visitor := returnAllVisitors;
    end;
    // Вывод должников
    cOPEN:
    begin
      labelCurrentList.Caption := sDEBTS;
      today := date;
      visitor := returnAllVisitors;
      borrow := returnOpenBorrows;
      for i := 0 to length(visitor) - 1 do
      begin
        error := false;
        for j := 0 to length(borrow) - 1 do
          if borrow[j].visitorID = visitor[i].ID then
            if borrow[j].expReturnDate + 10 < today then
              error := true;
        if not error then
          visitor[i].ID := -1;
      end;
      error := false;
    end;
    cCLOSE:
    // Вывод недоверенных
    begin
      labelCurrentList.Caption := sBAD_VISITORS;
      today := date;
      visitor := returnAllVisitors;
      borrow := returnAllBorrows;
      for i := 0 to length(visitor) - 1 do
      begin
        error := false;
        for j := 0 to length(borrow) - 1 do
        begin
          if borrow[j].visitorID = visitor[i].ID then
          begin  
            if borrow[j].realReturnDate = -1 then
            begin
              if borrow[j].expReturnDate + 10 < today then
                error := true;
            end
            else
            begin
              if borrow[j].expReturnDate + 10 < borrow[j].realReturnDate then
                error := true;
            end;
          end;
        end;
        if not error then
          visitor[i].ID := -1;
      end;
      error := false;
    end;            
    // Поиск по фамилии
    cNAME:
    begin
      labelCurrentList.Caption := sNAME_VISITOR_SEARCH;
      if editVisitorsName.Text <> sENTER_VISITOR_NAME then
      begin
        visitor := findByName(toName('', '', editVisitorsName.Text));
      end
      else
      begin
        error := true;
        MessageBox(Handle, PChar(sENTER_VISITOR_NAME), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end;
    end;
  end;
  if not error then
  begin              
    // Очистка listView
    lvCurrentList.Clear;
    lvCurrentList.Columns.Clear;
    setColumnsVisitors;   
    // Вывод элементов
    for i := 0 to length(visitor) - 1 do
    begin       
      if visitor[i].ID <> -1 then
      begin
        listItem := lvCurrentList.Items.Add;
        listItem.Caption := IntToStr(visitor[i].ID);
        listItem.SubItems.Add(nameToStr(visitor[i].name));
        listItem.SubItems.Add(addressToStr(visitor[i].address));
        listItem.SubItems.Add(visitor[i].phoneNumber);
      end;
    end;
  end;
end;
   
// Выводит список записей о взятии книг
procedure TfrmMain.showBorrowsList;
var
  borrow: TBorrows;
  i: Integer;    
  listItem: TListItem;
begin
  SetLength(borrow, 0);
  case currentListAttribute of
    cFULL:
    begin         
      labelCurrentList.Caption := sALL_BORROWS;
      borrow := returnAllBorrows;
    end;
    cOPEN:
    begin
      labelCurrentList.Caption := sOPEN_BORROWS;
      borrow := returnOpenBorrows;
    end;
    cCLOSE:
    begin
      labelCurrentList.Caption := sCLOSED_BORROWS;
      borrow := returnClosedBorrows;
    end;
  end;
  // Очистка listView
  lvCurrentList.Clear;
  lvCurrentList.Columns.Clear;
  setColumnsBorrows;
  // Вывод элементов
  for i := 0 to length(borrow) - 1 do
  begin
    listItem := lvCurrentList.Items.Add;
    listItem.Caption := IntToStr(borrow[i].code);
    listItem.SubItems.Add(findByCode(borrow[i].bookCode).bookTitle);
    listItem.SubItems.Add(nameToStr(findByID(borrow[i].visitorID).name));
    listItem.SubItems.Add(DateToStr(borrow[i].borrowDate));
    listItem.SubItems.Add(DateToStr(borrow[i].expReturnDate));
    if borrow[i].realReturnDate = -1 then
      listItem.SubItems.Add('')
    else
      listItem.SubItems.Add(DateToStr(borrow[i].realReturnDate));
  end;
end;

// Определяет, какой список необходимо вывести
procedure TfrmMain.showList;
begin
  case currentListType of
    cBOOKS:
      showBooksList;
    cVISITORS:
      showVisitorsList;
    cBORROWS:
      showBorrowsList;
  end;
end;

// При создании формы выводит полный список книг
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  setCaptions;
  Caption := Application.Title;
  currentListType := cBOOKS;
  currentListAttribute := cFULL;
  showList;
end;

// Вывод полного списка книг
procedure TfrmMain.aShowAllBooksExecute(Sender: TObject);
begin
  currentListType := cBOOKS;
  currentListAttribute := cFULL;
  showList;
end;

// Вывод невзятых книг
procedure TfrmMain.aShowNotBorrowedBooksExecute(Sender: TObject);
begin
  currentListType := cBOOKS;
  currentListAttribute := cCLOSE;
  showList;
end;

// Вывод взятых книг
procedure TfrmMain.aShowBorrowedBooksExecute(Sender: TObject);
begin
  currentListType := cBOOKS;
  currentListAttribute := cOPEN;
  showList;
end;

// Вывод всех посетителей
procedure TfrmMain.aShowAllVisitorsExecute(Sender: TObject);
begin
  currentListType := cVISITORS;
  currentListAttribute := cFULL;
  showList;
end;       

// Вывод списка должников
procedure TfrmMain.aShowDebtsExecute(Sender: TObject);
begin
  currentListType := cVISITORS;
  currentListAttribute := cOPEN;
  showList;
end;

// Вывод списка недоверенных
procedure TfrmMain.aShowBadVisitorsExecute(Sender: TObject);
begin
  currentListType := cVISITORS;
  currentListAttribute := cCLOSE;
  showList;
end;

// Вывод всех записей
procedure TfrmMain.aShowAllBorrowsExecute(Sender: TObject);
begin
  currentListType := cBORROWS;
  currentListAttribute := cFULL;
  showList;
end;

// Вывод открытых записей
procedure TfrmMain.aShowOpenBorrowsExecute(Sender: TObject);
begin
  currentListType := cBORROWS;
  currentListAttribute := cOPEN;
  showList;
end;

// Вывод закрытых записей
procedure TfrmMain.aShowClosedBorrowsExecute(Sender: TObject);
begin
  currentListType := cBORROWS;
  currentListAttribute := cCLOSE;
  showList;
end;

// Поиск книги по заголовку
procedure TfrmMain.aFindBooksByTitleExecute(Sender: TObject);
begin
  currentListType := cBOOKS;
  currentListAttribute := cTITLE;
  showList;
end;

// Поиск книги по автору
procedure TfrmMain.aFindBooksByAuthorExecute(Sender: TObject);
begin
  currentListType := cBOOKS;
  currentListAttribute := cNAME;
  showList;
end;

// Поиск посетителя по фамилии
procedure TfrmMain.aFindVisitorsByNameExecute(Sender: TObject);
begin
  currentListType := cVISITORS;
  currentListAttribute := cNAME;
  showList;
end;

// Добавление книги
procedure TfrmMain.aAddBookExecute(Sender: TObject);
begin
  dialogType := cADD;
  if (Assigned(frmAddBook)) then
    frmAddBook.Close;
  frmAddBook:=TfrmAddBook.Create(Self);
end;                

// Изменение книги
procedure TfrmMain.aChangeBookExecute(Sender: TObject);
begin
  dialogType := cCHANGE;
  if (Assigned(frmAddBook)) then
    frmAddBook.Close;
  frmAddBook:=TfrmAddBook.Create(Self);
end;        

// Удаление книги
procedure TfrmMain.aDeleteBookExecute(Sender: TObject);
begin
  dialogType := cDELETE;
  if (Assigned(frmAddBook)) then
    frmAddBook.Close;
  frmAddBook:=TfrmAddBook.Create(Self);
end;

// Добавление посетителя
procedure TfrmMain.aAddVisitorExecute(Sender: TObject);
begin
  dialogType := cADD;
  if (Assigned(frmAddVisitor)) then
    frmAddVisitor.Close;
  frmAddVisitor:=TfrmAddVisitor.Create(Self);
end;       

// Изменение посетителя
procedure TfrmMain.aChangeVisitorExecute(Sender: TObject);
begin
  dialogType := cCHANGE;
  if (Assigned(frmAddVisitor)) then
    frmAddVisitor.Close;
  frmAddVisitor:=TfrmAddVisitor.Create(Self);
end;

// Удаление посетителя
procedure TfrmMain.aDeleteVisitorExecute(Sender: TObject);
begin
  dialogType := cDELETE;
  if (Assigned(frmAddVisitor)) then
    frmAddVisitor.Close;
  frmAddVisitor:=TfrmAddVisitor.Create(Self);
end;

// Добавление записи
procedure TfrmMain.aAddBorrowExecute(Sender: TObject);
begin
  dialogType := cADD;
  if (Assigned(frmAddBorrow)) then
    frmAddBorrow.Close;
  frmAddBorrow:=TfrmAddBorrow.Create(Self);
end;

// Изменение записи
procedure TfrmMain.aChangeBorrowExecute(Sender: TObject);
begin
  dialogType := cCHANGE;
  if (Assigned(frmAddBorrow)) then
    frmAddBorrow.Close;
  frmAddBorrow:=TfrmAddBorrow.Create(Self);
end;

// Закрытие записи
procedure TfrmMain.aCloseBorrowExecute(Sender: TObject);
begin
  dialogType := cDELETE;
  if (Assigned(frmAddBorrow)) then
    frmAddBorrow.Close;
  frmAddBorrow:=TfrmAddBorrow.Create(Self);
end;

end.
