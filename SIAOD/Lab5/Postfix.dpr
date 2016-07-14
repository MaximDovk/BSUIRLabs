program Postfix;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UPostfix in 'UPostfix.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
