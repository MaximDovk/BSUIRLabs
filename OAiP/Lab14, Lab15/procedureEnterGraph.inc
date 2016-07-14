procedure enterGraph(var graph: TGraph);
var
  a, b: Integer;
begin
  repeat
    write(sFIRST_VERTEX);
    readln(a);
  until (a >= 0) and (a <= 10);
  repeat
    write(sSECOND_VERTEX);
    readln(b);
  until (b >= 0) and (b <= 10);
  writeln;
  if (a <> 0) or (b <> 0) then
  begin
    graph[TVertex(a - 1)] := graph[TVertex(a - 1)] + [TVertex(b - 1)];
    graph[TVertex(b - 1)] := graph[TVertex(b - 1)] + [TVertex(a - 1)];
    enterGraph(graph);
  end;
end;