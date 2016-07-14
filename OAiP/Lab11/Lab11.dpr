program Lab11;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UBookList in 'UBookList.pas',
  UVisitorList in 'UVisitorList.pas',
  UBorrowList in 'UBorrowList.pas',
  UFilesIntegration in 'UFilesIntegration.pas',
  UAddBook in 'UAddBook.pas' {frmAddBook},
  UAddVisitor in 'UAddVisitor.pas' {frmAddVisitor},
  UAddBorrow in 'UAddBorrow.pas' {frmAddBorrow},
  USelectCode in 'USelectCode.pas' {frmSelectCode};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Библиотека';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
