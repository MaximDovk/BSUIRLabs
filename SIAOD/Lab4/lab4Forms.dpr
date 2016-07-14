program lab4Forms;

uses
  Forms,
  FormMainLab4 in 'FormMainLab4.pas' {MainForm},
  FormResults in 'FormResults.pas' {ResultsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
