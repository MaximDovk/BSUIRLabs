unit UStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons;

type
  TSpisok=^spis;
  Spis=record
    Name:string[20];
    Date:string[10];
    Next:TSpisok;
  end;
  TRec=record
    Name:string[20];
    Date:string[10];
  end;

  TfrmStat = class(TForm)
    StatTable: TStringGrid;
    StatBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    procedure make();
    procedure ClearTable;
    procedure StatBtnClick(Sender: TObject);
  public
    procedure saveWinToFile(name: String);
  end;

var
  frmStat: TfrmStat;

implementation

{$R *.dfm}

{ Вывод статистики из типизированного файла в таблицу }

// Это удалить
var
  UserName: String;

procedure TfrmStat.make;
var
  i,j:integer;
  f:file of TRec;
  res:TRec;
  first:TSpisok;
  stat:TSpisok;
begin
  AssignFile(f,UserName);
  reset(f);
  i:=0;
  first^.Next:=nil;
  while not EOF(f) do
  begin
    Seek(f,i);
    Read(f,res);
    New(stat);
    stat^.Name:=res.Name;
    stat^.Next:=first;
    first:=stat;
    i:=i+1;
  end;
  CloseFile(f);
  i:=1;
  while Stat^.Next<>nil do
  begin
   StatTable.RowCount:=StatTable.RowCount+1;
   StatTable.Cells[0,i]:=Stat^.Name;
   StatTable.Cells[1,i]:=Stat^.Date;
   //StatTable.Cells[2,i]:=
   Stat:=Stat^.Next;
   i:=i+1;
  end;
end;

procedure TfrmStat.FormCreate(Sender: TObject);
begin
 StatTable.Cells[0,0]:= 'Имя';
 StatTable.Cells[1,0]:= 'Дата';
end;

{ Очищение таблицы }
procedure TfrmStat.ClearTable;
var
  i:integer;
begin
 for i:=1 to 20 do
 begin
  StatTable.Cells[0,i+1]:= '';
  StatTable.Cells[1,i+1]:= '';
 end;
end;

{ Вывод статистики }
procedure TfrmStat.StatBtnClick(Sender: TObject);
begin
 if not FileExists(UserName) then
  Showmessage('В эту игру ещё никто не играл.')
 else
 begin
  ClearTable;
  Make();
 end;
end;

//можешь сказать , как тут сделать, чтобы имя игроков присваивалось? ??
//ну вот когда выбираем имена игрокам ,то сохраняем их имена в файл, дальше они играют
//и тот кто победил идёт в рейтинг вот на этой форме
//понимаешь?

procedure TfrmStat.saveWinToFile(name: String);
begin
  //Открыть нужный файл, записать туда имя и дату

end;


// Вот так
//А какие поля ещё можно вставить в рейтинг? КПД*
//окей,спасибо)))) Ещё будешь пис/ат/ь?     На своем буду,спасибо) Не за что, я спатспокоьйн ой ночи, Тебе тоже, удачи =)скинь только это куда -ни
end.
