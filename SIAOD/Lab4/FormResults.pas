unit FormResults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TResultsForm = class(TForm)
    resultGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultsForm: TResultsForm;

implementation

uses FormMainLab4;

{$R *.dfm}

procedure TResultsForm.FormCreate(Sender: TObject);
var
  i, j, k, tTact: Integer;
  str, star: String;
begin
  case resultType of
    0:
      Caption := 'Результаты при времени такта ' + IntToStr(constValue) + ' и времени ввода ' + IntToStr(tempValue);
    else
      Caption := 'Результаты при времени такта ' + IntToStr(tempValue) + ' и времени ввода ' + IntToStr(constValue);
  end;
  Height := 196;
  resultGrid.Cells[0, 0] := 'T';
  resultGrid.Cells[0, 1] := '*';
  resultGrid.Cells[0, 2] := '1';
  resultGrid.Cells[0, 3] := '2';
  resultGrid.Cells[0, 4] := '3';
  resultGrid.Cells[0, 5] := '4';
  resultGrid.Cells[0, 6] := '5';
  resultGrid.Cells[0, 7] := '6';
  resultGrid.Cells[0, 8] := '7';
  resultGrid.Cells[0, 9] := '8';

  case resultType of
    0:
    begin
      tTact := constValue;
    end;
    else
    begin
      tTact := tempValue;
    end;
  end;

  if tTact > 2 then
    resultGrid.DefaultColWidth := 6 * tTact + 4
  else
    resultGrid.DefaultColWidth := 22;
  resultGrid.ColWidths[0] := 10;
  resultGrid.ColCount := length(res[tempValue].res[0]) div tTact + 1;
  if length(res[1].res[0]) mod tTact <> 0 then
    resultGrid.ColCount := resultGrid.ColCount + 1;
  for i := 0 to resultGrid.ColCount - 1 do
  begin
    resultGrid.Cells[i + 1, 0] := IntToStr(i + 1);
    star := '**********';
    star := copy(star, 1, tTact);
    for j := 0 to 7 do
    begin
      str := copy(res[tempValue].res[j], i * tTact + 1, tTact);
      resultGrid.Cells[i + 1, j + 2] := str;
      for k := 1 to length(str) do
        if str[k] = 'X' then
          star[k] := ' ';
    end;
    resultGrid.Cells[i + 1, 1] := star;
  end;

  Show;
end;

end.
