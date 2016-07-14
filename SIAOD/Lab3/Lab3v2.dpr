program Lab3v2;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

type
  TTerms = array of String;
  TArray = array of Integer;
  TTermList = ^TTerm;
  TPageList = ^TPage;
  TTerm = record
    term: String;
    subterms: TTermList;
    pages: TPageList;
    next: TTermList;
  end;                  
  TPage = record
    num: Integer;
    next: TPageList;                  
  end;

  TTermArray = array of TTermList;
  TLinkList = ^TLinkPage;
  TLinkPage = record
    num: Integer;
    links: TTermArray;
    next: TLinkList;
  end;

var
  terms: TTermList;
  links: TLinkList;

{ Преобразует строку и список страниц в запись TTerm }
function getTerm(term: String; pages: TPageList):TTerm;
begin
  result.term := term;
  result.pages := pages;
  result.next := nil;
  new(result.subterms);
  result.subterms^.next := nil;
end;

{ Переводит список страниц в строку }
function pagesToStr(list: TPageList):String;
begin
  result := '';
  while list^.next <> nil do
  begin
    list := list^.next;
    result := result + IntToStr(list^.num);
    if list^.next <> nil then
      result := result + ', ';
  end;
end;
     
{ Добавляет в список страниц номер отдельной страницы }
procedure insert(pages: TPageList; value: Integer); overload;
var
  temp: TPageList;
begin
  new(temp);
  temp^.num := value;
  while (pages^.next <> nil) and (pages^.next^.num < value) do
    pages := pages^.next;
  temp^.next := pages^.next;
  pages^.next := temp;
end;
            
{ Добавляет в список терминов запись TTerm }
procedure insert(terms: TTermList; term: TTerm); overload;
var
  temp: TTermList;
begin
  new(temp);
  temp^ := term;
  temp^.next := terms^.next;
  terms^.next := temp;
end;
          
{ Добавляет в список страниц с ссылками страницу }
procedure insert(links: TLinkList; linkPage: TTermArray; num: Integer); overload;
var
  temp: TLinkList;
begin
  new(temp);
  temp^.links := linkPage;
  temp^.num := num;
  temp^.next := links^.next;
  links^.next := temp;
end;

procedure delete(terms: TTermList); forward;
      
{ Очищает список терминов }
procedure clearList(terms: TTermList); overload;
begin
  while terms^.next <> nil do
    delete(terms);
end;
             
{ Удаляет страницу из списка страниц }
procedure deletePage(pages: TPageList);
var
  temp: TPageList;
begin
  temp := pages^.next;
  pages^.next := temp^.next;
  dispose(temp);
end;
         
{ Очищает список страниц }
procedure clearList(pages: TPageList); overload;
begin
  while pages^.next <> nil do
    deletePage(pages);
end;
       
{ Удаляет страницу из списка страниц с ссылками }
procedure deleteLink(links: TLinkList);
var
  temp: TLinkList;
begin
  temp := links^.next;
  links^.next := temp^.next;
  dispose(temp);
end;
        
{ Очищает список страниц с ссылками }
procedure clearList(links: TLinkList); overload;
begin
  while links^.next <> nil do
    deleteLink(links);
end;
       
{ Удаляет элемент из списка терминов, очищает также списки подтерминов и списки страниц }
procedure delete(terms: TTermList);
var
  temp: TTermList;
begin
  if terms^.next <> nil then
  begin
    temp := terms^.next;
    terms^.next := temp^.next;
    if temp^.subterms^.next <> nil then
      clearList(temp^.subterms);
    clearList(temp^.pages);
    dispose(temp^.pages);
    dispose(temp^.subterms);
    dispose(temp);
  end;
end;

function convert(ar: array of const):TArray;
var
  i: Integer;
begin
  setLength(result, length(ar));
  for i := 0 to length(ar) do
    result[i] := ar[i].VInteger;
end;

{ Преобразует массив номеров страниц в список страниц }
function getPageList(ar: TArray):TPageList;
var
  i: integer;
begin
  new(result);
  result^.next := nil;
  for i := length(ar) - 1 downto 0 do
    insert(result, ar[i]);
end;
      
{ Находит позицию для добавления термина в список терминов, без потери упорядоченности }
function findPos(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term < term) do
    terms := terms^.next;
  result := terms;
end;
       
{ Находит и возвращает термин из списка терминов }
function findTerm(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term <> term) do
    terms := terms^.next;
  result := terms;
end;
       
{ Находит и возвращает термин (подтермин) из списка терминов }
function findTerm(terms: TTermList; term: array of String):TTermList; overload;
var
  temp: TTermList;
  i: Integer;
begin
  temp := terms;
  i := 0;
  while i < length(term) do
  begin
    temp := findTerm(temp, term[i]);
    if temp^.next <> nil then
      temp := temp^.next^.subterms;
    inc(i);
  end;
  result := temp;
