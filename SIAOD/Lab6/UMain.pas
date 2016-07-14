unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, ExtCtrls, UTree;

type
  TfrmMain = class(TForm)
    pnlControls: TPanel;
    strgNodesData: TStringGrid;
    editNumberOfNodes: TEdit;
    udNumberOfNodes: TUpDown;
    btnDrawTree: TButton;
    imgTree: TImage;
    labelABR: TLabel;
    labelABRResult: TLabel;
    labelARB: TLabel;
    labelARBResult: TLabel;
    labelRAB: TLabel;
    labelRABResult: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure editNumberOfNodesKeyPress(Sender: TObject; var Key: Char);
    procedure editNumberOfNodesChange(Sender: TObject);
    procedure strgNodesDataKeyPress(Sender: TObject; var Key: Char);
    procedure btnDrawTreeClick(Sender: TObject);
  private
    PNumberOfNodes: Integer;
    PRandomArray: array [1..99] of Integer;
    procedure fillRandomArray;
    procedure SetNumberOfNodes(const num: Integer);
    property numberOfNodes: Integer read PNumberOfNodes write SetNumberOfNodes;
    function convertToNumbers:TNumbers;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Math;

{$R *.dfm}

{ TfrmMain }

procedure TfrmMain.fillRandomArray;
var
  i, temp, a, b: Integer;
begin
  Randomize;
  for i := 1 to 99 do
    PRandomArray[i] := i;
  for i := 1 to 1000 do
  begin
    a := Random(99) + 1;
    b := Random(99) + 1;
    temp := PRandomArray[a];
    PRandomArray[a] := PRandomArray[b];
    PRandomArray[b] := temp;
  end;
  {PRandomArray[1] := 10;
  PRandomArray[2] := 7;
  PRandomArray[3] := 4;
  PRandomArray[4] := 5;
  PRandomArray[5] := 20;
  PRandomArray[6] := 15;
  PRandomArray[7] := 12;
  PRandomArray[8] := 16;
  PRandomArray[9] := 25;}
end;

procedure TfrmMain.SetNumberOfNodes(const num: Integer);
var
  i: Integer;
begin
  PNumberOfNodes := num;
  strgNodesData.RowCount := numberOfNodes;
  for i := 0 to numberOfNodes - 1 do
    if strgNodesData.Cells[0, i] = '' then
      strgNodesData.Cells[0, i] := IntToStr(PRandomArray[i + 1]);
end;

procedure TfrmMain.editNumberOfNodesKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    key := #0;
  if (editNumberOfNodes.Text = '') and (key = '0') then
    key := #0;
end;            

procedure TfrmMain.editNumberOfNodesChange(Sender: TObject);
begin
  if editNumberOfNodes.Text = '' then
    numberOfNodes := 1
  else
    numberOfNodes := StrToInt(editNumberOfNodes.Text);
end;      

procedure TfrmMain.strgNodesDataKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    key := #0;
end;

procedure clearImage;
begin   
  with frmMain.imgTree.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(Rect(0, 0, frmMain.imgTree.Width, frmMain.imgTree.Height));
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin               
  fillRandomArray;
  numberOfNodes := 10;
  clearImage;
end;

function TfrmMain.convertToNumbers: TNumbers;
var
  i: Integer;
begin
  SetLength(result, numberOfNodes);
  for i := 0 to numberOfNodes - 1 do
  begin
    if strgNodesData.Cells[0, i] = '' then
      strgNodesData.Cells[0, i] := IntToStr(PRandomArray[i + 1])
    else
      result[i] := StrToInt(strgNodesData.Cells[0, i]);
  end;
end;

function getXByPlace(place, level, rad: Integer):Integer;
begin
  result := round((frmMain.imgTree.Width - 2* rad) / power(2, level - 1));
  result := round(result * place - result / 2) + rad;
end;

function getYByLevel(level, rad: Integer):Integer;
begin
  result := 4 * level * rad + 2 * rad;
end;

procedure drawCircleWithText(rad, x, y: Integer; note: String);
begin
  with frmMain.imgTree.Canvas do
  begin
    Pen.Color := clBlue;
    Brush.Color := clBlue;
    Ellipse(x - rad, y - rad, x + rad, y + rad);
    Font.Color := clWhite;
    TextOut(x - TextWidth(note) div 2, y - TextHeight(note) div 2, note);
  end;
end;

procedure drawNode(node: TTreeNode; rad: Integer);
var
  x, y: Integer;
begin
  x := getXByPlace(node.place, node.level, rad);
  y := getYByLevel(node.level, rad);
  drawCircleWithText(rad, x, y, IntToStr(node.data));
end;

procedure drawLine(place, level, rad: Integer);
var
  x, y: Integer;
begin
  with frmMain.imgTree.Canvas do
  begin
    Pen.Color := clBlack;
    x := getXByPlace(place, level, rad);
    y := getYByLevel(level, rad);
    MoveTo(x, y);
    if odd(place) then
      inc(place);
    place := place div 2;
    dec(level);
    x := getXByPlace(place, level, rad);
    y := getYByLevel(level, rad);
    LineTo(x, y);
  end;
end;

procedure drawSewLine(nodeA, nodeB: TTreeNode; rad: Integer);
var
  x, y: Integer;
begin
  with frmMain.imgTree.Canvas do
  begin
    Pen.Color := clRed;
    x := getXByPlace(nodeA.place, nodeA.level, rad);
    y := getYByLevel(nodeA.level, rad);
    MoveTo(x, y);
    x := getXByPlace(nodeB.place, nodeB.level, rad);
    LineTo(x, y);                           
    y := getYByLevel(nodeB.level, rad);
    LineTo(x, y);
  end;
end;

procedure TfrmMain.btnDrawTreeClick(Sender: TObject);
var
  treeNodes, sewNodes: TTreeNodes;
  i: Integer;
begin
  SetLength(treeNodes, 0);
  SetLength(sewNodes, 0);
  if createWithNumbers(convertToNumbers) then
  begin
    clearImage;
    treeNodes := getTreeAsArray;
    for i := 0 to length(treeNodes) - 1 do
    begin
      if treeNodes[i].level <> 1 then
        drawLine(treeNodes[i].place, treeNodes[i].level, 15);
    end;
    sewNodes := getSewNodes;
    i := 0;
    while i < length(sewNodes) do
    begin
      if sewNodes[i + 1].level <> 0 then
        drawSewLine(sewNodes[i], sewNodes[i + 1], 15);
      inc(i, 2);
    end;
    for i := 0 to length(treeNodes) - 1 do
      drawNode(treeNodes[i], 15);
    labelABRResult.Caption := getFullABR;
    labelARBResult.Caption := getFullARB;
    labelRABResult.Caption := getFullRAB;
  end
  else
    ShowMessage('Элементы не должны повторяться');
end;

end.
