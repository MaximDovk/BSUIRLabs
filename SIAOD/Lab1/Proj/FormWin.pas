unit FormWin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TWinForm = class(TForm)
    CongratText: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WinForm: TWinForm;

implementation

uses FormGame;

{$R *.dfm}

procedure TWinForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GameForm.Close;
end;

end.
