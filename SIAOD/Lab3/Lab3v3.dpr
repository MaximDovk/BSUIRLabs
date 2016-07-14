program Lab3v3;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

const
  n = 60;

type
  TTerms = array of String;
  TArray = array of Integer;

  TPageList = ^TPage;
  TPage = record
    page: Integer;
    next: TPageList;
  end;

  TTermList = ^TTerm;
  TTerm = record
    term: String;
    subterms: TTermList;
    pages: TPageList;
    next: TTermList;
  end;

  TDictionary = array [0..N - 1] of TTermList;

var
  dict: TDictionary;

{ UpCase для кирилицы и латиницы }
function fullUpCase(ch: Char):Char;
begin
  result := ch;
  case ch of
    'a'..'z', 'а'..'я':
      result := chr(ord(ch) - 32);
    'ё':
      result := 'Ё';
  end;
end;

{ Хеш-функция }
function hashFunc(key: String):Integer;
begin
  result := ord(fullUpCase(key[1]));
  case result of
    65..90:
      result := result - 64;
    192..197:
      result := result - 165;
    168:
      result := 33;
    198..223:
      result := result - 164;
    else
      result := 0;
  end;
end;

{ Переводит название и список страниц в TTerm }
function toTerm(const term: String; const pages: TPageList):TTerm;
begin
  result.term := term;
  new(result.subterms);
  result.subterms^.next := nil;
  result.pages := pages;
  result.next := nil;
end;

{ Переводит список страниц в строку }
function toString(pages: TPageList):String;
begin
  result := '';
  while pages^.next <> nil do
  begin
    pages := pages^.next;
    result := result + IntToStr(pages^.page) + ',';
  end;
  delete(result, length(result), 1);
end;

{ Добавление элемента в список }
procedure insert(terms: TTermList; term: TTerm); overload;
var
  temp: TTermList;
begin
  new(temp);
  temp^ := term;
  temp^.next := terms^.next;
  terms^.next := temp;
end;

procedure insert(pages: TPageList; page: Integer); overload;
var
  temp: TPageList;
begin
  new(temp);
  temp^.page := page;
  temp^.next := pages^.next;
  pages^.next := temp;
end;

{ Поиск позиции для добавления элемента без потери упорядоченности }
function findPos(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term < term) do
    terms := terms^.next;
  result := terms;
end;

function findPos(pages: TPageList; page: Integer):TPageList; overload;
begin
  while (pages^.next <> nil) and (pages^.next^.page < page) do
    pages := pages^.next;
  result := pages;
end;

{ Добавление элемента в нужную позицию списка }
procedure insertInList(terms: TTermList; term: TTerm); overload;
begin
  insert(findPos(terms, term.term), term);
end;

procedure insertInList(pages: TPageList; page: Integer); overload;
begin
  insert(findPos(pages, page), page);
end;

{ Удаление элемента из списка }
procedure deletePage(pages: TPageList);
var
  temp: TPageList;
begin
  if pages^.next <> nil then
  begin
    temp := pages^.next;
    pages^.next := temp^.next;
    dispose(temp);
  end;
end;

{ Очистка списка }
procedure clearList(pages: TPageList); overload;
begin
  while pages^.next <> nil do
    deletePage(pages);
end;

procedure delete(terms: TTermList); forward;

procedure clearList(terms: TTermList); overload;
begin
  while terms^.next <> nil do
    delete(terms);
end;

procedure delete(terms: TTermList);
var
  temp: TTermList;
begin
  if terms^.next <> nil then
  begin
    temp := terms^.next;
    terms^.next := temp^.next;
    clearList(temp^.subterms);
    clearList(temp^.pages);
    dispose(temp^.subterms);
    dispose(temp^.pages);
    dispose(temp);
  end;
end;

{ Поиск термина в списке }
function findInList(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term <> term) do
    terms := terms^.next;
  result := terms;
end;

function findInList(terms: TTermList; term: array of string):TTermList; overload;
var
  i: Integer;
  skip: Boolean;
begin
  i := 0;
  skip := false;
  while (i < length(term) - 1) and not skip do
  begin
    terms := findInList(terms, term[i]);
    if terms^.next <> nil then
      terms := terms^.next^.subterms
    else
      skip := true;
    inc(i);
  end;
  if not skip then
    terms := findInList(terms, term[length(term) - 1]);
  result := terms;
end;

