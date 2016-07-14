unit FormMainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMainMenuForm = class(TForm)
    btnNewGame: TButton;
    btnLoadGame: TButton;
    btnResult: TButton;
    btnExit: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewGameClick(Sender: TObject);
    procedure btnLoadGameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    newGame: Boolean;
  end;

var
  MainMenuForm: TMainMenuForm;

implementation

uses TitleForm, ResultsForm, FormGame;

{$R *.dfm}

procedure TMainMenuForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormLoad.Close;
end;

procedure TMainMenuForm.btnExitClick(Sender: TObject);
begin
  MainMenuForm.Close;
end;

procedure TMainMenuForm.btnResultClick(Sender: TObject);
begin
  FormResults.Visible := true;
end;

procedure TMainMenuForm.FormCreate(Sender: TObject);
begin
  if (not Assigned(FormResults)) then
  begin
    FormResults:=TFormResults.Create(Self);
  end;
end;

procedure TMainMenuForm.btnNewGameClick(Sender: TObject);
begin
  MainMenuForm.Visible := false;
  MainMenuForm.newGame := true;
  if (not Assigned(GameForm)) then
  begin
    GameForm:=TGameForm.Create(Self);
    GameForm.Show;
  end;
end;

procedure TMainMenuForm.btnLoadGameClick(Sender: TObject);
begin
  MainMenuForm.Visible := false;
  MainMenuForm.newGame := false;
  if (not Assigned(GameForm)) then
  begin
    GameForm:=TGameForm.Create(Self);
    GameForm.Show;
  end;
end;

end.
