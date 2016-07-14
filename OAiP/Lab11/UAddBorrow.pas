unit UAddBorrow;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, ComCtrls, UBorrowList, UVisitorList, UBookList;

type
  TfrmAddBorrow = class(TForm)
    dtpBorrowDate: TDateTimePicker;
    labelBookCode: TLabel;
    editBookCode: TEdit;
    editVisitorID: TEdit;
    labelVisitorID: TLabel;
    labelBorrowDate: TLabel;
    labelPeriod: TLabel;
    editPeriod: TEdit;
    udPeriod: TUpDown;
    btnAddBorrow: TButton;
    procedure editBookCodeKeyPress(Sender: TObject; var Key: Char);
    procedure editVisitorIDKeyPress(Sender: TObject; var Key: Char);
    procedure editPeriodKeyPress(Sender: TObject; var Key: Char);
    procedure udPeriodClick(Sender: TObject; Button: TUDBtnType);
    procedure btnAddBorrowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    code: Integer;
    procedure showBorrow(code: Integer);
  end;

var
  frmAddBorrow: TfrmAddBorrow;

implementation

uses UMain, USelectCode;

{$R *.DFM}

// Запрещает ввод не-цифр в поле ввода кода книги
procedure TfrmAddBorrow.editBookCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;
                        
// Запрещает ввод не-цифр в поле ввода кода посетителя
procedure TfrmAddBorrow.editVisitorIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;
                          
// Запрещает ввод не-цифр в поле ввода кода срока возврата
procedure TfrmAddBorrow.editPeriodKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;
           
// Увеличивает значение в поле периода при нажатии клавиш вверх-вниз
procedure TfrmAddBorrow.udPeriodClick(Sender: TObject; Button: TUDBtnType);
var
  current: Integer;
begin
  if editPeriod.Text = '' then
  begin
    current := 1;
    udPeriod.Position := 0;
  end
  else
    current := StrToInt(editPeriod.Text);
  if button = btNext then
    inc(current)
  else
    dec(current);
  editPeriod.Text := IntToStr(current);
end;
                           
// Проверяет введённые значения
// В зависимости от типа вызова диалого
// Добавляет, изменяет или закрывает запись в списке
procedure TfrmAddBorrow.btnAddBorrowClick(Sender: TObject);
begin
  if (editBookCode.Text <> '') and (editVisitorID.Text <> '') and (editPeriod.Text <> '') then
  begin
    if bookExist(StrToInt(editBookCode.Text)) then
    begin
      if visitorExist(StrToInt(editVisitorID.Text)) then
      begin   
        case frmMain.dialogType of
          cCHANGE:     
            changeByBorrowCode(code, toBorrow(code,
                                        StrToInt(editVisitorID.Text),
                                        StrToInt(editBookCode.Text),
                                        dtpBorrowDate.DateTime,
                                        dtpBorrowDate.DateTime +
                                        StrToInt(editPeriod.Text),
                                        -1));
          cADD:
            addBorrow(toBorrow(borrowsLen + 1,
                              StrToInt(editVisitorID.Text),
                              StrToInt(editBookCode.Text),
                              dtpBorrowDate.DateTime,
                              dtpBorrowDate.DateTime +
                              StrToInt(editPeriod.Text),
                              -1));
          cDELETE:
            changeByBorrowCode(code, toBorrow(code,
                                        StrToInt(editVisitorID.Text),
                                        StrToInt(editBookCode.Text),
                                        dtpBorrowDate.DateTime,
                                        dtpBorrowDate.DateTime +
                                        StrToInt(editPeriod.Text),
                                        date));
        end;
        frmMain.showList;
        Self.Close;
      end
      else
        MessageBox(Handle, PChar(sINCORRECT_VISITOR_ID), PChar(sERROR), MB_OK or MB_ICONWARNING);
    end
    else
      MessageBox(Handle, PChar(sINCORRECT_BOOK_CODE), PChar(sERROR), MB_OK or MB_ICONWARNING);
  end
  else
    MessageBox(Handle, PChar(sENTER_CORRECT_DATA), PChar(sERROR), MB_OK or MB_ICONWARNING);
end;

// При создании формы вызывает диалог ввода кода записи
procedure TfrmAddBorrow.FormCreate(Sender: TObject);
begin
  Visible := false;
  labelBookCode.Caption := sBOOK_CODE;
  labelVisitorID.Caption := sVISITOR_ID;
  labelBorrowDate.Caption := sBORROW_DATE;
  labelPeriod.Caption := sRETURN_PERIOD;
  code := 0;
  if (frmMain.dialogType = cCHANGE) or (frmMain.dialogType = cDELETE) then
  begin
    if frmMain.dialogType = cCHANGE then
    begin
      btnAddBorrow.Caption:= sCHANGE_BORROW;
      Caption := sCHANGE_BORROW;
    end
    else
    begin
      btnAddBorrow.Caption := sCLOSE_BORROW;
      Caption := sCLOSE_BORROW;
    end;
    if (Assigned(frmSelectCode)) then
      frmSelectCode.Close;
    frmSelectCode:=TfrmSelectCode.Create(Self);
    frmSelectCode.dialogType := cBORROW;
    frmSelectCode.Visible := true;
  end
  else
  begin                 
    Caption := sADD_BORROW;
    btnAddBorrow.Caption := sADD_BORROW;
    visible := true;
  end;
end;
                       
// Заполняет поля значениями выбранной записи
procedure TfrmAddBorrow.showBorrow(code: Integer);
var
  borrow: TBorrow;
begin
  borrow := findByBorrowCode(code);
  editBookCode.Text := IntToStr(borrow.bookCode);
  editVisitorID.Text := IntToStr(borrow.visitorID);
  editPeriod.Text := IntToStr(round(borrow.expReturnDate - borrow.borrowDate));
  dtpBorrowDate.DateTime := borrow.borrowDate;
  Self.code := borrow.code;
end;

// Закрывает вызванный диалог
procedure TfrmAddBorrow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Assigned(frmSelectCode)) then
    frmSelectCode.Close;
end;

end.
