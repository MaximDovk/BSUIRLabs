unit UTypes;

interface     

const
  FIELD_SIZE = 50;

type
  TGameResult = (grEND, grPROCESS, grPAUSE);
  TFieldCellContent = (fccLAND, fccGRASS, fccSNAKE, fccFOOD, fccPOISON, fccBOT);
  TField = array [0..FIELD_SIZE - 1, 0..FIELD_SIZE - 1] of TFieldCellContent;
  TCell = record
    x, y: Integer;
  end;
  TDirection = (dirUP, dirRIGHT, dirDOWN, dirLEFT);
  TSnakeData = record
    cell: TCell;
    landType: TFieldCellContent;
  end;
  TSnake = array [1..FIELD_SIZE * FIELD_SIZE] of TSnakeData;
  TSaveRecord = packed record
    saveName: String[255];
    field: TField;
    playerSnake, botSnake: TSnake;
    playerScore, botScore: Integer;
    botAlive: Boolean;
    playerLength, botLength: Integer;
    playerDirection, botDirection: TDirection;
  end;

function toSnakeData(cell: TCell; landType: TFieldCellContent):TSnakeData;

function toSaveRecord(saveName: String; field: TField;
                      playerSnake, botSnake: TSnake;
                      playerScore, botScore: Integer;
                      botAlive: Boolean;
                      playerLength, botLength: Integer;
                      playerDirection, botDirection: TDirection):TSaveRecord;

implementation

function toSnakeData(cell: TCell; landType: TFieldCellContent):TSnakeData;
begin
  result.cell := cell;
  result.landType := landType;
end;               

function toSaveRecord(saveName: String; field: TField;
                      playerSnake, botSnake: TSnake;
                      playerScore, botScore: Integer;
                      botAlive: Boolean;
                      playerLength, botLength: Integer;
                      playerDirection, botDirection: TDirection):TSaveRecord;
begin
  result.saveName := saveName;
  result.field := field;
  result.playerSnake := playerSnake; 
  result.botSnake := botSnake;
  result.playerScore := playerScore;
  result.botScore := botScore;
  result.botAlive := botAlive;
  result.playerLength := playerLength;
  result.botLength := botLength;
  result.playerDirection := playerDirection;
  result.botDirection := botDirection;
end;

end.
 