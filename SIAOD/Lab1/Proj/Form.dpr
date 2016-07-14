program Form;

uses
  Forms,
  TitleForm in 'TitleForm.pas' {FormLoad},
  FormMainMenu in 'FormMainMenu.pas' {MainMenuForm},
  ResultsForm in 'ResultsForm.pas' {FormResults},
  FormGame in 'FormGame.pas' {GameForm},
  FormWin in 'FormWin.pas' {WinForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Infinity';
  Application.CreateForm(TFormLoad, FormLoad);
  Application.Run;
end.
