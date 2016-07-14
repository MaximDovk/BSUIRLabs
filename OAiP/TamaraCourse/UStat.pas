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

{ ����� ���������� �� ��������������� ����� � ������� }

// ��� �������
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
 StatTable.Cells[0,0]:= '���';
 StatTable.Cells[1,0]:= '����';
end;

{ �������� ������� }
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

{ ����� ���������� }
procedure TfrmStat.StatBtnClick(Sender: TObject);
begin
 if not FileExists(UserName) then
  Showmessage('� ��� ���� ��� ����� �� �����.')
 else
 begin
  ClearTable;
  Make();
 end;
end;

//������ ������� , ��� ��� �������, ����� ��� ������� �������������? ??
//�� ��� ����� �������� ����� ������� ,�� ��������� �� ����� � ����, ������ ��� ������
//� ��� ��� ������� ��� � ������� ��� �� ���� �����
//���������?

procedure TfrmStat.saveWinToFile(name: String);
begin
  //������� ������ ����, �������� ���� ��� � ����

end;


// ��� ���
//� ����� ���� ��� ����� �������� � �������? ���*
//����,�������)))) ��� ������ ���/��/�?     �� ����� ����,�������) �� �� ���, � ������������ �� ����, ���� ����, ����� =)����� ������ ��� ���� -��
end.