end;
      
{ Добавляет термин (подтермин) в список терминов }
procedure insertTerm(terms: TTermList; term: array of String; pages: TArray);
var
  temp: TTermList;
  i: Integer;
  skip: Boolean;
begin
  temp := terms;
  i := 0;
  skip := false;
  while (i < length(term) - 1) and not skip do
  begin
    temp := findTerm(temp, term[i]);
    if temp^.next <> nil then
      temp := temp^.next^.subterms
    else
      skip := true;
    inc(i);
  end;
  if not skip then
    insert(findPos(temp, term[length(term) - 1]), getTerm(term[length(term) - 1], getPageList(pages)));
end;
      
{ Удаляет термин (подтермин) из списка терминов }
procedure deleteTerm(terms: TTermList; term: array of String);
var
  temp: TTermList;
  i: Integer;
begin
  temp := terms;
  i := 0;
  while i < length(term) - 1 do
  begin
    temp := findTerm(temp, term[i]);
    if temp^.next <> nil then
      temp := temp^.next^.subterms;
    inc(i);
  end;
  delete(findTerm(temp, term[length(term) - 1]));
end;

procedure outputTerms(terms: TTermList; note: String; outputAll: Boolean); forward;
    
{ Выводит запись TTerm и все подтремины }
procedure outputTerm(term: TTerm; note: String; outputAll: Boolean);
begin
  writeln(note, term.term, '  ':13 - length(term.term) - length(note), pagesToStr(term.pages));
  if (term.subterms^.next <> nil) and (outputAll) then
  begin
    outputTerms(term.subterms, '-' + note, outputAll);
  end;
end;
    
{ Выводит список терминов }
procedure outputTerms(terms: TTermList; note: String; outputAll: Boolean);
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    outputTerm(terms^, note, outputAll);
  end;
end;
    
{ Находит и выводит термин }
procedure findAndOutputTerm(terms: TTermList; term: array of String);
var
  temp: TTermList;
  i: Integer;
begin
  i := 0;
  temp := terms;
  while i < length(term) - 1 do
  begin
    temp := findTerm(temp, term[i]);
    if temp^.next <> nil then
      temp := temp^.next^.subterms;
    inc(i);
  end;
  temp := findTerm(temp, term[length(term) - 1]);
  if temp^.next <> nil then
    outputTerm(temp^.next^, '', true);
end;
          
{ Меняет местами 2 термина в списке терминов }
procedure swap(terms: TTermList);
var
  temp: TTermList;
begin
  temp := terms^.next;
  terms^.next := temp^.next;
  temp^.next := temp^.next^.next;
  terms^.next^.next := temp;
end;
    
{ Проверяет на упорядоченность и сортирует список терминов }
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
          
{ Изменяет термин (подтермин), заменяет название }
procedure changeTerm(terms: TTermList; term: array of String; old, new: String); overload;
var
  temp: TTermList;
begin
  temp := findTerm(terms, term);
  temp := findTerm(temp, old);
  if temp^.next <> nil then
  begin
    temp^.next^.term := new;
    checkAndSort(terms);
  end;
end;
        
{ Изменяет термин (подтермин), заменяет номера страниц }
procedure changeTerm(terms: TTermList; term: array of String; old: String; pages: TArray); overload;
var
  temp: TTermList;
begin
  temp := findTerm(terms, term);
  temp := findTerm(temp, old);
  if temp^.next <> nil then
  begin
    clearList(temp^.next^.pages);
    dispose(temp^.next^.pages);
    temp^.next^.pages := getPageList(pages);
  end;
end;
         
{ Изменяет термин (подтермин), заменяет название и номера страниц }
procedure changeTerm(terms: TTermList; term: array of String; old, new: String; pages: TArray); overload;
var
  temp: TTermList;
begin
  terms := findTerm(terms, term);
  temp := findTerm(terms, old);
  if temp^.next <> nil then
  begin
    temp^.next^.term := new;
    clearList(temp^.next^.pages);
    dispose(temp^.next^.pages);
    temp^.next^.pages := getPageList(pages); 
    checkAndSort(terms);
  end;
end;

{ Проверяет наличие страницы в списке страниц }
function inList(pages: TPageList; page: Integer):Boolean;
begin
  result := false;
  while pages^.next <> nil do
  begin
    pages := pages^.next;
    if pages^.num = page then
      result := true;
  end;
end;
       
{ Находит и выводит подтермин (термин), во всех терминах }
procedure findSubterm(terms: TTermList; subterm: String; res: String); overload;
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    if terms^.term = subterm then
    begin
      res := res + subterm;
      writeln(res, '  ':(20 - length(res)), pagesToStr(terms^.pages));
    end;
    if terms^.subterms^.next <> nil then
      findSubterm(terms^.subterms, subterm, res + terms^.term + ' ');
  end;
