unit USelectCode;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDialogType = (cBOOK, cVISITOR, cBORROW);
  TfrmSelectCode = class(TForm)
    editCode: TEdit;
    labelCode: TLabel;
    btnComplete: TButton;
    procedure editCodeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCompleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    dialogType: TDialogType;
    result: Integer;
  end;

var
  frmSelectCode: TfrmSelectCode;

implementation

uses
  UBookList, UVisitorList, UBorrowList, UMain,
  UAddBook, UAddVisitor, UAddBorrow;

{$R *.dfm}

// Запрещает ввод не-цифр в поле ввода кода
procedure TfrmSelectCode.editCodeKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;

// Проверяет введённый код и возвращает в вызывающий диалог код
procedure TfrmSelectCode.btnCompleteClick(Sender: TObject);
begin
  if editCode.Text <> '' then
  begin
  case dialogType of
    cBOOK:
    begin
      if not bookExist(StrToInt(editCode.Text)) then
      begin
        MessageBox(Handle, PChar(sINCORRECT_BOOK_CODE), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end
      else
      begin
        frmAddBook.code := StrToInt(editCode.Text);
        frmAddBook.showBook(frmAddBook.code);
        Visible := false;
        frmAddBook.Visible := true;
      end;
    end;
    cVISITOR:
    begin
      if not visitorExist(StrToInt(editCode.Text)) then
      begin
        MessageBox(Handle, PChar(sINCORRECT_VISITOR_ID), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end
      else
      begin
        frmAddVisitor.code := StrToInt(editCode.Text);
        frmAddVisitor.showVisitor(frmAddVisitor.code);
        Visible := false;
        frmAddVisitor.Visible := true;
      end;
    end;
    cBORROW:
    begin
      if not borrowExist(StrToInt(editCode.Text)) then
      begin
        MessageBox(Handle, PChar(sINCORRECT_BORROW_CODE), PChar(sERROR), MB_OK or MB_ICONWARNING);
      end
      else
      begin
        frmAddBorrow.code := StrToInt(editCode.Text);
        frmAddBorrow.showBorrow(frmAddBorrow.code);
        Visible := false;
        frmAddBorrow.Visible := true;
      end;
    end;
  end;
  end
  else
    MessageBox(Handle, PChar(sFIELD_MUST_BE_FILLED), PChar(sERROR), MB_OK or MB_ICONWARNING);
end;

// Заполняет начальные значения метки и кнопки
procedure TfrmSelectCode.FormShow(Sender: TObject);
begin
  labelCode.Caption := sENTER_CODE;
  Caption := sENTER_CODE;
  btnComplete.Caption := sSELECT;
end;

end.
