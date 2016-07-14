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

{ ����������� ������ � ������ ������� � ������ TTerm }
function getTerm(term: String; pages: TPageList):TTerm;
begin
  result.term := term;
  result.pages := pages;
  result.next := nil;
  new(result.subterms);
  result.subterms^.next := nil;
end;

{ ��������� ������ ������� � ������ }
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
     
{ ��������� � ������ ������� ����� ��������� �������� }
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
            
{ ��������� � ������ �������� ������ TTerm }
procedure insert(terms: TTermList; term: TTerm); overload;
var
  temp: TTermList;
begin
  new(temp);
  temp^ := term;
  temp^.next := terms^.next;
  terms^.next := temp;
end;
          
{ ��������� � ������ ������� � �������� �������� }
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
      
{ ������� ������ �������� }
procedure clearList(terms: TTermList); overload;
begin
  while terms^.next <> nil do
    delete(terms);
end;
             
{ ������� �������� �� ������ ������� }
procedure deletePage(pages: TPageList);
var
  temp: TPageList;
begin
  temp := pages^.next;
  pages^.next := temp^.next;
  dispose(temp);
end;
         
{ ������� ������ ������� }
procedure clearList(pages: TPageList); overload;
begin
  while pages^.next <> nil do
    deletePage(pages);
end;
       
{ ������� �������� �� ������ ������� � �������� }
procedure deleteLink(links: TLinkList);
var
  temp: TLinkList;
begin
  temp := links^.next;
  links^.next := temp^.next;
  dispose(temp);
end;
        
{ ������� ������ ������� � �������� }
procedure clearList(links: TLinkList); overload;
begin
  while links^.next <> nil do
    deleteLink(links);
end;
       
{ ������� ������� �� ������ ��������, ������� ����� ������ ����������� � ������ ������� }
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

{ ����������� ������ ������� ������� � ������ ������� }
function getPageList(ar: TArray):TPageList;
var
  i: integer;
begin
  new(result);
  result^.next := nil;
  for i := length(ar) - 1 downto 0 do
    insert(result, ar[i]);
end;
      
{ ������� ������� ��� ���������� ������� � ������ ��������, ��� ������ ��������������� }
function findPos(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term < term) do
    terms := terms^.next;
  result := terms;
end;
       
{ ������� � ���������� ������ �� ������ �������� }
function findTerm(terms: TTermList; term: String):TTermList; overload;
begin
  while (terms^.next <> nil) and (terms^.next^.term <> term) do
    terms := terms^.next;
  result := terms;
end;
       
{ ������� � ���������� ������ (���������) �� ������ �������� }
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
      
{ ��������� ������ (���������) � ������ �������� }
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
      
{ ������� ������ (���������) �� ������ �������� }
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
    
{ ������� ������ TTerm � ��� ���������� }
procedure outputTerm(term: TTerm; note: String; outputAll: Boolean);
begin
  writeln(note, term.term, '  ':13 - length(term.term) - length(note), pagesToStr(term.pages));
  if (term.subterms^.next <> nil) and (outputAll) then
  begin
    outputTerms(term.subterms, '-' + note, outputAll);
  end;
end;
    
{ ������� ������ �������� }
procedure outputTerms(terms: TTermList; note: String; outputAll: Boolean);
begin
  while terms^.next <> nil do
  begin
    terms := terms^.next;
    outputTerm(terms^, note, outputAll);
  end;
end;
    
{ ������� � ������� ������ }
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
          
{ ������ ������� 2 ������� � ������ �������� }
procedure swap(terms: TTermList);
var
  temp: TTermList;
begin
  temp := terms^.next;
  terms^.next := temp^.next;
  temp^.next := temp^.next^.next;
  terms^.next^.next := temp;
end;
    
{ ��������� �� ��������������� � ��������� ������ �������� }
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
          
{ �������� ������ (���������), �������� �������� }
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
        
{ �������� ������ (���������), �������� ������ ������� }
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
         
{ �������� ������ (���������), �������� �������� � ������ ������� }
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

{ ��������� ������� �������� � ������ ������� }
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
       
{ ������� � ������� ��������� (������), �� ���� �������� }
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