end;

{ Находит и выводит подтермин (термин), учитывая номер страницы }
procedure findSubterm(terms: TTermList; subterm: String; page: Integer; res: String); overload;
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    if (terms^.term = subterm) and (inList(terms^.pages, page)) then
    begin
      res := res + subterm;
      writeln(res);
    end;
    if terms^.subterms^.next <> nil then
      findSubterm(terms^.subterms, subterm, page, res + terms^.term + ' ');
  end;
end;
              
{ Возвращает указатель на страницу списка страниц с ссылками }
function findLink(links: TLinkList; num: Integer):TLinkList;
begin
  while (links^.next <> nil) and (links^.next^.num <> num) do
    links := links^.next;
  result := links;
end;
         
{ Находит позицию для добавления страницы в список страниц с ссылками }
function findPos(links: TLinkList; num: Integer):TLinkList; overload;
begin
  while (links^.next <> nil) and (links^.next^.num < num) do
    links := links^.next;
  result := links;
end;
        
{ Анализирует список терминов и составляет список страниц с ссылками }
procedure sortByPages(terms: TTermList; links: TLinkList; processAll: Boolean);
var
  pages: TPageList;
  link: TLinkList;
  ar: TTermArray;
  missed: Boolean;
  i: Integer;
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    pages := terms^.pages;
    while pages^.next <> nil do
    begin
      pages := pages^.next;
      link := findLink(links, pages^.num);
      if link^.next = nil then
      begin
        setLength(ar, 0);
        insert(findPos(links, pages^.num), ar, pages^.num);
        link := findLink(links, pages^.num);
      end;
      ar := link^.next^.links;
      missed := true;
      for i := 0 to length(ar) - 1 do
        if ar[i]^.term = terms^.term then
          missed := false;
      if missed then
      begin
        setLength(ar, length(ar) + 1);
        ar[length(ar) - 1] := terms;
      end;
      link^.next^.links := ar;
    end;
    if (terms^.subterms^.next <> nil) and processAll then
      sortByPages(terms^.subterms, links, processAll);
  end;
end;

procedure clearAndSort(terms: TTermList; links: TLinkList; processAll: Boolean);
begin
  clearList(links);
  sortByPages(terms, links, processAll);
end;
      
{ Возвращает номера страниц, содержащих термины }
procedure outputPages(links: TLinkList);
begin
  write('Страницы с терминами: ');
  while links^.next <> nil do
  begin
    links := links^.next;
    write(links^.num, ' ');
  end;
  writeln;
end;
     
{ Выводит сортированный по номерам страниц список терминов }
procedure outputLinkPages(terms: TTermList; links: TLinkList);
var
  i: Integer;
begin
  while links^.next <> nil do
  begin
    links := links^.next;
    writeln('Страница ', links^.num, ': ');
    for i := 0 to length(links^.links) - 1 do
    begin
      findSubterm(terms, links^.links[i]^.term, links^.num, ' ');
    end;
    if links^.next <> nil then
      writeln;
  end;
end;

{ Выводит термин и подтремины на заданной странице }
procedure outputLinkPage(terms: TTermList; links: TLinkList; page: Integer);
var
  i: Integer;
begin
  while (links^.next <> nil) and (links^.num <> page) do
    links := links^.next;
  if links^.next <> nil then
  begin
    for i := 0 to length(links^.links) - 1 do
      findSubterm(terms, links^.links[i]^.term, links^.num, ' ');
  end;
end;
    
{ Создаёт список терминов }
procedure createTermList(var terms: TTermList);
begin
  new(terms);
end;
         
{ Удаляет список терминов }
procedure deleteTermList(var terms: TTermList);
begin
  clearList(terms);
  dispose(terms);
  terms := nil;
end;
      
{ Создаёт список страниц с ссылками }
procedure createLinkList(var links: TLinkList);
begin
  new(links);
  links^.next := nil;
end;
          
{ Удаляет список страниц с ссылками }
procedure deleteLinkList(var links: TLinkList);
begin
  clearList(links);
  dispose(links);
  links := nil;
end;

{ Заполняет список терминов для демонстрации }
procedure inputDefault(terms: TTermList);
begin
  insertTerm(terms, ['Человек'], convert([1, 7]));
  insertTerm(terms, ['Собака'],  convert([5, 7]));
  insertTerm(terms, ['Азбука'],  convert([3, 12]));
  insertTerm(terms, ['Яблоко'],  convert([11, 1, 16]));
  insertTerm(terms, ['Яблоко', 'Зелёное'],             convert([12, 16]));
  insertTerm(terms, ['Яблоко', 'Зелёное', 'Кислое'],   convert([16]));
  insertTerm(terms, ['Яблоко', 'Зелёное', 'Красивое'], convert([16]));
  insertTerm(terms, ['Яблоко', 'Красное'],             convert([11]));
  insertTerm(terms, ['Яблоко', 'Красное', 'Червивое'], convert([12]));
  insertTerm(terms, ['Яблоко', 'Красное', 'Вкусное'],  convert([12]));
  insertTerm(terms, ['Яблоко', 'Красное', 'Красивое'], convert([12]));
