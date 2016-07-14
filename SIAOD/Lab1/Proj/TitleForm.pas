unit TitleForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TFormLoad = class(TForm)
    Background: TImage;
    lLoading: TLabel;
    timer: TTimer;
    procedure timerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLoad: TFormLoad;

implementation

uses FormMainMenu;

{$R *.dfm}

var
  time, loadStep: integer;
  loadFile: textFile;

procedure TFormLoad.FormCreate(Sender: TObject);
begin
  if not FileExists('start.data') then
  begin
    assignFile(loadFile, 'start.data');
    rewrite(loadFile);
    writeln(loadFile, 'Проверка настроек игры');
    writeln(loadFile, 'Проверка изображений');
    writeln(loadFile, 'Проверка звуков');
    writeln(loadFile, 'Проверка генератора лабиринта');
    writeln(loadFile, 'Проверка структур храниения лабиринта');
    writeln(loadFile, 'Загрузка вступлений');
    writeln(loadFile, 'Загрузка результатов прошлых игр');
    writeln(loadFile, 'Загрузка завершена');
    writeln(loadFile, 'lastLine');
    closeFile(loadFile);
  end;
  assignFile(loadFile, 'start.data');
  reset(loadFile);
  randomize;
  loadStep := 0;
end;

procedure load(var loadStep: integer);
type
  TSettings = record
   { TODO : Add settings }
  end;
  TResults = record
    result: Boolean;
    name: String[20];
    steps: integer;
  end;
var
  settingsFile: file of TSettings;
  resultsFile: file of TResults;
  introFile: textFile;
  settings: TSettings;
begin
  inc(loadStep);
  case loadStep of
    1:
      if not FileExists('settings.data') then
      begin
        assignFile(settingsFile, 'settings.data');
        rewrite(settingsFile);
        write(settingsFile, settings);
        closeFile(settingsFile);
      end;
    2:
      if not FileExists('intro.data') then
      begin
        assignFile(introFile, 'intro.data');
        rewrite(introFile);
        writeln(introFile, '1');
        writeln(introFile, 'Я попал на летающую тарелку случайно.');
        closeFile(introFile);
      end;
    3:
      if not FileExists('results.data') then
      begin
        assignFile(resultsFile, 'results.data');
        rewrite(resultsFile);
        closeFile(resultsFile);
      end;
  end;
end;

procedure TFormLoad.timerTimer(Sender: TObject);
var
  str: String;
begin
  if time = 0 then
  begin
    readln(loadFile, str);

    lLoading.Caption := str; 
    if eof(loadFile) then
    begin
      timer.Enabled := false;
      if (not Assigned(MainMenuForm)) then
      begin
        MainMenuForm:=TMainMenuForm.Create(Self);
        MainMenuForm.Show;
      end;
      FormLoad.Visible := false;
    end;
    time := random(5)+2;
  end
  else
    dec(time);
  load(loadStep);
end;

procedure TFormLoad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  closeFile(loadFile);
end;

procedure TFormLoad.BackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 FormLoad.perform(WM_SysCommand,$F012,0);
end;

end.