{ Удаление определённого элемента в списке }
procedure deleteInList(terms: TTermList; term: String);
begin
  terms := findInList(terms, term);
  if terms^.next <> nil then
    delete(terms);
end;

{ Перевод массива в список страниц }
function toPages(ar: array of const):TPageList; overload;
var
  i: Integer;
begin
  new(result);
  result^.next := nil;
  for i := 0 to length(ar) - 1 do
    insertInList(result, ar[i].VInteger);
end;

function toPages(ar: TArray):TPageList; overload;
var
  i: Integer;
begin
  new(result);
  result^.next := nil;
  for i := 0 to length(ar) - 1 do
    insertInList(result, ar[i]);
end;

{ Добавление термина или подтермина в список }
procedure insertTerm(terms: TTermList; term: array of String; pages: TPageList);
var
  i: Integer;
  strs: array of String;
begin
  setLength(strs, length(term) - 1);
  for i := 0 to length(strs) - 1 do
    strs[i] := term[i];
  if length(strs) <> 0 then
    terms := findInList(terms, strs);
  if (length(strs) > 0) and (terms^.next <> nil) then
  begin
    terms := terms^.next^.subterms;
    insertInList(terms, toTerm(term[length(term) - 1], pages));
  end
  else
    if length(strs) = 0 then
      insertInList(terms, toTerm(term[length(term) - 1], pages));
end;

{ Удаление термина или подтермина из списка }
procedure deleteTerm(terms: TTermList; term: array of String);
var
  i: Integer;
  strs: array of String;
begin
  setLength(strs, length(term) - 1);
  for i := 0 to length(strs) - 1 do
    strs[i] := term[i]; 
  if length(strs) <> 0 then
    terms := findInList(terms, strs);
  if (length(strs) > 0) and (terms^.next <> nil) then
  begin
    terms := terms^.next^.subterms;
    deleteInList(terms, term[length(term) - 1]);
  end
  else
    if length(strs) = 0 then
      deleteInList(terms, term[length(term) - 1]);
end;

procedure outputTerm(term: TTerm; note: String; outputAll: Boolean); forward;

{ Выводит список терминов }
procedure outputTerms(terms: TTermList; note: String; outputAll: Boolean);
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    outputTerm(terms^, note, outputAll);
  end;
end;

{ Выводит термин }
procedure outputTerm(term: TTerm; note: String; outputAll: Boolean);
begin
  writeln(note, term.term, '  ':13 - length(term.term) - length(note), toString(term.pages));
  if (term.subterms^.next <> nil) and outputAll then
    outputTerms(term.subterms, '-' + note, outputAll);
end;

{ Поиск подтерминов по термину }
procedure lookForTerm(terms: TTermList; term: array of string);
begin
  terms := findInList(terms, term);
  if terms^.next <> nil then
    outputTerm(terms^.next^, '', true)
  else
    writeln('Термин не найден');
end;

{ Поиск терминов по подтермину }
procedure lookForSubterm(terms: TTermList; term: String; res: String);
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    if terms^.term = term then
    begin
      res := res + term;
      writeln(res, '  ':(20 - length(res)), toString(terms^.pages));
    end;
    if terms^.subterms^.next <> nil then
      lookForSubterm(terms^.subterms, term, res + terms^.term + ' ');
  end;
end;

{ Меняет местами два элемента в списке }
procedure swap(terms: TTermList);
var
  temp: TTermList;
begin
  temp := terms^.next;
  terms^.next := temp^.next;
  temp^.next := temp^.next^.next;
  terms^.next^.next := temp;
end;

{ Сортирует список }
procedure checkAndSort(terms: TTermList);
var
  temp: TTermList;
  sorted: Boolean;
begin
  sorted := true;
  temp := terms;
  while (temp^.next <> nil) and (temp^.next^.next <> nil) and sorted do
  begin
    if temp^.next^.term > temp^.next^.next^.term then
      sorted := false;
    temp := temp^.next;
  end;
  while not sorted do
  begin
    temp := terms;
    sorted := true;
    while (temp^.next <> nil) and (temp^.next^.next <> nil) do
    begin
      if temp^.next^.term > temp^.next^.next^.term then
      begin
        sorted := false;
        swap(temp);
      end;
      temp := temp^.next;
    end;
  end;
end;

{ Редактирование термина }
procedure changeTerm(terms: TTermList; term: array of String; old, new: String); overload;
var
  temp: TTermList;
