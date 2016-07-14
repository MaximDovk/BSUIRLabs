program Lab3;

{$APPTYPE CONSOLE}

uses
  Windows;

const
  N = 1; //Количество классов

type
  TValue = record
    key: String;
    data: String;
  end;               
  TOutputProc = procedure(const value: TValue);
  TList = ^TElem;
  TElem = record
    value: TValue;
    next: TList;
  end;
  TDictionary = array [0..N - 1] of TList;

var
  dict: TDictionary;     

{ Преобразует 2 строки в запись типа TValue }
function getValue(key, data: String):TValue;
begin
  result.key := key;
  result.data := data;
end;
    
{ Выводит ключ (термин) из записи }
procedure outputKey(const value: TValue);
begin
  writeln(value.key);
end;
      
{ Выводит данные (определение) из записи }
procedure outputData(const value: TValue);
begin
  writeln(value.data);
end;
      
{ Выводит термин и определение }
procedure outputAll(const value: TValue);
begin
  writeln(value.key, ': ');
  writeln('':7, value.data);
end;
     
{ Процедура добавления элемента в список }
procedure insert(list: TList; value: TValue);
var
  temp: TList;
begin
  new(temp);
  temp^.value := value;
  temp^.next := list^.next;
  list^.next := temp;
end;
   
{ Процедура удаления элемента из начала списка }
procedure delete(list: TList);
var
  temp: TList;
begin
  if list^.next <> nil then
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;
          
{ Поиск и вывод значения из списка }
procedure outputFromList(list: TList; const key: String; proc: TOutputProc);
begin
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.value.key = key then
      proc(list^.value);
  end;
end;
       
{ Поиск элемента в списке }
function getFromList(list: TList; const key: String):TList;
begin
  while (list^.next <> nil) and (list^.next^.value.key <> key) do
  begin
    list := list^.next;
  end;
  result := list;
end;
      
{ Вывод всех значений списка }
procedure outputList(list: TList; proc: TOutputProc);
begin
  while list^.next <> nil do
  begin
    list := list^.next;
    proc(list^.value);
  end;
end;
    
{ Очистка списка }
procedure clearList(list: TList);
begin
  while list^.next <> nil do
    delete(list);
end;
          
{ Хэш-функция }
function hash(key: String):integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to length(key) do
  begin
    inc(result, ord(key[i]));
  end;
  result := result mod N;
end;
        
{ Добавление элемента в словарь }
procedure insertToDict(dict: TDictionary; const value: TValue);
begin
  insert(dict[hash(value.key)], value);
end;
           
{ Поиск и вывод элемента в словаре }
procedure outputFromDict(dict: TDictionary; const key: String; proc: TOutputProc);
begin
  outputFromList(dict[hash(key)], key, proc);
end;
      
{ Возвращает элемент по ключу }
{ Если элемента в словаре нет, то list^.next = nil }
function getFromDict(dict: TDictionary; const key: String):TList;
begin
  result := getFromList(dict[hash(key)], key);
end;
     
{ Выводит все значения из класса с искомым элементом }
procedure outputListWhere(dict: TDictionary; const key: String; proc: TOutputProc);
begin
  if getFromDict(dict, key)^.next <> nil then
  begin
    writeln('Термины в классе, где содержится "', key, '":');
    outputList(dict[hash(key)], proc);
  end
  else
    writeln('Данного термина в словаре нет');
end;
    
{ Удаляет элемент из словаря }
procedure deleteFromDict(dict: TDictionary; const key: String);
begin
  delete(getFromList(dict[hash(key)], key));
end;
                 
{ Изменяет определение термина }
procedure changeInDict(dict: TDictionary; const key, data: String);
var
  temp: TList;
begin
  temp := getFromDict(dict, key)^.next;
  if temp <> nil then
    temp^.value.data := data;
end;
          
{ Создаёт вершины списков }
procedure createDictionary(var dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to n - 1 do
    new(dict[i]);
end;
            
{ Добавляет данные в словарь }
procedure inputData(dict: TDictionary);
begin
  insertToDict(dict, getValue('Логика', 'Наука о формах и законах правильного мышления'));
  insertToDict(dict, getValue('Физика', 'Наука о законах природы, материи'));
  insertToDict(dict, getValue('Математика', 'Наука о структурах, порядке и отношениях'));
  insertToDict(dict, getValue('Химия', 'Наука о веществах, их составе и строении'));
  insertToDict(dict, getValue('Биология', 'Наука о живых существах и их взаимодействии с окружающей средой'));
  insertToDict(dict, getValue('Астрономия', 'Наука о Вселенной, небесных телах'));
  insertToDict(dict, getValue('Информатика', 'Наука о методах и процессах сбора, хранения, обработки информации'));
end;
        
{ Очищает словарь }
procedure clearDict(dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to n - 1 do
    clearList(dict[i]);
end;
               
{ Удаляет словарь }
procedure deleteDict(var dict: TDictionary);
var
  i: Integer;
begin
  clearDict(dict);
  for i := 0 to n - 1 do
    dispose(dict[i]);
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  createDictionary(dict);
  inputData(dict);

  outputFromDict(dict, 'Физика', outputAll);
  writeln;

  changeInDict(dict, 'Физика', '=(');
  outputListWhere(dict, 'Физика', outputKey);
  writeln;

  deleteFromDict(dict, 'Химия');
  outputList(getFromDict(dict, 'Биология'), outputAll);

  deleteDict(dict);
  readln;
end.
