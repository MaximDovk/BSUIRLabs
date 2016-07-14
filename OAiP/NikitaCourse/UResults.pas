unit UResults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, UHistory, ComCtrls;

type
  TfrmResults = class(TForm)
    lvResults: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FHistory: THistoryArray;
    procedure outputHistory;
  public
    { Public declarations }
  end;

var
  frmResults: TfrmResults;

implementation

uses UMenu;

{$R *.dfm}

procedure TfrmResults.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  FHistory := returnHistory;
  outputHistory;
end;

procedure TfrmResults.outputHistory;
var
  i: Integer;
  listItem: TListItem;
begin
  for i := 0 to length(FHistory) - 1 do
  begin
    listItem := lvResults.Items.Add;
    listItem.Caption := IntToStr(FHistory[i].score);
    listItem.SubItems.Add(DateTimeToStr(FHistory[i].date));
    listItem.SubItems.Add(IntToStr(FHistory[i].snakeLength)); 
    listItem.SubItems.Add(IntToStr(FHistory[i].code));
  end;
end;

procedure TfrmResults.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMenu.Show;
end;

end.
