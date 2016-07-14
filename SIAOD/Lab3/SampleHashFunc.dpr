program Lab3;

{$APPTYPE CONSOLE}

uses
  Windows;

const
  N = 1; //���������� �������

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

{ ����������� 2 ������ � ������ ���� TValue }
function getValue(key, data: String):TValue;
begin
  result.key := key;
  result.data := data;
end;
    
{ ������� ���� (������) �� ������ }
procedure outputKey(const value: TValue);
begin
  writeln(value.key);
end;
      
{ ������� ������ (�����������) �� ������ }
procedure outputData(const value: TValue);
begin
  writeln(value.data);
end;
      
{ ������� ������ � ����������� }
procedure outputAll(const value: TValue);
begin
  writeln(value.key, ': ');
  writeln('':7, value.data);
end;
     
{ ��������� ���������� �������� � ������ }
procedure insert(list: TList; value: TValue);
var
  temp: TList;
begin
  new(temp);
  temp^.value := value;
  temp^.next := list^.next;
  list^.next := temp;
end;
   
{ ��������� �������� �������� �� ������ ������ }
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
          
{ ����� � ����� �������� �� ������ }
procedure outputFromList(list: TList; const key: String; proc: TOutputProc);
begin
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.value.key = key then
      proc(list^.value);
  end;
end;
       
{ ����� �������� � ������ }
function getFromList(list: TList; const key: String):TList;
begin
  while (list^.next <> nil) and (list^.next^.value.key <> key) do
  begin
    list := list^.next;
  end;
  result := list;
end;
      
{ ����� ���� �������� ������ }
procedure outputList(list: TList; proc: TOutputProc);
begin
  while list^.next <> nil do
  begin
    list := list^.next;
    proc(list^.value);
  end;
end;
    
{ ������� ������ }
procedure clearList(list: TList);
begin
  while list^.next <> nil do
    delete(list);
end;
          
{ ���-������� }
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
        
{ ���������� �������� � ������� }
procedure insertToDict(dict: TDictionary; const value: TValue);
begin
  insert(dict[hash(value.key)], value);
end;
           
{ ����� � ����� �������� � ������� }
procedure outputFromDict(dict: TDictionary; const key: String; proc: TOutputProc);
begin
  outputFromList(dict[hash(key)], key, proc);
end;
      
{ ���������� ������� �� ����� }
{ ���� �������� � ������� ���, �� list^.next = nil }
function getFromDict(dict: TDictionary; const key: String):TList;
begin
  result := getFromList(dict[hash(key)], key);
end;
     
{ ������� ��� �������� �� ������ � ������� ��������� }
procedure outputListWhere(dict: TDictionary; const key: String; proc: TOutputProc);
begin
  if getFromDict(dict, key)^.next <> nil then
  begin
    writeln('������� � ������, ��� ���������� "', key, '":');
    outputList(dict[hash(key)], proc);
  end
  else
    writeln('������� ������� � ������� ���');
end;
    
{ ������� ������� �� ������� }
procedure deleteFromDict(dict: TDictionary; const key: String);
begin
  delete(getFromList(dict[hash(key)], key));
end;
                 
{ �������� ����������� ������� }
procedure changeInDict(dict: TDictionary; const key, data: String);
var
  temp: TList;
begin
  temp := getFromDict(dict, key)^.next;
  if temp <> nil then
    temp^.value.data := data;
end;
          
{ ������ ������� ������� }
procedure createDictionary(var dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to n - 1 do
    new(dict[i]);
end;
            
{ ��������� ������ � ������� }
procedure inputData(dict: TDictionary);
begin
  insertToDict(dict, getValue('������', '����� � ������ � ������� ����������� ��������'));
  insertToDict(dict, getValue('������', '����� � ������� �������, �������'));
  insertToDict(dict, getValue('����������', '����� � ����������, ������� � ����������'));
  insertToDict(dict, getValue('�����', '����� � ���������, �� ������� � ��������'));
  insertToDict(dict, getValue('��������', '����� � ����� ��������� � �� �������������� � ���������� ������'));
  insertToDict(dict, getValue('����������', '����� � ���������, �������� �����'));
  insertToDict(dict, getValue('�����������', '����� � ������� � ��������� �����, ��������, ��������� ����������'));
end;
        
{ ������� ������� }
procedure clearDict(dict: TDictionary);
var
  i: Integer;
begin
  for i := 0 to n - 1 do
    clearList(dict[i]);
end;
               
{ ������� ������� }
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

  outputFromDict(dict, '������', outputAll);
  writeln;

  changeInDict(dict, '������', '=(');
  outputListWhere(dict, '������', outputKey);
  writeln;

  deleteFromDict(dict, '�����');
  outputList(getFromDict(dict, '��������'), outputAll);

  deleteDict(dict);
  readln;
end.
