unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, UTypes, USnakeList, Buttons, StdCtrls, UHistory;

type
  TfrmMain = class(TForm)
    imageField: TImage;
    panelButtons: TPanel;
    timerField: TTimer;
    timerStart: TTimer;
    btnMainMenu: TSpeedButton;
    btnExit: TSpeedButton;
    labelPlayerScoreTitle: TLabel;
    labelPlayerScore: TLabel;
    labelComputerScoreTitle: TLabel;
    labelComputerScore: TLabel;
    btnPause: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure timerStartTimer(Sender: TObject);
    procedure timerFieldTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPauseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure btnMainMenuClick(Sender: TObject);
  private                
    CGrass, CLand, CApple, CSnake, CBot, CPoison: TBitmap;    
    FGameResult: TGameResult;
    FStartCountDown: Integer;
    FCellWidth: Real;
    FCellHeight: Real;
    FChangedDirection: Boolean;
    
    FField: TField;
    FPlayerScore: Integer;
    FPlayerSnakeDirection: TDirection;
    FPlayerSnake: TSnakeList;
    FPlayerSnakeLength: Integer;

    FComputerAlive: Boolean;
    FComputerScore: Integer;
    FComputerSnakeDirection: TDirection;
    FComputerSnake: TSnakeList;
    FComputerSnakeLength: Integer;

    procedure setPlayerScore(score: Integer);
    procedure setComputerScore(score: Integer);

    property PPlayerScore: Integer read FPlayerScore write setPlayerScore;
    property PComputerScore: Integer read FComputerScore write setComputerScore;

    procedure setCellSize;
    procedure clearField;
    procedure outputField;
    procedure outputCell(value: TFieldCellContent; x, y: Integer);
    procedure setRandomSnake(len: Integer; snakeType: TFieldCellContent; snake: TSnakeList);
    procedure gameEnd;
    procedure gamePause;
    procedure displayNote(note: String);
    function nextCell(cell: TCell; direction: TDirection):TCell;
    procedure addFood;
    procedure addPoison;
    procedure addRandomFood(num: Integer);
    procedure addRandomPoison(num: Integer);
    procedure setDirection(var direction: TDirection; newDirection: TDirection);
    function computerMove:TDirection;

    procedure saveToFile();
    procedure readFromFile();
  public
    newGame: Boolean;
    procedure gameStart;
  end;

var
  frmMain: TfrmMain;

implementation

uses UMenu;

{$R *.dfm}

{ TfrmMain }   

procedure TfrmMain.setCellSize;
begin
  FCellWidth := imageField.Width / FIELD_SIZE;
  FCellHeight := imageField.Height / FIELD_SIZE;
end;

procedure TfrmMain.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  Resize := ((NewHeight <= 700) and (NewWidth <= 1000)) and ((NewHeight >= 500) and (NewWidth >= 600));
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
  setCellSize;
  outputField;
end;

procedure TfrmMain.clearField;
var
  i, j, k: Integer;
begin
  Randomize;
  for i := 0 to FIELD_SIZE - 1 do
    for j := 0 to FIELD_SIZE - 1 do
    begin
      k := random(3);
      if k = 2 then
        k := 0;
      FField[i, j] := TFieldCellContent(k);
    end;
end;

procedure TfrmMain.outputCell(value: TFieldCellContent; x, y: Integer);
begin
  case value of  
    fccLAND:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CLand.Canvas,
                                      Rect(0, 0, Round(FCellWidth), Round(FCellHeight)));
    end;
    fccGRASS:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CGrass.Canvas,
                                      Rect(0, 0, Round(FCellWidth), Round(FCellHeight)));
    end;
    fccSNAKE:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CSnake.Canvas,
                                      Rect(0, 0, 31, 31));
    end;     
    fccBOT:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CBot.Canvas,
                                      Rect(0, 0, 31, 31));
    end;
    fccFOOD:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CApple.Canvas,
                                      Rect(0, 0, 31, 31));
    end;
    fccPOISON:
    begin
      imageField.Canvas.CopyRect(Rect(Round(FCellWidth * x), Round(FCellHeight * y),
                                      Round(FCellWidth * x + FCellWidth),
                                      Round(FCellHeight * y + FCellHeight)), CPoison.Canvas,
                                      Rect(0, 0, 31, 31));
    end;
  end;
end;

procedure TfrmMain.outputField;
var
  i, j: Integer;
begin
  for i := 0 to FIELD_SIZE - 1 do
    for j := 0 to FIELD_SIZE - 1 do
      outputCell(FField[i, j], i, j);
  if FGameResult = grPAUSE then
    displayNote('PAUSE');
  if FGameResult = grEND then
    displayNote('GAME OVER!');
end;     

