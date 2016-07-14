unit UFiles;

interface

implementation

uses
  UTypes, UHistory, SysUtils, DateUtils;

const
  HISTORY_PATH = 'history.dat';

{ ��������� ������� �� ����� }
procedure readHistory(path: String);
var
  historyFile: file of THistoryCell;
  historyCell: THistoryCell;
begin
  AssignFile(historyFile, path);
  if FileExists(path) then
  begin
    Reset(historyFile);
    while not eof(historyFile) do
    begin
      read(historyFile, historyCell);
      if DaysBetween(historyCell.date, Today) < 5 then
        addLastHistoryCell(historyCell);
    end;
  end
  else
    Rewrite(historyFile);
  CloseFile(historyFile);
end;

{ ��������� ������� � ���� }
procedure saveHistory(path: String);
var
  historyFile: file of THistoryCell;
  historyCell: THistoryCell;
begin
  AssignFile(historyFile, path);
  Rewrite(historyFile);
  while not isEmptyList do
  begin
    historyCell := pop;
    write(historyFile, historyCell);
  end;
  CloseFile(historyFile);
end;

initialization
  readHistory(HISTORY_PATH);

finalization
  saveHistory(HISTORY_PATH);

end.
 