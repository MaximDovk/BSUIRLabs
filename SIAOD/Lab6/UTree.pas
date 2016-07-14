unit UTree;

interface

type                   
  TNumbers = array of Integer;
  TTree = ^TTreeNode;
  TTreeNode = record
    data: Integer;
    place: Integer;
    level: Integer;
    left, right: TTree;
  end;
  TTreeNodes = array of TTreeNode;

function createWithNumbers(numbers: TNumbers):Boolean;

function getTreeAsArray:TTreeNodes;

function getSewNodes:TTreeNodes;

function getFullARB:String;

function getFullABR:String;

function getFullRAB:String;

implementation  

uses
  SysUtils;

var
  tree: TTree;

procedure addNode(var tree: TTree; data: Integer; place, level: Integer);
begin
  if tree = nil then
  begin
    new(tree);
    tree^.data := data;
    tree^.place := place;
    tree^.level := level;
    tree^.left := nil;
    tree^.right := nil;
  end
  else
  begin
    if data < tree^.data then
      addNode(tree^.left, data, place * 2 - 1, level + 1)
    else
      addNode(tree^.right, data, place * 2, level + 1);
  end;
end;

procedure destroyTree;
begin
  dispose(tree);
  tree := nil;
end;

function checkNumbers(numbers: TNumbers):Boolean;
var
  i, j: Integer;
begin
  result := true;
  for i := 0 to length(numbers) - 1 do
  begin
    for j := 0 to i - 1 do
    begin
      if numbers[i] = numbers[j] then
        result := false;
    end;
  end;
end;

function createWithNumbers(numbers: TNumbers):Boolean;
var
  i: Integer;
begin
  result := checkNumbers(numbers);
  if result then
  begin
    destroyTree;
    for i := 0 to length(numbers) - 1 do
      addNode(tree, numbers[i], 1, 1);
  end;
end;

procedure outputSmallABRTree(tree: TTree; var res: TTreeNodes);
begin
  if tree^.left <> nil then
    outputSmallABRTree(tree^.left, res);
  if tree^.right <> nil then
    outputSmallABRTree(tree^.right, res);
  if tree <> nil then
  begin
    SetLength(res, length(res) + 1);
    res[length(res) - 1] := tree^;
  end;
end;

function getTreeAsArray:TTreeNodes;
begin
  SetLength(result, 0);
  outputSmallABRTree(tree, result);
end;

procedure outputSewNodes(tree: TTree; var res: TTreeNodes; lastOdd: TTree);
begin
  if tree^.left <> nil then
    outputSewNodes(tree^.left, res, tree);
  if tree^.right <> nil then
    outputSewNodes(tree^.right, res, lastOdd)
  else
  begin
    SetLength(res, length(res) + 2);
    res[length(res) - 2] := tree^;
    if lastOdd <> nil then
      res[length(res) - 1] := lastOdd^
    else
      res[length(res) - 1].level := 0;
  end;
end;

function getSewNodes:TTreeNodes;
begin
  SetLength(result, 0);
  outputSewNodes(tree, result, nil);
end;          

procedure outputFullARBTree(tree: TTree; var res: String);
begin
  res := res + IntToStr(tree^.data) + ' ';
  if tree^.left <> nil then
    outputFullARBTree(tree^.left, res)
  else
    res := res + '0 ';
  if tree <> nil then
    res := res + '(' + IntToStr(tree^.data) + ') ';
  if tree^.right <> nil then
    outputFullARBTree(tree^.right, res)
  else
    res := res + '0 ';
  res := res + IntToStr(tree^.data) + ' ';
end;

function getFullARB:String;
begin
  result := '';
  outputFullARBTree(tree, result);
end;

procedure outputFullABRTree(tree: TTree; var res: String);
begin
  res := res + IntToStr(tree^.data) + ' ';
  if tree^.left <> nil then
    outputFullABRTree(tree^.left, res)
  else
    res := res + '0 ';
  res := res + IntToStr(tree^.data) + ' ';
  if tree^.right <> nil then
    outputFullABRTree(tree^.right, res)
  else
    res := res + '0 ';
  if tree <> nil then
    res := res + '(' + IntToStr(tree^.data) + ') ';
end;

function getFullABR:String;
begin
  result := '';
  outputFullABRTree(tree, result);
end;
         
procedure outputFullRABTree(tree: TTree; var res: String);
begin                 
  if tree <> nil then
    res := res + '(' + IntToStr(tree^.data) + ') ';
  if tree^.left <> nil then
    outputFullRABTree(tree^.left, res)
  else
    res := res + '0 ';
  res := res + IntToStr(tree^.data) + ' ';
  if tree^.right <> nil then
    outputFullRABTree(tree^.right, res)
  else
    res := res + '0 ';  
  res := res + IntToStr(tree^.data) + ' ';
end;

function getFullRAB:String;
begin   
  result := '';
  outputFullRABTree(tree, result);
end;

end.
