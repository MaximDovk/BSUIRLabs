program Lab13;

{$APPTYPE CONSOLE}

uses
  Windows;

const
  { Количество точностей вычисления }
  NUM_OF_EPS = 3;

type                
  { Подинтегральная функция }
  TFunc = function(x: Real):Real;
  { Метод вычисления интеграла }
  TMethod = function(func: TFunc; a, b: Real; n: Integer):Real;
  { Массив точностей }
  TEPS = array [1..NUM_OF_EPS] of real;
  { Результат для метода, функции и точности }
  TResult = record
    res: Real;
    n: Integer;
  end;
  { Таблица результатов для 2 функций, 2 методов и всех точностей }
  TResults = array [1..2, 1..2, 1..NUM_OF_EPS] of TResult;

const
  { Массив точностей }
  EPS: TEPS = (0.001, 0.0001, 0.00001);

var
  { Результаты }
  table: TResults;

{ Первая функция }
function firstFunction(x: Real):Real;
begin
  result := sqrt(sqr(x) + 5) / (2 * x + sqrt(sqr(x) + 0.5));
end;

{ Вторая функция }
function secondFunction(x: Real):Real;
begin
  result := sin(2 * x + 0.5) / (2 + cos(sqr(x) + 1));
end;

{ Метод левых прямоугольников }
function calcLeftRectangle(func: TFunc; a, b: Real; n: Integer):Real;
var
  h: Real;
  i: Integer;
begin
  result := 0;
  h := (b - a) / n;
  for i := 0 to n - 1 do
    result := result + func(a + i * h);
  result := result * h;
end;

{ Метод центральных прямоугольников }
function calcMidRectangle(func: TFunc; a, b: Real; n: Integer):Real;
var
  h: Real;
  i: Integer;
begin
  result := 0;
  h := (b - a) / n;
  for i := 0 to n - 1 do
    result := result + func(a + (i + 0.5) * h);
  result := result * h;
end;

{ Вычисление интеграла методом до заданной точности }
{ Возвращает результат и количество отрезков }
function calcWithEps(method: TMethod;
                     func: TFunc;
                     eps, a, b: Real):TResult;
var
  lastValue: Real;
begin
  result.res := method(func, a, b, 1);
  result.n := 1;
  repeat
    lastValue := result.res;
    result.n := result.n * 2;
    result.res := method(func, a, b, result.n);
  until abs(result.res - lastValue) <= eps;
end;

{ Заполнение таблицы результатов }
function calcTable(method1, method2: TMethod; func1, func2: TFunc;
                   eps: TEPS; a1, b1, a2, b2: Real):TResults;
var
  i: Integer;
begin
  for i := 1 to length(eps) do
  begin
    result[1, 1, i] := calcWithEps(method1, func1, eps[i], a1, b1);
    result[1, 2, i] := calcWithEps(method2, func1, eps[i], a1, b1);
    result[2, 1, i] := calcWithEps(method1, func2, eps[i], a2, b2);
    result[2, 2, i] := calcWithEps(method2, func2, eps[i], a2, b2);
  end;
end;

{ Вывод таблицы результатов }
procedure outputTable(table: TResults; eps: TEPS);
var
  func, method, i: Integer;
begin
  for func := 1 to 2 do
  begin
    writeln('       Функция ', func, ':');
    for method := 1 to 2 do
    begin
      writeln('   Метод ', method, ':');
      for i := 1 to length(eps) do
        writeln('I = ', table[func, method, i].res:0:6,
                '    N = ', table[func, method, i].n:5,
                '    EPS = ', eps[i]:0:6);
    end;
    writeln;
  end;
end;

{ Вывод информации о функциях и методах }
procedure outputHelp();
begin
  writeln('Функция 1: ');
  writeln('   sqrt(sqr(x) + 5) / (2 * x + sqrt(sqr(x) + 0.5))');
  writeln('   Пределы от 0.6 до 1.4');
  writeln('Функция 2: ');
  writeln('   sin(2 * x + 0.5) / (2 + cos(sqr(x) + 1))');
  writeln('   Пределы от 0.2 до 0.8');
  writeln;
  writeln('Метод 1: ');
  writeln('   Метод левых прямоугольников');
  writeln('Метод 2: ');
  writeln('   Метод центральных прямоугольников');
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);
  table := calcTable(calcLeftRectangle, calcMidRectangle,
                     firstFunction, secondFunction,
                     EPS, 0.6, 1.4, 0.2, 0.8);
  outputTable(table, EPS);
  outputHelp;
  readln;
end.
