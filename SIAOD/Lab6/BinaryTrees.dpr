program BinaryTrees;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UTree in 'UTree.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
