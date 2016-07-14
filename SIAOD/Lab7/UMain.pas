unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, ComCtrls, StdCtrls;

type
  TNode = record
    x, y: Integer;
    number: Integer;
  end;
  TPrices = array [1..10, 1..10] of Integer;
  TPath = record
    str: String;
    val: Integer;
  end;
  TPathes = array of TPath;
  TfrmMain = class(TForm)
    pnlControls: TPanel;
    strgMatrix: TStringGrid;
    editNumOfNodes: TEdit;
    udNumOfNodes: TUpDown;
    editFrom: TEdit;
    editTo: TEdit;
    udTo: TUpDown;
    udFrom: TUpDown;
    labelFrom: TLabel;
    labelTo: TLabel;
    btnShowGraph: TButton;
    memoPathes: TMemo;
    imgGraph: TImage;
    procedure editFromKeyPress(Sender: TObject; var Key: Char);
    procedure editToKeyPress(Sender: TObject; var Key: Char);
    procedure editNumOfNodesKeyPress(Sender: TObject; var Key: Char);
    procedure editNumOfNodesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnShowGraphClick(Sender: TObject);
    procedure strgMatrixKeyPress(Sender: TObject; var Key: Char);
  private
    PNumberOfNodes: Integer;
    nodes: array of TNode;
    matrix: TPrices;
    procedure SetNumberOfNodes(const Value: Integer);
    property numberOfNodes: Integer read PNumberOfNodes write SetNumberOfNodes;
    procedure setColRowNames;
    procedure setNodes(rad: Integer);
    procedure fillMatrix;
    procedure randomFillGrid;
    procedure clearImage;
    procedure drawNodeWithText(x, y, rad: Integer; note: String);
    procedure drawNodes(rad: Integer);
    procedure drawLines(rad: Integer);
    procedure drawLine(nodeA, nodeB: TNode; rad, noteA, noteB: Integer);
    procedure drawCenter(node: TNode; rad: Integer);
    function findCenter(matrix: TPrices; num: Integer):Integer;
    function floid(matrix: TPrices; num: Integer):TPrices;
    procedure findPathes(a, b: Integer; var pathes: TPathes; str: String; val: Integer);
    procedure outputPathes(pathes: TPathes);
    procedure sortPathes(var pathes: TPathes);
    function getSpaces(n: Integer):String;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses Math;

{$R *.dfm}

procedure TfrmMain.setColRowNames;
var
  i: Integer;
begin
  for i := 1 to numberOfNodes do
  begin
    strgMatrix.Cells[i, 0] := IntToStr(i);
    strgMatrix.Cells[0, i] := IntToStr(i);
  end;
end;

procedure TfrmMain.SetNumberOfNodes(const Value: Integer);
begin
  PNumberOfNodes := Value;
  if udTo.Position > Value then
    udTo.Position := Value;
  if udFrom.Position > Value then
    udFrom.Position := Value;
  udTo.Max := Value;
  udFrom.Max := Value;
  strgMatrix.ColCount := Value + 1;
  strgMatrix.RowCount := Value + 1;
  strgMatrix.DefaultColWidth := trunc((strgMatrix.Width - Value * 1.5) / (Value + 1));
  strgMatrix.DefaultRowHeight := trunc((strgMatrix.Height - Value * 1.5) / (Value + 1));
  setColRowNames;
end;