procedure TfrmMain.setRandomSnake(len: Integer; snakeType: TFieldCellContent; snake: TSnakeList);
var
  cell: TCell;
  i: Integer;
begin
  randomize;
  cell.x := random(FIELD_SIZE - 2 * len) + len;
  cell.y := random(FIELD_SIZE - 2 * len) + len;
  addHeadItem(snake, toSnakeData(cell, FField[cell.x, cell.y]));
  FField[cell.x, cell.y] := snakeType;
  for i := 1 to len - 1 do
  begin
    case random(2) of
      0:
        inc(cell.x);
      else
        inc(cell.y);
    end;
    addHeadItem(snake, toSnakeData(cell, FField[cell.x, cell.y]));
    FField[cell.x, cell.y] := snakeType;
  end;
end;

procedure TfrmMain.gameStart;
begin
  timerStart.Enabled := true;
  FStartCountDown := 4;
  FGameResult := grPROCESS;
end;        

procedure TfrmMain.gameEnd;
begin
  timerField.Enabled := false;
  FGameResult := grEND;
  addHistoryItem(toHistoryCell(FPlayerScore, FPlayerSnakeLength));
end;

procedure TfrmMain.gamePause;
begin
  if FGameResult = grPROCESS then
  begin
    FGameResult := grPAUSE;
    timerField.Enabled := false;
  end
  else
    if FGameResult = grPAUSE then
    begin
      FGameResult := grPROCESS;
      timerField.Enabled := true;
    end;
end;

procedure TfrmMain.displayNote(note: String);
begin
  with imageField.Canvas do
  begin
    Font.Size := 25;
    Font.Name := 'Lucida Handwriting';
    Brush.Color := RGB(61, 115, 43);
    TextOut((imageField.Width - TextWidth(note)) div 2,
            (imageField.Height - TextHeight(note)) div 2,
            note);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  panelButtons.Color := RGB(61, 115, 43);

  CGrass := TBitmap.Create;
  CLand := TBitmap.Create;
  CApple := TBitmap.Create;
  CSnake := TBitmap.Create;
  CBot := TBitmap.Create;
  CPoison := TBitmap.Create;
  CGrass.LoadFromFile('grass.bmp');
  CLand.LoadFromFile('land.bmp');
  CApple.LoadFromFile('apple.bmp');
  CSnake.LoadFromFile('snake.bmp');
  CBot.LoadFromFile('bot.bmp');
  CPoison.LoadFromFile('poison.bmp');

  setCellSize;
end;

procedure TfrmMain.timerStartTimer(Sender: TObject);
begin             
  outputField;
  if FStartCountDown > 0 then
  begin
    if FStartCountDown < 4 then
      displayNote(IntToStr(FStartCountDown) + '...')
    else
      displayNote('READY...');
  end
  else
  begin
    if FStartCountDown = 0 then
      displayNote('START!!!')
    else
    begin
      timerStart.Enabled := false;
      timerField.Enabled := true;
    end;
  end;
  dec(FStartCountDown);
end;

function TfrmMain.nextCell(cell: TCell; direction: TDirection): TCell;
begin
  case direction of
    dirUP:
      dec(cell.y);
    dirRIGHT:
      inc(cell.x);
    dirDOWN:
      inc(cell.y);
    dirLEFT:
      dec(cell.x);
  end;
  result := cell;
end;

procedure TfrmMain.timerFieldTimer(Sender: TObject);
var
  cell: TCell;
  lastSnakeData: TSnakeData;
