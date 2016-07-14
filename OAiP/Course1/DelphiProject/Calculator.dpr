program Calculator;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UTextForm in 'UTextForm.pas' {frmText},
  UExpression in 'UExpression.pas',
  UStack in 'UStack.pas',
  UHistory in 'UHistory.pas',
  UTypes in 'UTypes.pas',
  UFiles in 'UFiles.pas',
  UCountSystems in 'UCountSystems.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Калькулятор';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
