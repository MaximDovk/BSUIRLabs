program XO;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  ULogin in 'ULogin.pas' {frmLogin},
  UStat in 'UStat.pas' {frmStat};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tic-Tac-Toe';
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmStat, frmStat);
  Application.Run;
end.
