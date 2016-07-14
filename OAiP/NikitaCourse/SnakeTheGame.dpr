program SnakeTheGame;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  USnakeList in 'USnakeList.pas',
  UTypes in 'UTypes.pas',
  UMenu in 'UMenu.pas' {frmMenu},
  UHistory in 'UHistory.pas',
  UFiles in 'UFiles.pas',
  UResults in 'UResults.pas' {frmResults};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Змейка';
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmResults, frmResults);
  Application.Run;
end.
