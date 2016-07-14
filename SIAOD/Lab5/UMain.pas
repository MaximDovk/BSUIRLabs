unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, UPostfix, StdCtrls;

type
  TfrmMain = class(TForm)
    alMain: TActionList;
    processString: TAction;
    editInput: TEdit;
    btnConvert: TButton;
    editResult: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure processStringExecute(Sender: TObject);
    procedure editInputKeyPress(Sender: TObject; var Key: Char);
  private
    resultString: String;
    function getResult(inStr: String): String;
    procedure redrawResult;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

{ TfrmMain }

function TfrmMain.getResult(inStr: String): String;
var
  rank: Integer;
begin
  rank := calcRank(inStr);
  if rank = 1 then
    result := 'Полученная строка: ' + toPostfix(inStr) + ' её ранг равен 1'
  else
    result := 'Ошибка! Ранг исходной строки: ' + IntToStr(rank);
end;

procedure TfrmMain.redrawResult;
begin
  editResult.Text := resultString;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  resultString := '';
end;

procedure TfrmMain.processStringExecute(Sender: TObject);
begin
  if editInput.Text <> 'Введите строку' then
    resultString := getResult(editInput.Text)
  else
    resultString := 'Ошибка! Введите строку';
  redrawResult;
end;

procedure TfrmMain.editInputKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    processStringExecute(Self);
  end;
end;

end.
