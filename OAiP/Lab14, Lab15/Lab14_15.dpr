program Lab14_15;

{$APPTYPE CONSOLE}

uses
  Windows;

const
  sFIRST_VERTEX = '������� ������ �������: ';
  sSECOND_VERTEX = '������� ������ �������: ';

{$I types.inc}

var
  graph: TGraph;
  vertexFrom, vertexTo: TVertex;

{ ������������ ���� ���� ������ ����� �� ����� ���� ����� }
{ ������ � ���������� ����� ����� ����� ��������� ��������� }
{$I procedureEnterGraph.inc}

{ ����������� ���� ������ �������, ���������� ��� ������� }
{$I functionEnterVertex.inc}

{ ����������� �������� ������ � ������� }
{ ���������� true, ���� ���� ���� ����� ��������� ��������� }
{ ����� ���������� false }
{$I functionConnected.inc}

begin
  {$I ..\RU_Console.inc}
  enterGraph(graph);
  vertexFrom := enterVertex('������� ��������� �������: ');
  vertexTo := enterVertex('������� �������� �������: ');
  writeln(connected(graph, vertexFrom, vertexTo));
  readln;
end.

