unit UAddVisitor;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, UVisitorList;

type
  TfrmAddVisitor = class(TForm)
    labelLastName: TLabel;
    editLastName: TEdit;
    editFirstName: TEdit;
    editMiddleName: TEdit;
    labelFirstName: TLabel;
    labelMiddleName: TLabel;
    labelStreet: TLabel;
    editStreet: TEdit;
    editHouse: TEdit;
    editPhone: TEdit;
    labelHouse: TLabel;
    labelPhone: TLabel;
    editFlat: TEdit;
    labelFlat: TLabel;
    btnAddVisitor: TButton;
    labelCity: TLabel;
    editCity: TEdit;
    procedure editHouseKeyPress(Sender: TObject; var Key: Char);
    procedure editFlatKeyPress(Sender: TObject; var Key: Char);
    procedure editPhoneKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddVisitorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    code: Integer;
    procedure showVisitor(code: Integer);
  end;

var
  frmAddVisitor: TfrmAddVisitor;

implementation

uses UMain, USelectCode, UBorrowList;

{$R *.DFM}
                
// Запрещает ввод не-цифр в поле ввода номера дома
procedure TfrmAddVisitor.editHouseKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;
            
// Запрещает ввод не-цифр в поле ввода номера квартиры
procedure TfrmAddVisitor.editFlatKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', #8: ;
    else
      key := #0;
  end;
end;

// Запрещает ввод не-цифр в поле ввода номера телефона
procedure TfrmAddVisitor.editPhoneKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9', #8, '-': ;
    else
      key := #0;
  end;
end;

// Проверяет введённые значения
// В зависимости от типа вызова диалого
// Добавляет, изменяет или удаляет запись в списке
procedure TfrmAddVisitor.btnAddVisitorClick(Sender: TObject);
var
  borrow: TBorrows;
  i: Integer;
begin
  SetLength(borrow, 0);
  if editHouse.Text <> '' then
  begin
    if editFlat.Text = '' then
      editFlat.Text := '-1';
    case frmMain.dialogType of
      cCHANGE:
        changeByID(code, toVisitor(code,
                   toName(editFirstName.Text, editMiddleName.Text, editLastName.Text),
                   toAddress(editCity.Text, editStreet.Text, StrToInt(editHouse.Text),
                   StrToInt(editFlat.Text)),
                   editPhone.Text));
      cADD:
        addVisitor(toVisitor(visitorsLen + 1,
                  toName(editFirstName.Text, editMiddleName.Text, editLastName.Text),
                  toAddress(editCity.Text, editStreet.Text, StrToInt(editHouse.Text),
                  StrToInt(editFlat.Text)),
                  editPhone.Text));
      cDELETE:
      begin
        deleteByID(code);
        borrow := returnAllBorrows;
        for i := 0 to length(borrow) - 1 do
        begin
          if borrow[i].visitorID = code then
            deleteByVisitorCode(borrow[i].visitorID);
        end;
      end;
    end;
    frmMain.showList;
    Self.Close;
  end
  else
    MessageBox(Handle, PChar(sENTER_HOUSE_NUMBER), PChar(sERROR), MB_OK or MB_ICONWARNING);
end;
             
// Заполняет поля значениями выбранной записи
procedure TfrmAddVisitor.showVisitor(code: Integer);
var
  visitor: TVisitor;
begin
  visitor := findByID(code);
  editLastName.Text := visitor.name.lastName;
  editFirstName.Text := visitor.name.firstName;
  editMiddleName.Text := visitor.name.middleName;
  editCity.Text := visitor.address.city;
  editStreet.Text := visitor.address.street;
  editHouse.Text := IntToStr(visitor.address.houseNumber);
  if visitor.address.blockOfFlats then
    editFlat.Text := IntToStr(visitor.address.flatNumber);
  editPhone.Text := visitor.phoneNumber;
  Self.code := visitor.ID;
end;
              
// При создании формы вызывает диалог ввода кода записи
procedure TfrmAddVisitor.FormCreate(Sender: TObject);
begin
  Visible := false;
  labelLastName.Caption := sLAST_NAME;
  labelFirstName.Caption := sFIRST_NAME;
  labelMiddleName.Caption := sMIDDLE_NAME;
  labelStreet.Caption := sSTREET;
  labelCity.Caption := sCITY;
  labelHouse.Caption := sHOUSE;
  labelFlat.Caption := sFLAT;
  labelPhone.Caption := sPHONE;
  code := 0;
  if (frmMain.dialogType = cCHANGE) or (frmMain.dialogType = cDELETE) then
  begin
    if frmMain.dialogType = cCHANGE then
    begin             
      Caption := sCHANGE_VISITOR;
      btnAddVisitor.Caption := sCHANGE_VISITOR;
    end
    else
    begin
      btnAddVisitor.Caption := sDELETE_VISITOR;
      Caption := sDELETE_VISITOR;
    end;
    if (Assigned(frmSelectCode)) then
      frmSelectCode.Close;
    frmSelectCode:=TfrmSelectCode.Create(Self);
    frmSelectCode.dialogType := cVISITOR;
    frmSelectCode.Visible := true;
  end
  else
  begin                             
    Caption := sADD_VISITOR;
    btnAddVisitor.Caption := sADD_VISITOR;
    visible := true;
  end;
end;
                      
// Закрывает вызванный диалог
procedure TfrmAddVisitor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if (Assigned(frmSelectCode)) then
    frmSelectCode.Close;
end;

end.
