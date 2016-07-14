program R5;

{$APPTYPE CONSOLE}

uses
  Windows;

type
  TPoint = record
    x, y: Real;
  end;
  TPoints = array of TPoint;
  TDistances = record
    left, right: Real;
  end;

var
  points: TPoints;
  pointLeft, pointRight, currentPoint: TPoint;
  eps: Real;
  currentDistances: TDistances;

function getEps():Real;
begin
  write('Введите эпсилон: ');
  readln(result);
end;

function getPoints():TPoints; overload;
var
  i, n: Integer;
begin
  write('Введите количество точек: ');
  readln(n);
  setLength(result, n);
  for i := 0 to n - 1 do
  begin
    write('Введите координаты точек ', i + 1, ': ');
    readln(result[i].x, result[i].y);
  end;
end;

function getPoints(const str: String):TPoints; overload;
begin
  setLength(result, 10);

  result[0].x := 145; result[0].y := 112;
  result[1].x := 33;  result[1].y := 168;
  result[2].x := 33;  result[2].y := 162;
  result[3].x := 122; result[3].y := 58;
  result[4].x := 78;  result[4].y := 98;
  result[5].x := 126; result[5].y := 82;
  result[6].x := 125; result[6].y := 93;
  result[7].x := 114; result[7].y := -58;
  result[8].x := 126; result[8].y := -28;
  result[9].x := 138; result[9].y := -62;
end;

function getDistance(const point1, point2: TPoint):Real;
begin
  result := sqrt(sqr(point2.x - point1.x) + sqr(point2.y - point1.y));
end;

procedure getSegment(const points: TPoints; var min, max: TPoint);
var
  i: Integer;
begin
  min.y := 0;
  max.y := 0;
  min.x := points[0].x;
  max.x := points[0].x;
  for i := 1 to length(points) - 1 do
  begin
    if points[i].x > max.x then
      max.x := points[i].x;
    if points[i].x < min.x then
      min.x := points[i].x;
  end;
end;

function getMaxOfDistances(const points: TPoints; const point: TPoint):TDistances;
var
  i: Integer;
  distance: Real;
begin
  result.left := 0;
  result.right := 0;
  for i := 0 to length(points) - 1 do
  begin
    distance := getDistance(point, points[i]);
    if points[i].x > point.x then
    begin
      if distance > result.right then
        result.right := distance;
    end
    else
    begin
      if distance > result.left then
        result.left := distance;
    end;
  end;
end;

function getOutputLength(eps: Real):Integer;
begin
  result := 0;
  while eps < 1 do
  begin
    inc(result);
    eps := eps * 10;
  end;
end;

procedure outputResult(const point: TPoint; const distance: TDistances; const outputLength: Integer);
begin
  writeln('Точка: (', point.x:0:outputLength, ', ', point.y:0:outputLength, ')');
  if distance.left > distance.right then
    writeln('Расстояние: ', distance.left:0:outputLength)
  else
    writeln('Расстояние: ', distance.right:0:outputLength);
end;

procedure binarySearch( const points: TPoints; var currentPoint, pointLeft, pointRight: TPoint; var currentDistances: TDistances; const eps: Real);
begin
  currentPoint.y := 0;
  currentPoint.x := (pointLeft.x + pointRight.x) / 2;
  while (pointRight.x - pointLeft.x > eps) do
  begin
    currentDistances := getMaxOfDistances(points, currentPoint);
    if currentDistances.left < currentDistances.right then
      pointLeft.x := currentPoint.x
    else
      pointRight.x := currentPoint.x;
    currentPoint.x := (pointLeft.x + pointRight.x) / 2;
  end;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  eps := getEps();
  points := getPoints();
  getSegment(points, pointLeft, pointRight);
  binarySearch(points, currentPoint, pointLeft, pointRight, currentDistances, eps);
  outputResult(currentPoint, currentDistances, getOutputLength(eps));
  readln;
end.