{ ������� � ������� ��������� (������), �������� ����� �������� }
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
              
{ ���������� ��������� �� �������� ������ ������� � �������� }
function findLink(links: TLinkList; num: Integer):TLinkList;
begin
  while (links^.next <> nil) and (links^.next^.num <> num) do
    links := links^.next;
  result := links;
end;
         
{ ������� ������� ��� ���������� �������� � ������ ������� � �������� }
function findPos(links: TLinkList; num: Integer):TLinkList; overload;
begin
  while (links^.next <> nil) and (links^.next^.num < num) do
    links := links^.next;
  result := links;
end;
        
{ ����������� ������ �������� � ���������� ������ ������� � �������� }
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
      
{ ���������� ������ �������, ���������� ������� }
procedure outputPages(links: TLinkList);
begin
  write('�������� � ���������: ');
  while links^.next <> nil do
  begin
    links := links^.next;
    write(links^.num, ' ');
  end;
  writeln;
end;
     
{ ������� ������������� �� ������� ������� ������ �������� }
procedure outputLinkPages(terms: TTermList; links: TLinkList);
var
  i: Integer;
begin
  while links^.next <> nil do
  begin
    links := links^.next;
    writeln('�������� ', links^.num, ': ');
    for i := 0 to length(links^.links) - 1 do
    begin
      findSubterm(terms, links^.links[i]^.term, links^.num, ' ');
    end;
    if links^.next <> nil then
      writeln;
  end;
end;

{ ������� ������ � ���������� �� �������� �������� }
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
    
{ ������ ������ �������� }
procedure createTermList(var terms: TTermList);
begin
  new(terms);
end;
         
{ ������� ������ �������� }
procedure deleteTermList(var terms: TTermList);
begin
  clearList(terms);
  dispose(terms);
  terms := nil;
end;
      
{ ������ ������ ������� � �������� }
procedure createLinkList(var links: TLinkList);
begin
  new(links);
  links^.next := nil;
end;
          
{ ������� ������ ������� � �������� }
procedure deleteLinkList(var links: TLinkList);
begin
  clearList(links);
  dispose(links);
  links := nil;
end;

{ ��������� ������ �������� ��� ������������ }
procedure inputDefault(terms: TTermList);
begin
  insertTerm(terms, ['�������'], convert([1, 7]));
  insertTerm(terms, ['������'],  convert([5, 7]));
  insertTerm(terms, ['������'],  convert([3, 12]));
  insertTerm(terms, ['������'],  convert([11, 1, 16]));
  insertTerm(terms, ['������', '������'],             convert([12, 16]));
  insertTerm(terms, ['������', '������', '������'],   convert([16]));
  insertTerm(terms, ['������', '������', '��������'], convert([16]));
  insertTerm(terms, ['������', '�������'],             convert([11]));
  insertTerm(terms, ['������', '�������', '��������'], convert([12]));
  insertTerm(terms, ['������', '�������', '�������'],  convert([12]));
  insertTerm(terms, ['������', '�������', '��������'], convert([12]));
end;       

{ �������� ��������� ��� ������������ }
procedure defaultTest(terms: TTermList;  var links: TLinkList);
begin
  writeln('�������� ������ ��������: ');
  outputTerms(terms, '', true);
  writeln;

  writeln('������ ������� ������ �� �����: ');
  changeTerm(terms, [], '������', '�����');
  outputTerms(terms, '', false);
  writeln;

  writeln('����� � ����� ���������� ������ � ������');
  findAndOutputTerm(terms, ['������', '������']);
  writeln;

  writeln('�������� ���������� ������� � ������ �������');
  deleteTerm(terms, ['������', '�������', '�������']);
  findAndOutputTerm(terms, ['������']);
  writeln;
                               
  writeln('������ ���������� ������� � ������ �� ������ �� ���������� 1 � 2');
  changeTerm(terms, ['������'], '�������', '������', convert([1, 2]));
  findAndOutputTerm(terms, ['������']);
  writeln;

  writeln('����� ���������� �������� � ����� ��������, ��� �� ����������');
  findSubterm(terms, '��������', '');
  writeln;
                         

  { ������ ������, ��������������� �� ���������,
    true - �������� ��� ����������, false - �������� ������ ������� }
  clearAndSort(terms, links, true);

  outputPages(links);
  writeln;

  writeln('����� �������� � �����������, ��������������� �� ���������');
  outputLinkPages(terms, links);

  writeln('����� �������� � ����������� �� ����������� ��������');
  outputLinkPage(terms, links, 12);
