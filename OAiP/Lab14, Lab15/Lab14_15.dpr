program Lab14_15;

{$APPTYPE CONSOLE}

uses
  Windows;

const
  sFIRST_VERTEX = 'Введите первую вершину: ';
  sSECOND_VERTEX = 'Введите вторую вершину: ';

{$I types.inc}

var
  graph: TGraph;
  vertexFrom, vertexTo: TVertex;

{ Заправшивает ввод двух вершин графа до ввода двух нулей }
{ Создаёт в переданном графе связь между введёнными вершинами }
{$I procedureEnterGraph.inc}

{ Запрашивает ввод номера вершины, возвращает эту вершину }
{$I functionEnterVertex.inc}

{ Рекурсивный алгоритм поиска в глубину }
{ Возвращает true, если есть путь между введёнными вершинами }
{ Иначе возвращает false }
{$I functionConnected.inc}

begin
  {$I ..\RU_Console.inc}
  enterGraph(graph);
  vertexFrom := enterVertex('Введите начальную вершину: ');
  vertexTo := enterVertex('Введите конечную вершину: ');
  writeln(connected(graph, vertexFrom, vertexTo));
  readln;
end.

