unit FormGame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids;

type
  TGameForm = class(TForm)
    timeTimer: TTimer;
    bevelText: TBevel;
    bevelClock: TBevel;
    timeTitle: TLabel;
    timeLable: TLabel;
    field: TDrawGrid;
    map: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure timeTimerTimer(Sender: TObject);
    procedure fieldDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure fieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameForm: TGameForm;

implementation

uses FormMainMenu, FormWin;

{$R *.dfm}

type
  TMap = array [1..100, 1..100] of byte;
  TPoint = record
    x, y: byte;
  end;
  TCol = (RED, YEL, BLU, BLK, WHI, GRE, ORG, PUR);
  TFloor = record
    map: TMap;
    color: TCol;
    level: Integer;
    direction: byte;
  end;
  TList = ^TElem;
  TElem = record
    floor: TFloor;
    next: TList;
    prev: TList;
  end;
  TPos = record
    point: TPoint;
    color: TCol;
  end;
  TSave = record
    name: String[20];
    seed: int64;
    time: Integer;
    steps: Integer;
    list: TList;  {SAVE AS ARRAY}
    position : TPos;
    intro: Integer;
  end;

var
  list, currentFloor: TList;
  name: String[20];
  seed: int64;
  pos: TPos;
  time: Integer;
  intro: Integer;
  steps: Integer;
  size: TPoint;
  spinList: array [1..12] of record part: integer; dir: boolean; end;

{ Color to str }
function colorToStr(color: TCol):String;
begin
  case color of
    RED:
      result := 'Red';
    YEL:
      result := 'Yellow';
    BLU:
      result := 'Blue';
    BLK:
      result := 'Black';
    WHI:
      result := 'White';
    GRE:
      result := 'Green';
    ORG:
      result := 'Orange';
    PUR:
      result := 'Purple';
  end;
end;

{ Generate seed }
function generateSeed():int64;
var
  i: integer;
begin
  randomize;
  result := 0;
  for i := 1 to 8 do
    result := 256 * result + random(256);
end;
           
{ Insert floor into list }
procedure listInsert(list: TList; floor: TFloor);
var
  temp: TList;
begin
  new(temp);
  temp^.next := list^.next;
  temp^.floor := floor;
  temp^.prev := list;
  if list^.next <> nil then
    list^.next^.prev := temp;
  list^.next := temp;
end;

procedure setSize(var size: TPoint; const x, y: Integer);
begin
  size.x := x;
  size.y := y;
end;

procedure fillMap(var map: TMap; const size: TPoint; const sym: integer);
var
  i, j: Integer;
begin
  for i := 1 to size.y do
  begin
    for j := 1 to size.x do
    begin
      map[i, j] := sym;
    end;
  end;
end;

procedure setRoom(var map: TMap; const roomSizeX, roomSizeY: integer; const y, x, sym: integer);
var
  i, j: integer;
begin
  for i := y to y + roomSizeY - 1 do
  begin
    for j := x to x + roomSizeX - 1 do
    begin
      map[i, j] := sym;
    end;
  end;
end;

procedure setCornerRooms(var map: TMap; const size: TPoint; const sym: integer; const roomSizeX, roomSizeY: integer);
begin
  setRoom(map, roomSizeX, roomSizeY, 2, 2, sym);
  setRoom(map, roomSizeX, roomSizeY, 2, size.x - roomSizeX, sym);
  setRoom(map, roomSizeX, roomSizeY, size.y - roomSizeY, 2, sym);
  setRoom(map, roomSizeX, roomSizeY, size.y - roomSizeY, size.x - roomSizeX, sym);
end;

procedure setSideRooms(var map: TMap; const size: TPoint; const sym: integer; const roomSizeX, roomSizeY: integer);
begin
  setRoom(map, roomSizeX, roomSizeY - 1, 2, (size.x - roomSizeX) div 2 + 1, sym);
  setRoom(map, roomSizeX, roomSizeY - 1, size.y - roomSizeY + 1, (size.x - roomSizeX) div 2 + 1, sym);
  setRoom(map, roomSizeX - 1, roomSizeY, (size.y - roomSizeY) div 2 + 1, 2, sym);
  setRoom(map, roomSizeX - 1, roomSizeY, (size.y - roomSizeY) div 2 + 1, size.x - roomSizeX + 1, sym);
