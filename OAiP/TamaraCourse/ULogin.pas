unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmLogin = class(TForm)
    panelPlayerX: TPanel;
    panelPlayerO: TPanel;
    labelX: TLabel;
    labelO: TLabel;
    btnPlayerX: TSpeedButton;
    btnIIX: TSpeedButton;
    panelStart: TPanel;
    btnPlayerO: TSpeedButton;
    btnIIO: TSpeedButton;
    btnStartGame: TButton;
    editXName: TEdit;
    editOName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnIIXClick(Sender: TObject);
    procedure btnIIOClick(Sender: TObject);
    procedure editXNameEnter(Sender: TObject);
    procedure editXNameExit(Sender: TObject);
    procedure editONameEnter(Sender: TObject);
    procedure editONameExit(Sender: TObject);
    procedure btnStartGameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses Math, UMain;

{$R *.dfm}

const
  sENTER_X_NAME = 'Введите имя крестиков';
  sENTER_O_NAME = 'Введите имя ноликов';

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  editXName.Text := sENTER_X_NAME;
  editOName.Text := sENTER_O_NAME;
  btnPlayerX.Down := true;
  btnIIO.Down := true;
end;

{ Нельзя выбрать двух компьютеров }
procedure TfrmLogin.btnIIXClick(Sender: TObject);
begin
  btnPlayerO.Down := true;
end;

procedure TfrmLogin.btnIIOClick(Sender: TObject);
begin
  btnPlayerX.Down := true;
end;

{ При нажатии на поле, убирает подсказку }
procedure TfrmLogin.editXNameEnter(Sender: TObject);
begin
  if editXName.Text = sENTER_X_NAME then
    editXName.Text := '';
end;

{ При выходе из поля, возвращает подсказку }
procedure TfrmLogin.editXNameExit(Sender: TObject);
begin
  if editXName.Text = '' then
    editXName.Text := sENTER_X_NAME;
end;
                                    
{ При нажатии на поле, убирает подсказку }
procedure TfrmLogin.editONameEnter(Sender: TObject);
begin
  if editOName.Text = sENTER_O_NAME then
    editOName.Text := '';
end;
                                
{ При выходе из поля, возвращает подсказку }
procedure TfrmLogin.editONameExit(Sender: TObject);
begin
  if editOName.Text = '' then
    editOName.Text := sENTER_O_NAME;
end;

{ Запускает главную форму }
procedure TfrmLogin.btnStartGameClick(Sender: TObject);
begin
  if (editOName.Text = sENTER_O_NAME) or (editXName.Text = sENTER_X_NAME) then
  begin
    ShowMessage('Введите имена игроков');
  end
  else
  begin
    if Assigned(frmMain) then
      frmMain.Close;
    frmMain := TfrmMain.Create(Self);
    frmMain.FIsPlayer1II := btnIIX.Down;  // Если эта кнопка нажата, то за 1 игрока играет компьютер
    frmMain.FIsPlayer2II := btnIIO.Down;
    frmMain.FPlayer1Name := editXName.Text;
    frmMain.FPlayer2Name := editOName.Text;
    Self.Hide;
    frmMain.Show;
  end;
end;

end.