begin
  FChangedDirection := false;
  cell := nextCell(returnHead(FPlayerSnake).cell, FPlayerSnakeDirection);
  if (cell.x = FIELD_SIZE) or
     (cell.x = -1) or
     (cell.y = FIELD_SIZE) or
     (cell.y = -1) or
     (FField[cell.x, cell.y] = fccSNAKE)or
     (FField[cell.x, cell.y] = fccBOT) then
  begin
    gameEnd;
  end
  else
  begin
    case FField[cell.x, cell.y] of
      fccFOOD:
      begin
        inc(FPlayerSnakeLength);
        addFood;
        timerField.Interval := round(timerField.Interval * 0.95);
        Randomize;
        FField[cell.x, cell.y] := TFieldCellContent(random(2));
        PPlayerScore := PPlayerScore + Round(250 * (FPlayerSnakeLength / 15));
      end;
      fccPOISON:
      begin
        dec(FPlayerSnakeLength);
        if FPlayerSnakeLength < 1 then
          gameEnd
        else
        begin
          lastSnakeData := deleteTailItem(FPlayerSnake);
          FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
          lastSnakeData := deleteTailItem(FPlayerSnake);
          FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
          addPoison;
          Randomize;
          FField[cell.x, cell.y] := TFieldCellContent(random(2));
          PPlayerScore := PPlayerScore - 500;
        end;
      end;
      else
      begin
        lastSnakeData := deleteTailItem(FPlayerSnake);
        FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
        PPlayerScore := PPlayerScore + Round(5 * (FPlayerSnakeLength / 15));
      end;
    end;
    addHeadItem(FPlayerSnake, toSnakeData(cell, FField[cell.x, cell.y]));
    FField[cell.x, cell.y] := fccSNAKE;
  end;
  if FComputerAlive then
  begin            
    FComputerSnakeDirection := computerMove;
    cell := nextCell(returnHead(FComputerSnake).cell, FComputerSnakeDirection);
    if (cell.x = FIELD_SIZE) or
       (cell.x = -1) or
       (cell.y = FIELD_SIZE) or
       (cell.y = -1) or
       (FField[cell.x, cell.y] = fccSNAKE)or
       (FField[cell.x, cell.y] = fccBOT) then
    begin
      FComputerAlive := false
    end
    else
    begin
      case FField[cell.x, cell.y] of
        fccFOOD:
        begin
          inc(FComputerSnakeLength);
          addFood;
          Randomize;
          FField[cell.x, cell.y] := TFieldCellContent(random(2));
          PComputerScore := PComputerScore + Round(250 * (FComputerSnakeLength / 15));
        end;
        fccPOISON:
        begin
          dec(FComputerSnakeLength);
          if FComputerSnakeLength < 1 then
            FComputerAlive := false
          else
          begin
            lastSnakeData := deleteTailItem(FComputerSnake);
            FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
            lastSnakeData := deleteTailItem(FComputerSnake);
            FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
            addPoison;
            Randomize;
            FField[cell.x, cell.y] := TFieldCellContent(random(2));
            PComputerScore := PComputerScore - 500;
          end;
        end;
        else
        begin
          lastSnakeData := deleteTailItem(FComputerSnake);
          FField[lastSnakeData.cell.x, lastSnakeData.cell.y] := lastSnakeData.landType;
          PComputerScore := PComputerScore + Round(5 * (FComputerSnakeLength / 15));
        end;
      end;
      addHeadItem(FComputerSnake, toSnakeData(cell, FField[cell.x, cell.y]));
      FField[cell.x, cell.y] := fccBOT;
    end;
  end;
  outputField;
end;

procedure TfrmMain.addFood;
var
  cell: TCell;
begin
  randomize;
  repeat
    cell.x := random(FIELD_SIZE);
    cell.y := random(FIELD_SIZE);
  until (FField[cell.x, cell.y] = fccLAND) or (FField[cell.x, cell.y] = fccGRASS);
  FField[cell.x, cell.y] := fccFOOD;
end;    

procedure TfrmMain.addPoison;
var
  cell: TCell;
begin
  randomize;
  repeat
    cell.x := random(FIELD_SIZE);
    cell.y := random(FIELD_SIZE);
  until (FField[cell.x, cell.y] = fccLAND) or (FField[cell.x, cell.y] = fccGRASS);
  FField[cell.x, cell.y] := fccPOISON;
end;

procedure TfrmMain.addRandomFood(num: Integer);
var
  i: Integer;
begin
  for i := 1 to num do
    addFood;
end;

procedure TfrmMain.addRandomPoison(num: Integer);
var
  i: Integer;
begin
  for i := 1 to num do
    addPoison;
end;

procedure TfrmMain.setDirection(var direction: TDirection;
  newDirection: TDirection);
begin
  if (abs(Integer(direction) - Integer(newDirection)) <> 2) and not FChangedDirection then
    direction := newDirection;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    37:
      setDirection(FPlayerSnakeDirection, dirLEFT);
    38:
      setDirection(FPlayerSnakeDirection, dirUP);
    39:
      setDirection(FPlayerSnakeDirection, dirRIGHT);
    40:
      setDirection(FPlayerSnakeDirection, dirDOWN);
  end;   
  FChangedDirection := true;
end;

procedure TfrmMain.setPlayerScore(score: Integer);
begin
  FPlayerScore := score;
  labelPlayerScore.Caption := IntToStr(score);
end;

procedure TfrmMain.setComputerScore(score: Integer);
begin
  FComputerScore := score;
  labelComputerScore.Caption := IntToStr(score);
end;

procedure TfrmMain.btnPauseClick(Sender: TObject);
begin
  gamePause;
end;

function TfrmMain.computerMove: TDirection;
var
  cell: TCell;
  snakeHead: TSnakeData;
  distance, temp: Extended;
  i, j: Integer;
  weights: array [0..3] of Integer;