end;       

{ Вызывает процедуры для демонстрации }
procedure defaultTest(terms: TTermList;  var links: TLinkList);
begin
  writeln('Исходный список терминов: ');
  outputTerms(terms, '', true);
  writeln;

  writeln('Замена термина Азбука на Ябеда: ');
  changeTerm(terms, [], 'Азбука', 'Ябеда');
  outputTerms(terms, '', false);
  writeln;

  writeln('Поиск и вывод подтермина Зелёное у Яблоко');
  findAndOutputTerm(terms, ['Яблоко', 'Зелёное']);
  writeln;

  writeln('Удаление подтермина Вкусное у Яблоко Красное');
  deleteTerm(terms, ['Яблоко', 'Красное', 'Вкусное']);
  findAndOutputTerm(terms, ['Яблоко']);
  writeln;
                               
  writeln('Замена подтермина Красное у Яблоко на Желтое со страницами 1 и 2');
  changeTerm(terms, ['Яблоко'], 'Красное', 'Желтое', convert([1, 2]));
  findAndOutputTerm(terms, ['Яблоко']);
  writeln;

  writeln('Поиск подтермина Красивое и вывод терминов, где он встречется');
  findSubterm(terms, 'Красивое', '');
  writeln;
                         

  { Создаёт список, отсортированный по страницам,
    true - включает все подтермины, false - включает только термины }
  clearAndSort(terms, links, true);

  outputPages(links);
  writeln;

  writeln('Вывод терминов и подтерминов, отсортированных по страницам');
  outputLinkPages(terms, links);

  writeln('Вывод терминов и подтерминов на определённой странице');
  outputLinkPage(terms, links, 12);
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
  writeln('':10, '6. Сортировка по номерам страниц');
  writeln('':10, '7. Помощь');
  writeln('':10, '8. Выход');
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
procedure userInterface(var terms: TTermList; var links: TLinkList);
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
    case readIn('Выберите пункт меню: ', 1, 8) of
      1:
      begin
        writeln;
        writeln('':15, '1. Без подтерминов');
        writeln('':15, '2. С подтерминами');
        case readIn('Выберите пункт подменю: ', 1, 2) of
          1:
          begin
            writeln;
            outputTerms(terms, '', false);
          end;
          2:
          begin
            writeln;
            outputTerms(terms, '', true);
          end;
        end;
      end;
      2:
      begin
        writeln;
        term := readIn('Введите термин, который хотите добавить, или термин и подтермины через запятую: ');
        writeln;
        pages := readInArray('Введите страницы термина через запятую: ');
        insertTerm(terms, strToArray(term), pages);
      end;
      3:
      begin
        writeln;
        term := readIn('Введите термин, который хотите удалить, или термин и подтермины через запятую: ');
        deleteTerm(terms, strToArray(term));
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

            changeTerm(terms, subterm, term, new);
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

            changeTerm(terms, subterm, term, pages);
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

            changeTerm(terms, subterm, term, new, pages);
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
            findSubterm(terms, term, '');
          end;
          2:
          begin
            writeln;
            term := readIn('Введите термин или термин с подтерминами через запятую: ');
            writeln;
            findAndOutputTerm(terms, strToArray(term));
          end;
        end;
      end;
      6:
      begin
        writeln;
        writeln('':15, '1. Термины');
        writeln('':15, '2. Термины и подтермины');
        case readIn('Введите пункт подменю: ', 1, 2) of
          1:
            clearAndSort(terms, links, false);
          2:
            clearAndSort(terms, links, true);
        end;
        writeln;
        writeln('':20, '1. Вывести заполненные страницы');
        writeln('':20, '2. Вывести термины постранично');
        writeln('':20, '3. Вывести термины на странице');
        case readIn('Введите пункт подменю: ', 1, 3) of
          1:
          begin
            writeln;
            outputPages(links);
          end;
          2:
          begin
            writeln;
            outputLinkPages(terms, links);
          end;
          3:                         
          begin
            writeln;
            write('Введите номер страницы: ');
            readln(page);
            outputLinkPage(terms, links, page);
          end;
        end;
      end;
      7:
        outputHelp;
      8:
        exit := true;
    end;
  until exit;
end;

begin
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  createTermList(terms);
  createLinkList(links);

  inputDefault(terms);
  
  {defaultTest(terms, links);}  

  userInterface(terms, links);


  deleteLinkList(links);
  deleteTermList(terms);
end.