procedure TfrmMain.editFromKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0;
  if (editFrom.Text = '1') and (key <> '0') and (key <> #8) then
    key := #0;
end;

procedure TfrmMain.editToKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0;
  if (editTo.Text = '1') and (key <> '0') and (key <> #8) then
    key := #0;
end;

procedure TfrmMain.editNumOfNodesKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9', #8]) then
    key := #0; 
  if (editNumOfNodes.Text = '1') and (key <> '0') and (key <> #8) then
    key := #0;
end;

procedure TfrmMain.editNumOfNodesChange(Sender: TObject);
begin
  if editNumOfNodes.Text = '' then
    numberOfNodes := 1
  else
    numberOfNodes := StrToInt(editNumOfNodes.Text);
end;            

procedure TfrmMain.clearImage;
begin
  with imgGraph.Canvas do
  begin
    Brush.Color := clWhite;
    FillRect(Rect(0, 0, imgGraph.Width, imgGraph.Height));
  end;
end;

procedure TfrmMain.drawNodeWithText(x, y, rad: Integer; note: String);
begin
  with imgGraph.Canvas do
  begin
    Pen.Color := clBlue;
    Brush.Color := clBlue;
    Ellipse(x - rad, y - rad, x + rad, y + rad);
    Font.Color := clWhite;
    TextOut(x - TextWidth(note) div 2, y - TextHeight(note) div 2, note);
  end;
end;    

procedure TfrmMain.randomFillGrid;
var
  i, j: Integer;
begin
  Randomize;
  for i := 1 to 10 do
  begin
    for j := 1 to 10 do
    begin
      if i = j then
        strgMatrix.Cells[j, i] := ''
      else
        if random(2) = 1 then
          strgMatrix.Cells[j, i] := IntToStr(random(100))
        else       
          strgMatrix.Cells[j, i] := '0';
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  clearImage;
  numberOfNodes := 5;
  randomFillGrid;
end;   

procedure TfrmMain.setNodes(rad: Integer);
var
  i: Integer;
  phi, alpha: Real;
begin
  SetLength(nodes, numberOfNodes);
  phi := 2 * Pi / numberOfNodes;
  alpha := phi;
  for i := 0 to numberOfNodes - 1 do
  begin                   
    nodes[i].number := i + 1;
    nodes[i].x := round(rad * cos(alpha) + imgGraph.Width / 2);
    nodes[i].y := round(rad * sin(alpha) + imgGraph.Height / 2);
    alpha := alpha + phi;
  end;
end;

procedure TfrmMain.drawNodes(rad: Integer);
var
  i: Integer;
begin
  for i := 0 to numberOfNodes - 1 do
    drawNodeWithText(nodes[i].x, nodes[i].y, rad, IntToStr(nodes[i].number));
end;     

procedure TfrmMain.fillMatrix;
var
  i, j: Integer;
begin
  for i := 1 to numberOfNodes do
  begin
    for j := 1 to numberOfNodes do
    begin
      if strgMatrix.Cells[j, i] = '' then
        matrix[i, j] := 0
      else
        matrix[i, j] := StrToInt(strgMatrix.Cells[j, i]);
    end;
  end;
end;      

procedure TfrmMain.drawLine(nodeA, nodeB: TNode; rad, noteA, noteB: Integer);
var
  dx, dy, sinPhi, cosPhi, radDx, radDy: Real;
begin
  dy := abs(nodeA.y - nodeB.y);
  dx := abs(nodeA.x - nodeB.x);
  if (dy <> 0) or (dx <> 0) then
  begin
    sinPhi := dy / sqrt(sqr(dx) + sqr(dy));
    cosPhi := dx / sqrt(sqr(dx) + sqr(dy));
    radDx := cosPhi;
    radDy := sinPhi;
    if nodeA.x < nodeB.x then
      radDx := -radDx;
    if nodeA.y < nodeB.y then
      radDy := -radDy;
    radDy := rad * radDy;
    radDx := rad * radDx;

    nodeA.x := round(nodeA.x - radDx);
    nodeA.y := round(nodeA.y - radDy);
    nodeB.x := round(nodeB.x + radDx);
    nodeB.y := round(nodeB.y + radDy);

    with imgGraph.Canvas do
    begin
      Pen.Color := clBlack;
      MoveTo(nodeA.x, nodeA.y);
      LineTo(nodeB.x, nodeB.y);
      if noteA <> 0 then
      begin                
        Pen.Color := clRed;
        Brush.Color := clRed;
        Ellipse(nodeB.x - 5, nodeB.y - 5, nodeB.x + 5, nodeB.y + 5);
        Pen.Color := clBlack;
        Brush.Color := clWhite;
        Font.Color := clBlack;
        Font.Name := 'Tahoma';
        Font.Size := 7;
        Ellipse(round(nodeB.x + radDx - 10),
                round(nodeB.y + radDy - 5),
                round(nodeB.x + radDx + 10),
                round(nodeB.y + radDy + 5));
        TextOut(round(nodeB.x + radDx - TextWidth(IntToStr(noteA)) / 2),
                round(nodeB.y + radDy - TextHeight(IntToStr(noteA)) / 2),
                IntToStr(noteA));
      end;
      if noteB <> 0 then
      begin                
        Pen.Color := clRed;
        Brush.Color := clRed;
        Ellipse(nodeA.x - 5, nodeA.y - 5, nodeA.x + 5, nodeA.y + 5);
        Pen.Color := clBlack;
        Brush.Color := clWhite;
        Font.Color := clBlack;
        Font.Name := 'Tahoma';
        Font.Size := 7;
        Ellipse(round(nodeA.x - radDx - 10),
                round(nodeA.y - radDy - 5),
                round(nodeA.x - radDx + 10),
                round(nodeA.y - radDy + 5));
        TextOut(round(nodeA.x - radDx - TextWidth(IntToStr(noteB)) / 2),
                round(nodeA.y - radDy - TextHeight(IntToStr(noteB)) / 2),
                IntToStr(noteB));
      end;
    end;
  end
end;

procedure TfrmMain.drawLines(rad: Integer);
var
  i, j: Integer;
begin
  for i := 1 to numberOfNodes do
  begin
    for j := 1 to i - 1 do
      if (matrix[i, j] <> 0) or (matrix[j, i] <> 0) then
        drawLine(nodes[i - 1], nodes[j - 1], rad, matrix[i, j], matrix[j, i]);
  end;
end;    

procedure TfrmMain.drawCenter(node: TNode; rad: Integer);
begin
  with imgGraph.Canvas do
  begin
    Brush.Color := clWhite;
    Pen.Color := clRed;
    Ellipse(node.x - rad, node.y - rad, node.x + rad, node.y + rad);
  end;
end;

function TfrmMain.floid(matrix: TPrices; num: Integer):TPrices;
var
  prices: TPrices;
  k, i, j: Integer;
begin
  result := matrix;
  for i := 1 to num do
    for j := 1 to num do
    begin
      if i = j then
        result[i, j] := 0;
      if (result[i, j] = 0) and (i <> j) then
        result[i, j] := MaxInt div 3;
    end;
  for k := 1 to num do
  begin
    prices := result;
    for i := 1 to num do
      for j := 1 to num do
        if prices[i, k] + prices[k, j] < result[i, j] then
          result[i, j] := prices[i, k] + prices[k, j];
  end;
end;

function TfrmMain.findCenter(matrix: TPrices; num: Integer):Integer;
var
  prices: TPrices;
  k, i, j: Integer;
begin
  prices := floid(matrix, num);
  for j := 1 to num do
    for i := 2 to num do
      if prices[i, j] > prices[1, j] then
        prices[1, j] := prices[i, j];
  k := prices[1, 1];
  result := 1;
  for j := 2 to num do
    if prices[1, j] < k then
    begin
      k := prices[1, j];
      result := j;
    end;
end;

procedure TfrmMain.findPathes(a, b: Integer; var pathes: TPathes; str: String; val: Integer);
var
  j: Integer;
  visit: Boolean;
begin
  if a = b then
  begin
    SetLength(pathes, length(pathes) + 1);
    pathes[length(pathes) - 1].str := str;
    pathes[length(pathes) - 1].val := val;
  end
  else
  begin
    for j := 1 to numberOfNodes do
    begin
      matrix[j, j] := 0;
      if matrix[a, j] <> 0 then
      begin
        visit := pos(IntToStr(j), str) = 0;
        if visit then
          findPathes(j, b, pathes, str + IntToStr(j) + ' ', val + matrix[a, j]);
      end;
    end;
  end;
end;   

function TfrmMain.getSpaces(n: Integer): String;
var
  i: Integer;
begin
  result := '';
  for i := 1 to n do
    result := result + ' ';
end;

procedure TfrmMain.sortPathes(var pathes: TPathes);
var
  i, j, temp: Integer;
  tempStr: String;
begin
  for i := 1 to length(pathes) - 1 do
  begin
    for j := length(pathes) - 1 downto i do
    begin
      if pathes[j - 1].val > pathes[j].val then
      begin
        temp := pathes[j - 1].val;
        pathes[j - 1].val := pathes[j].val;
        pathes[j].val := temp;
        tempStr := pathes[j - 1].str;
        pathes[j - 1].str := pathes[j].str;
        pathes[j].str := tempStr;
      end;
    end;
  end;
end;

procedure TfrmMain.outputPathes(pathes: TPathes);
var
  i, max: Integer;
begin
  memoPathes.Font.Name := 'Courier New';
  memoPathes.Lines.Clear;
  sortPathes(pathes);
  max := 0;
  for i := 0 to length(pathes) - 1 do
    if length(pathes[i].str) > max then
      max := length(pathes[i].str);
  for i := 0 to length(pathes) - 1 do
    memoPathes.Lines.Add(pathes[i].str + getSpaces(max - length(pathes[i].str) + 5) + IntToStr(pathes[i].val));
end;

procedure TfrmMain.btnShowGraphClick(Sender: TObject);
var
  pathes: TPathes;
  a, b: Integer;
begin
  fillMatrix;
  clearImage;
  setNodes(200);
  drawCenter(nodes[findCenter(matrix, numberOfNodes) - 1], 30);
  drawNodes(20);
  drawLines(20);
  if editFrom.Text = '' then
    editFrom.Text := '1';
  if editTo.Text = '' then
    editTo.Text := IntToStr(numberOfNodes);
  a := StrToInt(editFrom.Text);
  b := StrToInt(editTo.Text);
  findPathes(a, b, pathes, editFrom.Text + ' ', 0);
  outputPathes(pathes);
end;

procedure TfrmMain.strgMatrixKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    key := #0;
end;

end.