begin
  if length(term) > 0 then
    terms := findInList(terms, term);
  if terms^.next <> nil then
  begin
    if length(term) > 0 then
      temp := findInList(terms^.next^.subterms, old)
    else
      temp := findInList(terms, old);
    if temp^.next <> nil then
    begin
      temp^.next^.term := new;
      checkAndSort(terms);
    end;
  end;
end;

procedure changeTerm(terms: TTermList; term: array of String; old: String; pages: TPageList); overload;
var
  temp: TTermList;
begin    
  if length(term) > 0 then
    terms := findInList(terms, term);
  if terms^.next <> nil then
  begin
    if length(term) > 0 then
      temp := findInList(terms^.next^.subterms, old)
    else
      temp := findInList(terms, old);
    if temp^.next <> nil then
    begin
      clearList(temp^.next^.pages);
      dispose(temp^.next^.pages);
      temp^.next^.pages := pages;
    end;
  end;
end;

procedure changeTerm(terms: TTermList; term: array of String; old, new: String; pages: TPageList); overload;
var
  temp: TTermList;
begin   
  if length(term) > 0 then
    terms := findInList(terms, term);
  if terms^.next <> nil then
  begin
    if length(term) > 0 then
      temp := findInList(terms^.next^.subterms, old)
    else
      temp := findInList(terms, old);
    if temp^.next <> nil then
    begin
      clearList(temp^.next^.pages);
      dispose(temp^.next^.pages);
      temp^.next^.pages := pages;
      temp^.next^.term := new;
      checkAndSort(terms);
    end;
  end;
end;