begin
  for i := 0 to 3 do
    weights[i] := 0;
  snakeHead := returnHead(FComputerSnake);
  distance := sqr(FIELD_SIZE);
  for i := 0 to FIELD_SIZE - 1 do
    for j := 0 to FIELD_SIZE - 1 do
    begin
      if FField[i, j] = fccFOOD then
      begin
        temp := abs(snakeHead.cell.x - i) + abs(snakeHead.cell.x - j);
        if distance > temp then
        begin
          distance := temp;
          cell.x := i;
          cell.y := j;
        end;
      end;
    end;
  if cell.y < snakeHead.cell.y then
    inc(weights[0], 10);
  if cell.y > snakeHead.cell.y then
    inc(weights[2], 10);
  if cell.x > snakeHead.cell.x then
    inc(weights[1], 10);
  if cell.x < snakeHead.cell.x then
    inc(weights[3], 10);
  cell := nextCell(snakeHead.cell, dirUP);
  if (FField[cell.x, cell.y] = fccSNAKE) or (FField[cell.x, cell.y] = fccBOT) then
    weights[0] := -10;
  if (FField[cell.x, cell.y] = fccPOISON) then
    dec(weights[0], 10);
  cell := nextCell(snakeHead.cell, dirRIGHT);
  if (FField[cell.x, cell.y] = fccSNAKE) or (FField[cell.x, cell.y] = fccBOT) then
    weights[1] := -10;
  if (FField[cell.x, cell.y] = fccPOISON) then
    dec(weights[1], 10);
  cell := nextCell(snakeHead.cell, dirDOWN);
  if (FField[cell.x, cell.y] = fccSNAKE) or (FField[cell.x, cell.y] = fccBOT) then
    weights[2] := -10;
  if (FField[cell.x, cell.y] = fccPOISON) then
    dec(weights[2], 10);
  cell := nextCell(snakeHead.cell, dirLEFT);
  if (FField[cell.x, cell.y] = fccSNAKE) or (FField[cell.x, cell.y] = fccBOT) then
    weights[3] := -10;
  if (FField[cell.x, cell.y] = fccPOISON) then
    dec(weights[3], 10);
  temp := -100;
  j := 0;
  for i := 0 to 3 do
    if weights[i] > temp then
    begin
      temp := weights[i];
      j := i;
    end;
  result := TDirection(j);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if newGame then
  begin
    FPlayerScore := 0;
    FComputerScore := 0;
    FPlayerSnakeLength := 5;
    FComputerSnakeLength := 5;
    FComputerAlive := true;

    clearField;
    createSnake(FPlayerSnake);
    FPlayerSnakeDirection := dirRIGHT;
    setRandomSnake(5, fccSNAKE, FPlayerSnake);
    createSnake(FComputerSnake);
    FComputerSnakeDirection := dirRIGHT;
    setRandomSnake(5, fccBOT, FComputerSnake);
    addRandomFood(5);
    addRandomPoison(3);
  end
  else
  begin
    createSnake(FPlayerSnake);
    createSnake(FComputerSnake);
    readFromFile;
  end;
  gameStart;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmMenu.Show;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  frmMenu.Close;
end;

procedure TfrmMain.btnMainMenuClick(Sender: TObject);
begin
  if FGameResult = grPROCESS then
  begin
    FGameResult := grPAUSE;
    timerField.Enabled := false;
  end;
  frmMenu.Show;
  Hide;
  if FGameResult <> grEND then
    saveToFile;
end;

procedure TfrmMain.saveToFile;
var
  f: file of TSaveRecord;
  saveRecord: TSaveRecord;
begin
  AssignFile(f, 'temp_game.sav');
  Rewrite(f);
  saveRecord := toSaveRecord('temp_game', FField, returnSnake(FPlayerSnake),
                             returnSnake(FComputerSnake), FPlayerScore,
                             FComputerScore, FComputerAlive, FPlayerSnakeLength,
                             FComputerSnakeLength, FPlayerSnakeDirection,
                             FComputerSnakeDirection);
  write(f, saveRecord);
  CloseFile(f);
end;

procedure TfrmMain.readFromFile;
var
  f: file of TSaveRecord;
  saveRecord: TSaveRecord;
begin
  AssignFile(f, 'temp_game.sav');
  Reset(f);
  read(f, saveRecord);
  FField := saveRecord.field;
  FComputerAlive := saveRecord.botAlive;
  FPlayerSnakeDirection := saveRecord.playerDirection;
  FComputerSnakeDirection := saveRecord.botDirection;
  FPlayerScore := saveRecord.playerScore;
  FComputerScore := saveRecord.botScore;
  FPlayerSnakeLength := saveRecord.playerLength;
  FComputerSnakeLength := saveRecord.botLength;
  fillSnake(saveRecord.playerSnake, FPlayerSnake);
  fillSnake(saveRecord.botSnake, FComputerSnake);
  CloseFile(f);
end;

end.