end;

procedure setCenterRooms(var map: TMap; const size: TPoint; const sym: integer; const roomSizeX, roomSizeY: integer);
var
  shiftX, shiftY: Integer;
begin
  shiftX := size.x div 4 - roomSizeX div 2 + 1;
  shiftY := size.Y div 4 - roomSizeY div 2 + 1;
  setRoom(map, roomSizeX, roomSizeY, shiftY, shiftX, sym);
  setRoom(map, roomSizeX, roomSizeY, shiftY, shiftX + size.x div 2 + 1, sym);
  setRoom(map, roomSizeX, roomSizeY, shiftY + size.y div 2 + 1, shiftX, sym);
  setRoom(map, roomSizeX, roomSizeY, shiftY + size.y div 2 + 1, shiftX + size.x div 2 + 1, sym);
end;

procedure setRandomCoridors(var map: TMap; const color: TCol);
begin
  { TODO : Create RANDOM }
  case color of
    RED:
    begin
      setRoom(map, 41, 2, 3, 7, 0);
      setRoom(map, 41, 2, 97, 7, 0);
      setRoom(map, 41, 2, 97, 54, 0);
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 88, 7, 50, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 2, 17, 80, 76, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 2, 18, 5, 25, 0);
      setRoom(map, 20, 2, 50, 7, 0);
      setRoom(map, 17, 2, 25, 80, 0);
    end;
    YEL:
    begin
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 2, 18, 7, 3, 0);
      setRoom(map, 2, 41, 54, 3, 0);
      setRoom(map, 2, 17, 78, 50, 0);
      setRoom(map, 20, 2, 76, 3, 0);
      setRoom(map, 45, 2, 76, 29, 0);
      setRoom(map, 17, 2, 25, 80, 0);
      setRoom(map, 45, 2, 25, 29, 0);
      setRoom(map, 20, 2, 25, 3, 0);
      setRoom(map, 41, 2, 97, 54, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 20, 2, 50, 7, 0);

    end;
    BLU:
    begin
      setRoom(map, 2, 41, 7, 3, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 2, 18, 80, 25, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 2, 18, 5, 76, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 41, 2, 97, 7, 0);
      setRoom(map, 45, 2, 76, 29, 0);
      setRoom(map, 45, 2, 25, 29, 0);
      setRoom(map, 18, 2, 76, 80, 0);
      setRoom(map, 18, 2, 25, 5, 0);
    end;
    BLK:
    begin
      setRoom(map, 41, 2, 3, 7, 0);
      setRoom(map, 2, 41, 7, 3, 0);
      setRoom(map, 2, 41, 54, 3, 0);
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 2, 18, 7, 50, 0);
      setRoom(map, 2, 18, 80, 25, 0);
      setRoom(map, 41, 2, 97, 54, 0);
      setRoom(map, 41, 2, 97, 7, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 23, 2, 25, 29, 0);
      setRoom(map, 19, 2, 25, 80, 0);
    end;
    WHI:
    begin
      setRoom(map, 20, 2, 3, 7, 0);
      setRoom(map, 2, 18, 5, 25, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 45, 2, 25, 29, 0);
      setRoom(map, 2, 18, 5, 76, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 20, 2, 50, 7, 0);
      setRoom(map, 2, 22, 52, 25, 0);
      setRoom(map, 2, 41, 54, 3, 0);
      setRoom(map, 2, 19, 80, 25, 0);
      setRoom(map, 21, 2, 97, 27, 0);
      setRoom(map, 45, 2, 76, 29, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 20, 2, 50, 76, 0);
    end;
    GRE:
    begin
      setRoom(map, 41, 2, 3, 7, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 41, 2, 97, 7, 0);
      setRoom(map, 41, 2, 97, 54, 0);
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 50, 2, 50, 27, 0);
      setRoom(map, 20, 2, 50, 76, 0);
      setRoom(map, 20, 2, 25, 5, 0);
      setRoom(map, 20, 2, 76, 5, 0);
      setRoom(map, 2, 23, 25, 3, 0);
      setRoom(map, 2, 24, 54, 3, 0);
    end;
    ORG:
    begin
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 45, 2, 25, 29, 0);
      setRoom(map, 45, 2, 76, 29, 0);
      setRoom(map, 2, 20, 7, 50, 0);
      setRoom(map, 2, 20, 76, 50, 0);
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 20, 2, 3, 7, 0);
      setRoom(map, 2, 20, 5, 25, 0);
      setRoom(map, 20, 2, 50, 7, 0);
      setRoom(map, 20, 2, 76, 5, 0);
      setRoom(map, 2, 20, 76, 3, 0);
    end;
    PUR:
    begin
      setRoom(map, 41, 2, 97, 7, 0);
      setRoom(map, 41, 2, 97, 54, 0);
      setRoom(map, 41, 2, 3, 54, 0);
      setRoom(map, 2, 41, 7, 3, 0);
      setRoom(map, 2, 41, 7, 97, 0);
      setRoom(map, 2, 41, 54, 97, 0);
      setRoom(map, 2, 45, 29, 76, 0);
      setRoom(map, 2, 45, 29, 25, 0);
      setRoom(map, 20, 2, 50, 7, 0);
      setRoom(map, 2, 20, 7, 50, 0);
      setRoom(map, 21, 2, 25, 29, 0);
      setRoom(map, 2, 20, 5, 76, 0);
      setRoom(map, 2, 20, 76, 50, 0);
      setRoom(map, 21, 2, 76, 29, 0);
    end;
  end;