{ Создание вершин списков }
procedure createDict(var dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to length(dict) do
    new(dict[i]);
end;

{ Добавление элемента в словарь }
procedure insertInDict(dict: TDictionary; term: array of string; pages: TPageList);
begin             
  if length(term) > 0 then
    insertTerm(dict[hashFunc(term[0])], term, pages);
end;

{ Удаление элемента из словаря }
procedure deleteInDict(dict: TDictionary; term: array of string);
begin               
  if length(term) > 0 then
    deleteTerm(dict[hashFunc(term[0])], term);
end;

{ Просмотр словаря }
procedure outputDict(dict: TDictionary; outputAll: Boolean);
var
  i: Integer;
begin
  for i := 0 to N - 1 do
    outputTerms(dict[i], '', outputAll);
end;

{ Поиск термина в словаре }
procedure lookForTermInDict(dict: TDictionary; term: array of string);
begin
  if length(term) > 0 then
    lookForTerm(dict[hashFunc(term[0])], term);
end;

{ Поиск подтермина в словаре }
procedure lookForSubtermInDict(dict: TDictionary; term: String);
var
  i: Integer;
begin
  for i := 0 to N - 1 do
  begin
    lookForSubterm(dict[i], term, '');
  end;
end;

{ Перенос термина между классами таблицы }
procedure changeHashCol(dict: TDictionary; term: array of String; old, new: String); overload;
var
  temp, terms: TTermList;
begin
  if length(term) > 0 then
    terms := dict[hashFunc(term[0])]
  else
    terms := dict[hashFunc(old)];
  if length(term) > 0 then
    terms := findInList(terms, term);
  if terms^.next <> nil then
  begin
    if length(term) > 0 then
      temp := findInList(terms^.next^.subterms, old)
    else
      temp := findInList(terms, old);
    if temp^.next <> nil then
    begin
      terms := temp;
      temp := temp^.next;
      terms^.next := temp^.next;
      temp^.next := nil;
      temp^.term := new;
      insertInList(dict[hashFunc(new)], temp^);
    end;
  end;
end;

procedure changeHashCol(dict: TDictionary; term: array of String; old, new: String; pages: TPageList); overload;
var
  temp, terms: TTermList;
begin
  if length(term) > 0 then
    terms := dict[hashFunc(term[0])]
  else
    terms := dict[hashFunc(old)];
  if length(term) > 0 then
    terms := findInList(terms, term);
  if terms^.next <> nil then
  begin
    if length(term) > 0 then
      temp := findInList(terms^.next^.subterms, old)
    else
      temp := findInList(terms, old);
    if temp^.next <> nil then
    begin
      terms := temp;
      temp := temp^.next;
      terms^.next := temp^.next;
      temp^.next := nil;
      temp^.term := new;   
      clearList(temp^.pages);
      dispose(temp^.pages);
      temp^.pages := pages;
      insertInList(dict[hashFunc(new)], temp^);
    end;
  end;
end;

{ Редактирование термина в словаре}
procedure changeTermInDict(dict: TDictionary; term: array of String; old, new: String); overload;
begin
  if length(term) > 0 then     
    changeTerm(dict[hashFunc(term[0])], term, old, new)
  else
  begin
    if old[1] = new[1] then  
      changeTerm(dict[hashFunc(old)], term, old, new)
    else
      changeHashCol(dict, term, old, new);
  end;
end;

procedure changeTermInDict(dict: TDictionary; term: array of String; old: String; pages: TPageList); overload;
begin
  if length(term) > 0 then
    changeTerm(dict[hashFunc(term[0])], term, old, pages)
  else
    changeTerm(dict[hashFunc(old)], term, old, pages);
end;

procedure changeTermInDict(dict: TDictionary; term: array of String; old, new: String; pages: TPageList); overload;
begin
  if length(term) > 0 then
    changeTerm(dict[hashFunc(term[0])], term, old, new, pages)
  else
  begin        
    if old[1] = new[1] then
      changeTerm(dict[hashFunc(old)], term, old, new, pages)
    else   
      changeHashCol(dict, term, old, new, pages);
  end;
end;

{ Удаление списков }
procedure deleteDict(var dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to length(dict) - 1 do
  begin
    clearList(dict[i]);
    dispose(dict[i]);
  end;
end;

procedure defaultInput(dict: TDictionary);
begin
  insertInDict(dict, ['Человек'], toPages([1, 7]));
  insertInDict(dict, ['Собака'],  toPages([5, 7]));
  insertInDict(dict, ['Азбука'],  toPages([3, 12]));
  insertInDict(dict, ['Азбука', 'Большая'],  toPages([3, 12]));
  //insertInDict(dict, ['Алфавит'],  toPages([1, 12]));
  //insertInDict(dict, ['Арбуз'],  toPages([1, 12]));
  insertInDict(dict, ['Яблоко'],  toPages([11, 1, 16]));
  insertInDict(dict, ['Яблоко', 'Зелёное'],             toPages([12, 16]));
  insertInDict(dict, ['Яблоко', 'Зелёное', 'Кислое'],   toPages([16]));
  insertInDict(dict, ['Яблоко', 'Зелёное', 'Красивое'], toPages([16]));
  insertInDict(dict, ['Яблоко', 'Красное'],             toPages([11]));
  insertInDict(dict, ['Яблоко', 'Красное', 'Червивое'], toPages([12]));
  insertInDict(dict, ['Яблоко', 'Красное', 'Вкусное'],  toPages([12]));
  insertInDict(dict, ['Яблоко', 'Красное', 'Красивое'], toPages([12]));
end;

procedure defaultTest(dict: TDictionary);
begin
  writeln('Исходный список терминов: ');
  outputDict(dict, true);
  writeln;

  writeln('Замена термина Азбука на Ябеда: ');
  changeTermInDict(dict, [], 'Азбука', 'Ябеда');
  outputDict(dict, false);
  writeln;

  writeln('Поиск и вывод подтермина Зелёное у Яблоко');
  lookForTermInDict(dict, ['Яблоко', 'Зелёное']);
  writeln;

  writeln('Удаление подтермина Вкусное у Яблоко Красное');
  deleteInDict(dict, ['Яблоко', 'Красное', 'Вкусное']);
  lookForTermInDict(dict, ['Яблоко']);
  writeln;
                               
  writeln('Замена подтермина Красное у Яблоко на Желтое со страницами 1 и 2');
  changeTermInDict(dict, ['Яблоко'], 'Красное', 'Желтое', toPages([1, 2]));
  lookForTermInDict(dict, ['Яблоко']);
  writeln;

  writeln('Поиск подтермина Красивое и вывод терминов, где он встречется');
  lookForSubtermInDict(dict, 'Красивое');
end;

{ Вывод пунктов меню UI }
procedure outputHelp();
begin
  writeln;
  writeln('':10, '1. Просмотр');
  writeln('':10, '2. Добавление');
  writeln('':10, '3. Удаление');
  writeln('':10, '4. Редактирование');
  writeln('':10, '5. Поиск');
  writeln('':10, '6. Помощь');
  writeln('':10, '7. Выход');
end;

{ Запрашивает ввод числа в промежутке }
function readIn(note: String; low, high: Integer):Integer; overload;
var
  str: String;
  err: Integer;
begin
  writeln;
  repeat
    write(note);
    readln(str);
    val(str, result, err);
  until (result >= low) and (result <= high) and (err = 0);
end;

{ Запрашивает ввод строки }
function readIn(note: String):String; overload;
begin
  write(note);
  readln(result);
end;

{ Разбивает строку на массив строк }
function strToArray(str: String):TTerms;
var
  i, k: Integer;
begin
  i := 1;
  k := 1;
  setLength(result, k);
  result[k - 1] := '';
  while i <= length(str) do
  begin
    if str[i] = ',' then
    begin
      inc(k);
      setLength(result, k);
      result[k - 1] := '';
      repeat
        inc(i);
      until str[i] <> ' ';
    end;
    result[k - 1] := result[k - 1] + str[i];
    inc(i);
  end;
end;

{ Переводит строку в массив чисел }
function readInArray(note: String):TArray;
var
  i, j, k, err, res: Integer;
  str: String;
begin
  write(note);
  readln(str);
  i := 1;
  j := 1;
  k := 1;
  while i <= length(str) do
  begin
    setLength(result, k);
    while (j <= length(str)) and (str[j] <> ',') do
      inc(j);
    val(copy(str, i, j - i), res, err);
    if err = 0 then
    begin
      result[k - 1] := res;
      inc(k);
    end;
    i := j + 1;
    while (i <= length(str)) and (str[i] = ' ') do
      inc(i);
    j := i;
  end;
end;

{ Реализация UI }
procedure userInterface(dict: TDictionary);
var
  exit: Boolean;
  term, new: String;
  subterm: TTerms;
  pages: TArray;
  page: Integer;
begin
  exit := false;
  setLength(pages, 0);
  outputHelp;
  repeat
    case readIn('Выберите пункт меню: ', 1, 7) of
      1:
      begin
        writeln;
        writeln('':15, '1. Без подтерминов');
        writeln('':15, '2. С подтерминами');
        case readIn('Выберите пункт подменю: ', 1, 2) of
          1:
          begin
            writeln;
            outputDict(dict, false);
          end;
          2:
          begin
            writeln;
            outputDict(dict, true);
          end;
        end;
      end;
      2:
      begin
        writeln;
        term := readIn('Введите термин, который хотите добавить, или термин и подтермины через запятую: ');
        writeln;
        pages := readInArray('Введите страницы термина через запятую: ');
        insertInDict(dict, strToArray(term), toPages(pages));
      end;
      3:
      begin
        writeln;
        term := readIn('Введите термин, который хотите удалить, или термин и подтермины через запятую: ');
        deleteInDict(dict, strToArray(term));
      end;
      4:
      begin
        writeln;
        writeln('':15, '1. Названия');
        writeln('':15, '2. Страниц');
        writeln('':15, '3. Названия и страниц');
        case readIn('Выберите пункт подменю: ', 1, 3) of
          1:
          begin
            writeln;
            term := readIn('Введите термин для редактирования: ');
            writeln;
            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            new := readIn('Введите новое название термина: ');

            changeTermInDict(dict, subterm, term, new);
          end;
          2:
          begin
            writeln;
            term := readIn('Введите термин для редактирования: ');
            writeln;

            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            pages := readInArray('Введите новые страницы термина через запятую: ');

            changeTermInDict(dict, subterm, term, toPages(pages));
          end;
          3:
          begin
            writeln;
            term := readIn('Введите термин для редактирования: ');
            writeln;

            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            new := readIn('Введите новое название термина: ');
            writeln;

            pages := readInArray('Введите новые страницы термина новые страницы термина через запятую: ');

            changeTermInDict(dict, subterm, term, new, toPages(pages));
          end;
        end;
      end;
      5:
      begin
        writeln;
        writeln('':15, '1. Терминов по подтермину');
        writeln('':15, '2. Подтерминов по термину');
        case readIn('Выберите пункт подменю: ', 1, 2) of
          1:
          begin
            writeln;
            term := readIn('Введите подтермин: ');
            writeln;
            lookForSubtermInDict(dict, term);
          end;
          2:
          begin
            writeln;
            term := readIn('Введите термин или термин с подтерминами через запятую: ');
            writeln;
            lookForTermInDict(dict, strToArray(term));
          end;
        end;
      end;
      6:
        outputHelp;
      7:
        exit := true;
    end;
  until exit;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  createDict(dict);

  defaultInput(dict);
  //defaultTest(dict);
  userInterface(dict);

  deleteDict(dict);
end.
