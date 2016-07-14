unit UMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons;

type
  TfrmMenu = class(TForm)
    imageTitle: TImage;
    btnNewGame: TSpeedButton;
    btnLoadGame: TSpeedButton;
    btnResult: TSpeedButton;
    btnExit: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNewGameClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnLoadGameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
  private
    function checkFiles:Boolean;
  public

  end;

var
  frmMenu: TfrmMenu;

implementation

uses UMain, UResults;

{$R *.dfm}

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  Color := RGB(61, 115, 43);
  if not checkFiles then
  begin
    btnNewGame.Enabled := false; 
    btnLoadGame.Enabled := false;
    ShowMessage('Игра повреждена. В папке нет необходимых файлов');
  end;
end;

procedure TfrmMenu.btnNewGameClick(Sender: TObject);
begin
  if Assigned(frmMain) then
    frmMain.Close;
  frmMain := TfrmMain.Create(Self);
  frmMain.newGame := true;
  frmMain.Show;
  Hide;
end;

procedure TfrmMenu.btnExitClick(Sender: TObject);
begin
  Close;
end;

function TfrmMenu.checkFiles: Boolean;
begin
  result := FileExists('grass.bmp') and FileExists('land.bmp') and
            FileExists('apple.bmp') and FileExists('snake.bmp') and
            FileExists('bot.bmp') and FileExists('poison.bmp');
end;

procedure TfrmMenu.btnLoadGameClick(Sender: TObject);
begin
  if Assigned(frmMain) then
    frmMain.Close;
  frmMain := TfrmMain.Create(Self);
  frmMain.newGame := false;
  frmMain.Show;
  Hide;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  btnLoadGame.Enabled := FileExists('temp_game.sav');
end;

procedure TfrmMenu.btnResultClick(Sender: TObject);
begin
  if Assigned(frmResults) then
    frmResults.Close;
  frmResults := TfrmResults.Create(Self);
  frmResults.Show;
  Hide;
end;

end.