end;

{ Generate single floor }
function generateFloor(var seed: int64; color: TCol):TFloor;
begin
  randomize;
  result.direction := random(4);
  result.level := ord(color) + 1;
  result.color := color;
  setSize(size, 100, 100);
  fillMap(result.map, size, 1);
  setCornerRooms(result.map, size, 0, 5, 5);
  setSideRooms(result.map, size, 0, 6, 6);
  setCenterRooms(result.map, size, 0, 6, 6);
  setRandomCoridors(result.map, color);
end;

{ Generate list of floors }
procedure generateFloors(list: TList; seed: Int64);
begin
  listInsert(list, generateFloor(seed, PUR));
  listInsert(list, generateFloor(seed, ORG));
  listInsert(list, generateFloor(seed, GRE));
  listInsert(list, generateFloor(seed, WHI));
  listInsert(list, generateFloor(seed, BLK));
  listInsert(list, generateFloor(seed, BLU));
  listInsert(list, generateFloor(seed, YEL));
  listInsert(list, generateFloor(seed, RED));
end;

{ Get list from positition }
function listAfter(const list: TList; pos: Integer):TList;
begin
  result := list;
  while pos > 1 do begin
    result := result^.next;
    dec(pos);
  end;
end;

{ Output colors of floors }
procedure outputList(list: TList);
var
  str: String;
begin
  str := '';
  while list^.next <> nil do
  begin
    list := list^.next;
    str := str + ' ' + colorToStr(list^.floor.color);
  end;
  showMessage(str);
end;

{ Swap 2 cells in list }
procedure swapList(list: TList; pos1, pos2: Integer);
var
  temp, temp2, t1, t2: TList;
begin
  t1 := listAfter(list, pos1);
  t2 := listAfter(list, pos2);
  if pos2 < pos1 then
  begin
    temp := t1;
    t1 := t2;
    t2 := temp;
  end;
  if abs(pos1 - pos2) <> 1 then
  begin
    temp := t1^.next;
    t1^.next := t2^.next;
    temp2 := t1^.next^.next;
    t1^.next^.next := temp^.next;
    t2^.next := temp;
    temp^.next := temp2;

    t1^.next^.prev := t1;
    t2^.next^.prev := t2;
    if temp2 <> nil then
      temp2^.prev := t2^.next;
    t1^.next^.next^.prev := t1^.next;
  end
  else
  begin
    t1^.next := t2^.next;
    t2^.next := t2^.next^.next;
    t1^.next^.next := t2;
    if t2^.next <> nil then
      t2^.next^.prev := t2;
    t1^.next^.prev := t1;
    t2^.prev := t1^.next;
  end;
end;

procedure checkLevels(list: TList);
var
  k: integer;
  str: string;
