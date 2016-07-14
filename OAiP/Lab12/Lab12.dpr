program Lab12;

{$APPTYPE CONSOLE}

uses
  SysUtils;

const
  // Диапазон
  LOW = 0;
  HIGH = 3;

  // Шаг вычислений
  STEP = 0.1;

  // Точность вычисления
  TAYLOR_EPS = 0.0001;

  // Путь к файлу
  FILE_PATH = 'sin0_3.txt';

type
  TResult = array [0..30, 1..3] of Real;

var
  f: Text;
  res: TResult;

// Вычисляет значение sin с помощью разложения в ряд Тейлора
function taylorSin(x, taylorEps: Real):Real;
var
  elem: Real;
  fract: Integer;
begin
  result := 0;
  fract := 1;
  elem := x;
  repeat
    result := result + elem;
    elem := - elem * x * x;
    elem := elem / ((fract + 1) * (fract + 2));
    inc(fract, 2);
  until abs(elem) < taylorEps / 10;
end;

// Заполняет массив результатами
function getResult(low, high, step, taylorEps: Real):TResult;
var
  current: Real;
  i: Integer;
begin
  current := low;
  for i := 0 to 30 do
  begin
    result[i, 1] := current;
    result[i, 2] := sin(current);
    result[i, 3] := taylorSin(current, taylorEps);
    current := current + step;
  end;
end;

// Создаёт файл и записывает туда результаты
procedure saveToFile(var f: text; path: String; res: TResult);
var
  i: Integer;
begin
  AssignFile(f, path);
  Rewrite(f);
  DecimalSeparator := '.';
  writeln(f, 'X':3, 'sin(X)':16, 'taylorSin(x)':21);
  for i := 0 to 30 do
    writeln(f, res[i, 1]:4:1, res[i, 2]:15:5, floatToStrF(res[i, 3], ffExponent, 6, 4):21);
  CloseFile(f);
end;

begin
  res := getResult(LOW, HIGH, STEP, TAYLOR_EPS);
  saveToFile(f, FILE_PATH, res);
end.