end;

{ ����� ������� ���� UI }
procedure outputHelp();
begin
  writeln;
  writeln('':10, '1. ��������');
  writeln('':10, '2. ����������');
  writeln('':10, '3. ��������');
  writeln('':10, '4. ��������������');
  writeln('':10, '5. �����');
  writeln('':10, '6. ���������� �� ������� �������');
  writeln('':10, '7. ������');
  writeln('':10, '8. �����');
end;

{ ����������� ���� ����� � ���������� }
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

{ ����������� ���� ������ }
function readIn(note: String):String; overload;
begin
  write(note);
  readln(result);
end;

{ ��������� ������ �� ������ ����� }
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

{ ��������� ������ � ������ ����� }
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

{ ���������� UI }
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
    case readIn('�������� ����� ����: ', 1, 8) of
      1:
      begin
        writeln;
        writeln('':15, '1. ��� �����������');
        writeln('':15, '2. � ������������');
        case readIn('�������� ����� �������: ', 1, 2) of
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
        term := readIn('������� ������, ������� ������ ��������, ��� ������ � ���������� ����� �������: ');
        writeln;
        pages := readInArray('������� �������� ������� ����� �������: ');
        insertTerm(terms, strToArray(term), pages);
      end;
      3:
      begin
        writeln;
        term := readIn('������� ������, ������� ������ �������, ��� ������ � ���������� ����� �������: ');
        deleteTerm(terms, strToArray(term));
      end;
      4:
      begin
        writeln;
        writeln('':15, '1. ��������');
        writeln('':15, '2. �������');
        writeln('':15, '3. �������� � �������');
        case readIn('�������� ����� �������: ', 1, 3) of
          1:
          begin
            writeln;
            term := readIn('������� ������ ��� ��������������: ');
            writeln;
            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            new := readIn('������� ����� �������� �������: ');

            changeTerm(terms, subterm, term, new);
          end;
          2:
          begin
            writeln;
            term := readIn('������� ������ ��� ��������������: ');
            writeln;

            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            pages := readInArray('������� ����� �������� ������� ����� �������: ');

            changeTerm(terms, subterm, term, pages);
          end;
          3:
          begin
            writeln;
            term := readIn('������� ������ ��� ��������������: ');
            writeln;

            subterm := strToArray(term);
            term := subterm[length(subterm) - 1];
            setLength(subterm, length(subterm) - 1);

            new := readIn('������� ����� �������� �������: ');
            writeln;

            pages := readInArray('������� ����� �������� ������� ����� �������� ������� ����� �������: ');

            changeTerm(terms, subterm, term, new, pages);
          end;
        end;
      end;
      5:
      begin
        writeln;
        writeln('':15, '1. �������� �� ����������');
        writeln('':15, '2. ����������� �� �������');
        case readIn('�������� ����� �������: ', 1, 2) of
          1:
          begin
            writeln;
            term := readIn('������� ���������: ');
            writeln;
            findSubterm(terms, term, '');
          end;
          2:
          begin
            writeln;
            term := readIn('������� ������ ��� ������ � ������������ ����� �������: ');
            writeln;
            findAndOutputTerm(terms, strToArray(term));
          end;
        end;
      end;
      6:
      begin
        writeln;
        writeln('':15, '1. �������');
        writeln('':15, '2. ������� � ����������');
        case readIn('������� ����� �������: ', 1, 2) of
          1:
            clearAndSort(terms, links, false);
          2:
            clearAndSort(terms, links, true);
        end;
        writeln;
        writeln('':20, '1. ������� ����������� ��������');
        writeln('':20, '2. ������� ������� �����������');
        writeln('':20, '3. ������� ������� �� ��������');
        case readIn('������� ����� �������: ', 1, 3) of
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
            write('������� ����� ��������: ');
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