begin
  k := 1;
  str := '';
  list := list^.next;
  while list <> nil do
  begin
    list^.floor.level := k;
    inc(k);            
    str := str + intToStr(ord(list^.floor.color)+1) + ' ';
    list := list^.next;
  end;
  GameForm.map.Caption := str;
end;

{ Spin floors like Rubik`s Cube }
procedure spinFloors(list: TList; spin: byte; direction: Boolean);
begin
  case spin of
    1:
      if direction then
      begin
        swapList(list, 1, 2);
        swapList(list, 2, 6);
        swapList(list, 5, 6);
      end
      else
      begin
        swapList(list, 1, 2);
        swapList(list, 1, 5);
        swapList(list, 5, 6);
      end;
    2:
      if direction then
      begin
        swapList(list, 3, 4);
        swapList(list, 7, 8);
        swapList(list, 3, 8);
      end
      else
      begin
        swapList(list, 3, 4);
        swapList(list, 7, 8);
        swapList(list, 4, 7);
      end;
    3:
      if direction then
      begin
        swapList(list, 5, 6);
        swapList(list, 6, 7);
        swapList(list, 7, 8);
      end
      else
      begin
        swapList(list, 7, 8);
        swapList(list, 6, 7);
        swapList(list, 5, 6);
      end;
    4:
      if direction then
      begin
        swapList(list, 1, 2);
        swapList(list, 2, 3);
        swapList(list, 3, 4);
      end
      else
      begin
        swapList(list, 3, 4);
        swapList(list, 2, 3);
        swapList(list, 1, 2);
      end;
    5:
      if direction then
      begin
        swapList(list, 1, 4);
        swapList(list, 5, 8);
        swapList(list, 1, 8);
      end
      else
      begin
        swapList(list, 1, 4);
        swapList(list, 5, 8);
        swapList(list, 4, 5);
      end;
    6:
      if direction then
      begin
        swapList(list, 2, 3);
        swapList(list, 6, 7);
        swapList(list, 2, 7);
      end
      else
      begin
        swapList(list, 2, 3);
        swapList(list, 6, 7);
        swapList(list, 3, 6);
      end;
  end;
  checkLevels(list);
end;

procedure setPosition(var position: TPos; currentFloor: TList);
begin
  position.color := TCol(seed mod 8);
  randomize;
  case random(4) of
    0:
    begin
      position.point.x := 26;
      position.point.y := 26;
    end;
    1:
    begin
      position.point.x := 26;
      position.point.y := 76;
    end;
    2:
    begin           
      position.point.x := 76;
      position.point.y := 26;
    end;
    3:
    begin
      position.point.x := 76;
      position.point.y := 76;
    end;
  end;
  currentFloor^.floor.map[position.point.y, position.point.x] := 2;
end;

procedure TGameForm.FormCreate(Sender: TObject);
var
  n: integer;
begin       
  randomize;
  if MainMenuForm.newGame then
  begin
    map.Hide;
    time := 0;
    seed := generateSeed();
    new(list);
    list^.next := nil;
    generateFloors(list, seed);
    n := random(8)+1;
    currentFloor := list;
    while n > 0 do
    begin
      currentFloor := currentFloor^.next;
      dec(n);
    end;
    { TODO : Create getIntro function }
    //intro := getIntro(seed);
    { TODO : Change setPosition procedure }
    setPosition(pos, currentFloor);
    spinList[1].part := 3;
    spinList[1].dir := false;
    spinList[2].part := 2;
    spinList[2].dir := true;
    spinList[3].part := 1;  
    spinList[3].dir := true;
    spinList[4].part := 1;
    spinList[4].dir := false;
    spinList[5].part := 4;
    spinList[5].dir := true;
    spinList[6].part := 5;
    spinList[6].dir := false;
    spinList[7].part := 2;
    spinList[7].dir := false;
    spinList[8].part := 6;
    spinList[8].dir := false;
    spinList[9].part := 3;
    spinList[9].dir := true;
    spinList[10].part := 6;
    spinList[10].dir := true;
    spinList[11].part := 4;
    spinList[11].dir := false;
    spinList[12].part := 5;
    spinList[12].dir := true;

  end;

end;


procedure TGameForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainMenuForm.close;
  { TODO : ADD SAVING TO FILE }
  //saveFile(getSave, getPath);
end;

function timeToStr(time: integer):String;
var
  min, hr: byte;
begin
  result := '';
  min := time mod 60;
  hr := time div 60 mod 24;
  if hr < 10 then
    result := result + '0';
  result := result + IntToStr(hr) + ':';
  if min < 10 then
    result := result + '0';
  result := result + IntToStr(min);
end;

procedure spin(list: TList);
begin
  randomize;
  spinFloors(list, random(6)+1, Boolean(random(2)));
end;

procedure rotateFloors(list: TList; color: TCol);
begin
  list := list^.next;
  while list^.floor.color <> color do
  begin
    list := list^.next;
  end;
  inc(list^.floor.direction);
  if list^.floor.direction = 4 then
    list^.floor.direction := 0;
end;

procedure rotate(list: TList);
begin
  randomize;
  rotateFloors(list, TCol(random(8)));
end;

procedure TGameForm.timeTimerTimer(Sender: TObject);
begin
  inc(time);
  timeLable.Caption := timeToStr(time);
  if time mod 120 = 0 then
    spin(list);
  if time mod 30 = 0 then
    rotate(list);
end;

function colorToColor(color: TCol):TColor;
begin
  case color of
    RED:
      result := RGB(205, 74, 76);
    YEL:
      result := clYellow;
    BLU:
      result := clBlue;
    BLK:
      result := clBlack;
    WHI:
      result := clGray;
    GRE:
      result := clGreen;
    ORG:
      result := RGB(253, 122, 8);
    PUR:
      result := RGB(210, 66, 215);
  end;
end;

procedure TGameForm.fieldDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  case currentFloor^.floor.map[ARow + 1, ACol + 1] of
    1:
      field.Canvas.Brush.Color := colorToColor(currentFloor^.floor.color);
    0:
      field.Canvas.Brush.Color := clWhite;
    2:
      field.Canvas.Brush.Color := clRed;
  end;
  field.Canvas.FillRect(field.CellRect(ACol, ARow));
end;


procedure TGameForm.fieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  x, y, level: integer;
begin
  currentFloor^.floor.map[pos.point.y, pos.point.x] := 0;
  field.Canvas.Brush.Color := clWhite;
  field.Canvas.FillRect(field.CellRect(pos.point.x - 1, pos.point.y - 1));
  case key of
    37:
    begin
      if currentFloor^.floor.map[pos.point.y, pos.point.x - 1] = 0 then
      begin
        dec(pos.point.x);
        if time mod 120 = 0 then
          spin(list);
        if time mod 30 = 0 then
          rotate(list);
      end;
    end;
    38:
    begin
      if currentFloor^.floor.map[pos.point.y - 1, pos.point.x] = 0 then
      begin
        dec(pos.point.y);
        if time mod 120 = 0 then
          spin(list);  
        if time mod 30 = 0 then
          rotate(list);

      end;
    end;
    39:
    begin
      if currentFloor^.floor.map[pos.point.y, pos.point.x + 1] = 0 then
      begin
        inc(pos.point.x);
        if time mod 120 = 0 then
          spin(list); 
        if time mod 30 = 0 then
          rotate(list);

      end;
    end;
    40:
    begin
      if currentFloor^.floor.map[pos.point.y + 1, pos.point.x] = 0 then
      begin
        inc(pos.point.y);
        if time mod 120 = 0 then
          spin(list); 
        if time mod 30 = 0 then
          rotate(list);

      end;
    end;
  end;

  currentFloor^.floor.map[pos.point.y, pos.point.x] := 2;
  field.Canvas.Brush.Color := clRed;
  field.Canvas.FillRect(field.CellRect(pos.point.x - 1, pos.point.y - 1));

  x := pos.point.x;
  y := pos.point.y;
  level := currentFloor^.floor.level;
  case currentFloor^.floor.direction of
  0:
  begin
  if (x = 2) and (y > 25) and (y < 75) then
  begin
    if level = 5 then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 98;
      x := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 2) or (level = 6) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 98;
        x := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (x = 99) and (y > 25) and (y < 75) then
  begin
    if (level = 3) or (level = 7) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 3;
      x := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 4) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 3;
        x := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 2) and (x > 25) and (x < 75) then
  begin
    if (level = 4) or (level = 8) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 98;
      y := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 1) or (level = 5) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 98;
        y := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 99) and (x > 25) and (x < 75) then
  begin
    if (level = 6) or (level = 2) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 3;
      y := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 7) or (level = 3) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 3;
        y := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if ((x < 7) and (y = 2)) or ((y < 7) and (x = 2)) then
  begin
    if level = 1 then
    begin
      if (not Assigned(WinForm)) then
      begin
        WinForm:=TWinForm.Create(Self);
        WinForm.Show;
      end;
      GameForm.Hide;
    end;
  end;
  end;
  1:
  begin
  if (x = 2) and (y > 25) and (y < 75) then
  begin
    if (level = 2) or (level = 6) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 98;
      x := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 3) or (level = 7) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 98;
        x := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (x = 99) and (y > 25) and (y < 75) then
  begin
    if (level = 4) or (level = 8) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 3;
      x := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 5) or (level = 1) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 3;
        x := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 2) and (x > 25) and (x < 75) then
  begin
    if (level = 5) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 98;
      y := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 2) or (level = 6) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 98;
        y := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 99) and (x > 25) and (x < 75) then
  begin
    if (level = 3) or (level = 7) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 3;
      y := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 4)  then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 3;
        y := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if ((x > 94) and (y = 2)) or ((y < 7) and (x = 99)) then
  begin
    if level = 1 then
    begin
      if (not Assigned(WinForm)) then
      begin
        WinForm:=TWinForm.Create(Self);
        WinForm.Show;
      end;
      GameForm.Hide;
    end;
  end;
  end;
  2:
  begin
  if (x = 2) and (y > 25) and (y < 75) then
  begin
    if (level = 3) or (level = 7) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 98;
      x := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 4) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 98;
        x := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (x = 99) and (y > 25) and (y < 75) then
  begin
    if (level = 5) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 3;
      x := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 2) or (level = 6) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 3;
        x := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 2) and (x > 25) and (x < 75) then
  begin
    if (level = 2) or (level = 6) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 98;
      y := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 3) or (level = 7) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 98;
        y := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 99) and (x > 25) and (x < 75) then
  begin
    if (level = 4) or (level = 8) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 3;
      y := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 5) or (level = 1) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 3;
        y := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if ((x > 94) and (y = 99)) or ((y > 94) and (x = 99)) then
  begin
    if level = 1 then
    begin
      if (not Assigned(WinForm)) then
      begin
        WinForm:=TWinForm.Create(Self);
        WinForm.Show;
      end;
      GameForm.Hide;
    end;
  end;
  end;
  3:  
  begin
  if (x = 2) and (y > 25) and (y < 75) then
  begin
    if (level = 4) or (level = 8) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 98;
      x := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 1) or (level = 5) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 98;
        x := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (x = 99) and (y > 25) and (y < 75) then
  begin
    if (level = 2) or (level = 6) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.x := 3;
      x := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 3) or (level = 7) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.x := 3;
        x := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 2) and (x > 25) and (x < 75) then
  begin
    if (level = 3) or (level = 7) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 98;
      y := 98;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 4) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 98;
        y := 98;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if (y = 99) and (x > 25) and (x < 75) then
  begin
    if (level = 5) then
    begin
      currentFloor^.floor.map[y, x] := 0;
      currentFloor := currentFloor^.prev;
      pos.point.y := 3;
      y := 3;
      currentFloor^.floor.map[y, x] := 2;
      field.Repaint;
    end
    else
    begin
      if (level = 2) or (level = 6) then
      begin
        currentFloor^.floor.map[y, x] := 0;
        currentFloor := currentFloor^.next;
        pos.point.y := 3;
        y := 3;
        currentFloor^.floor.map[y, x] := 2;
        field.Repaint;
      end;
    end;
  end;
  if ((x < 7) and (y = 99)) or ((y > 94) and (x = 99)) then
  begin
    if level = 1 then
    begin
      if (not Assigned(WinForm)) then
      begin
        WinForm:=TWinForm.Create(Self);
        WinForm.Show;
      end;
      GameForm.Hide;
    end;
  end;

  end;
  end;
end;

end.
