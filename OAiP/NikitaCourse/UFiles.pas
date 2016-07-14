unit UFiles;

interface

implementation

uses
  UHistory, SysUtils;

procedure readHistory();
var
  historyFile: file of THistoryCell;
  historyCell: THistoryCell;
begin
  AssignFile(historyFile, 'results.dat');
  if FileExists('results.dat') then
  begin
    Reset(historyFile);
    while not eof(historyFile) do
    begin
      read(historyFile, historyCell);
      addHistoryItem(historyCell);
    end;
  end
  else
    Rewrite(historyFile);
  CloseFile(historyFile);
end;

procedure saveHistory();
var
  historyFile: file of THistoryCell;
  historyArray: THistoryArray;
  i: Integer;
begin
  AssignFile(historyFile, 'results.dat');
  Rewrite(historyFile);
  historyArray := returnHistory;
  for i := 0 to length(historyArray) - 1 do
  begin
    write(historyFile, historyArray[i]);
  end;
  CloseFile(historyFile);
end;

initialization
  readHistory();

finalization
  saveHistory();

end.
