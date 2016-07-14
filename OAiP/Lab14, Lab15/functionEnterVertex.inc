function enterVertex(note: String):TVertex;
var
  temp: Integer;
begin
  repeat
    write(note);
    readln(temp);
  until (temp <= 10) and (temp > 0);
  result := TVertex(temp - 1);
end;