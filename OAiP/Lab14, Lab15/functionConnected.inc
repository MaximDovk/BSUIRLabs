function connected(graph: TGraph; vertexA, vertexB: TVertex):Boolean;
var
  vert: TVertex;
begin
  if vertexB in graph[vertexA] then
    result := true
  else
  begin
    result := false;
    for vert := b1 to b10 do
    begin
      graph[vert] := graph[vert] - [vertexA];
      if vert in graph[vertexA] then
        result := result or connected(graph, vert, vertexB);
    end;
  end;
end;