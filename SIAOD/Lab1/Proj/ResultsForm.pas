unit ResultsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls;

type
  TFormResults = class(TForm)
    ResultList: TStringGrid;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormResults: TFormResults;

implementation

{$R *.dfm}

procedure TFormResults.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  FormResults.Visible := false;
end;



procedure TFormResults.FormCreate(Sender: TObject);
type
  TResults = record
    result: Boolean;
    name: String[20];
    steps: integer;
  end;
var
  resultsFile: file of TResults;
  i: integer;
  res: TResults;
begin
  ResultList.DefaultRowHeight := 20;
  assignFile(resultsFile, 'results.data');
  reset(resultsFile);
  i := 0;
  ResultList.RowCount := 20;
  ResultList.ColWidths[0] := 144;
  ResultList.ColWidths[1] := 120;
  ResultList.ColWidths[2] := 120;
  ResultList.Cells[0, 0] := 'Время';
  ResultList.Cells[1, 0] := 'Персонаж';
  ResultList.Cells[2, 0] := 'Кол-во шагов';
  while not eof(resultsFile) do
  begin
    read(resultsFile, res);
    inc(i);
    if i > 20 then
      ResultList.RowCount := i;
    ResultList.Cells[0, i] := 'Time';
    ResultList.Cells[1, i] := res.name;
    ResultList.Cells[2, i] := IntToStr(res.steps);
  end;
  if i > 20 then
  begin
    ResultList.ColWidths[0] := 144;
    ResultList.ColWidths[1] := 120;
    ResultList.ColWidths[2] := 97;
  end;
  closeFile(resultsFile);


end;

end.
