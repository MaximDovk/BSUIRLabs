unit UAddBook;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, UBookList, USelectCode;

type
  TfrmAddBook = class(TForm)
    btnComplete: TButton;
    editTitle: TEdit;
    labelTitle: TLabel;
    editAuthor: TEdit;
    labelAuthor: TLabel;
    udPublishYear: TUpDown;
    comboLang: TComboBox;
    labelPublishYear: TLabel;
    labelPublishLanguage: TLabel;
    editPublishYear: TEdit;
    procedure editPublishYearKeyPress(Sender: TObject; var Key: Char);
    procedure udPublishYearClick(Sender: TObject; Button: TUDBtnType);
    procedure btnCompleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    code: Integer;
    procedure showBook(code: Integer);
  end;

var
  frmAddBook: TfrmAddBook;

implementation

{$R *.DFM}

uses
  UMain, UBorrowList;
                
// Запрещает ввод не-цифр в поле ввода года
procedure TfrmAddBook.editPublishYearKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;

// Увеличивает значение в поле года при нажатии клавиш вверх-вниз
procedure TfrmAddBook.udPublishYearClick(Sender: TObject;
  Button: TUDBtnType);
var
  current: Integer;
begin
  if editPublishYear.Text = '' then
  begin
    current := 1;
    udPublishYear.Position := 0;
  end
  else
    current := StrToInt(editPublishYear.Text);
  if button = btNext then
    inc(current)
  else
    dec(current);
  editPublishYear.Text := IntToStr(current);
end;

// Проверяет введённые значения
// В зависимости от типа вызова диалого
// Добавляет, изменяет или удаляет запись в списке
procedure TfrmAddBook.btnCompleteClick(Sender: TObject);
var
  borrow: TBorrows;
  i: Integer;
begin         
  SetLength(borrow, 0);
  if editPublishYear.Text <> '' then
  begin
    case frmMain.dialogType of
      cCHANGE:
        changeByCode(code, toBook(code, editAuthor.Text, editTitle.Text,
                     StrToInt(editPublishYear.Text), TLang(comboLang.ItemIndex)));
      cADD:
        addBook(toBook(booksLen + 1, editAuthor.Text, editTitle.Text,
                StrToInt(editPublishYear.Text), TLang(comboLang.ItemIndex)));
      cDELETE:
      begin
        deleteByCode(code);
        borrow := returnAllBorrows;
        for i := 0 to length(borrow) - 1 do
        begin
          if borrow[i].bookCode = code then
            deleteByBookCode(borrow[i].bookCode);
        end;
      end;
    end;
    frmMain.showList;
    Self.Close;
  end
  else
    MessageBox(Handle, PChar(sENTER_PUBLISH_YEAR), PChar(sERROR), MB_OK or MB_ICONWARNING);
end;

// При создании формы вызывает диалог ввода кода записи
procedure TfrmAddBook.FormCreate(Sender: TObject);
begin
  Visible := false;
  labelTitle.Caption := sTITLE;
  labelAuthor.Caption := sAUTHOR;
  labelPublishYear.Caption := sPUBLISH_YEAR;
  labelPublishLanguage.Caption := sPUBLISH_LANG;
  code := 0;
  if (frmMain.dialogType = cCHANGE) or (frmMain.dialogType = cDELETE) then
  begin
    if frmMain.dialogType = cCHANGE then
    begin
      btnComplete.Caption := sCHANGE_BOOK; 
      Caption := sCHANGE_BOOK;
    end
    else
    begin
      btnComplete.Caption := sDELETE_BOOK; 
      Caption := sDELETE_BOOK;
    end;
    if (Assigned(frmSelectCode)) then
      frmSelectCode.Close;
    frmSelectCode:=TfrmSelectCode.Create(Self);
    frmSelectCode.dialogType := cBOOK;
    frmSelectCode.Visible := true;
  end
  else
  begin
    Caption := sADD_BOOK;
    btnComplete.Caption := sADD_BOOK;
    visible := true;
  end;
end;
                      
// Заполняет поля значениями выбранной записи
procedure TfrmAddBook.showBook(code: Integer);
var
  book: TBook;
begin
  book := findByCode(code);
  editTitle.Text := book.bookTitle;
  editAuthor.Text := book.authorSurname;
  editPublishYear.Text := IntToStr(book.publishYear);
  comboLang.ItemIndex := ord(book.publishLang);
  Self.code := book.code;
end;

// Закрывает вызванный диалог
procedure TfrmAddBook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Assigned(frmSelectCode)) then
    frmSelectCode.Close;
end;

end.
