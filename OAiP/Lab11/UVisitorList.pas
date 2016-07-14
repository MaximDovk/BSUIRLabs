unit UVisitorList;

interface

var
  visitorsLen: Integer = 0;

type
  // ����� ����������� ����������
  TAddress = packed record
    city: String[10];
    street: String[20];
    houseNumber: Integer;
    case blockOfFlats: Boolean of
      true: (flatNumber: Integer);
      false: ();
  end;
  // ���
  TName = packed record
    firstName: String[20];
    middleName: String[20];
    lastName: String[20];
  end;
  // ������ � ������������
  TVisitor = packed record
    ID: Integer;
    name: TName;
    address: TAddress;
    phoneNumber: String[20];
  end;
  TVisitors = array of TVisitor;

// ����������� TName
function toName(const firstName,
                      middleName,
                      lastName: String):TName;

// ����������� TAddress
// ���� flatNumber = -1, �� ���������� ������� blockOfFlats = false
function toAddress(const city,
                         street: String;
                   const houseNumber,
                         flatNumber: Integer):TAddress;

// ����������� TVisitor
function toVisitor(const ID: Integer;
                   const name: TName;
                   const address: TAddress;
                   const phoneNumber: String):TVisitor;

// ���������� ����������� ����������
procedure addVisitor(visitor: TVisitor);

// ����� ����������� �� �����
function findByName(visitorName: TName):TVisitors;

// ����� ���������� �� ������
function findByID(ID: Integer):TVisitor;

// �������� ���������� �� ������
procedure deleteByID(ID: Integer);

// ��������� ���������� �� ������
procedure changeByID(ID: Integer; newVisitor: TVisitor);
               
// ���������� ������ � ���� ����������� ����������
function returnAllVisitors:TVisitors;
                                
// ������� TName � ������
function nameToStr(name: TName):String;

// ������ TAddress � ������
function addressToStr(address: TAddress):String;

// ���������, ���������� �� ���������� � �����
function visitorExist(code: Integer):Boolean;

implementation

uses
  SysUtils, UMain;

type
  // ������ ����������� ����������
  TVisitorList = ^TVisitorElem;
  TVisitorElem = packed record
    visitor: TVisitor;
    next: TVisitorList;
  end;

var
  visitors: TVisitorList;

// ������� TName � ������
function nameToStr(name: TName):String;
begin
  result := name.lastName + ' ' + name.firstName + ' ' + name.middleName;
end;

// ������ TAddress � ������
function addressToStr(address: TAddress):String;
begin
  result := sCITY_SHORT + ' ' + address.city + ', ' + address.street +
            ' ' + sHOUSE_SHORT + ' ' + IntToStr(address.houseNumber);
  if address.blockOfFlats then
    result := result + ' ' + sFLAT_SHORT + ' ' + IntToStr(address.flatNumber);
end;

// ����������� TName
function toName(const firstName,
                      middleName,
                      lastName: String):TName;
begin
  result.firstName := firstName;
  result.middleName := middleName;
  result.lastName := lastName;
end;
           
// ����������� TAddress
function toAddress(const city,
                         street: String;
                   const houseNumber,
                         flatNumber: Integer):TAddress;
begin
  result.city := city;
  result.street := street;
  result.houseNumber := houseNumber;
  if flatNumber = -1 then
    result.blockOfFlats := false
  else
  begin
    result.blockOfFlats := true;
    result.flatNumber := flatNumber;
  end;
end;

// ����������� TVisitor
function toVisitor(const ID: Integer;
                   const name: TName;
                   const address: TAddress;
                   const phoneNumber: String):TVisitor;
begin
  result.ID := ID;
  result.name := name;
  result.address := address;
  result.phoneNumber := phoneNumber;
end;

// ���������� �������� � ������
procedure insert(list: TVisitorList; visitor: TVisitor);
var
  temp: TVisitorList;
begin
  new(temp);
  temp^.visitor := visitor;
  temp^.next := list^.next;
  list^.next := temp;
end;

// ��������� ���� ������� TName
function lessThan(const nameA, nameB: TName):Boolean;
begin
  result := true;
  if nameA.lastName > nameB.lastName then
    result := false
  else
  begin
    if nameA.lastName = nameB.lastName then
    begin
      if nameA.firstName > nameB.firstName then
        result := false
      else
      begin
        if nameA.firstName = nameB.firstName then
        begin
          if nameA.middleName > nameB.middleName then
            result := false;
        end;
      end;
    end;
  end;
end;
            
// ���������� ����������� ����������
procedure addVisitor(visitor: TVisitor);
var
  list: TVisitorList;
begin
  list := visitors;
  while (list^.next <> nil) and lessThan(list^.next^.visitor.name, visitor.name) do
    list := list^.next;
  insert(list, visitor);
  if visitor.ID > visitorsLen then
    visitorsLen := visitor.ID;
end;
            
// ��������� ���������� �� ������
procedure changeByID(ID: Integer; newVisitor: TVisitor);
var
  list: TVisitorList;
begin
  list := visitors;
  while (list^.next <> nil) and (list^.next^.visitor.ID <> ID) do
    list := list^.next;
  if list^.next <> nil then
    list^.next^.visitor := newVisitor;
end;

// ��������� ���� ������� TName
function equal(recA, recB: TName):Boolean;
begin
  if (recB.firstName = '') and (recB.middleName = '') then
  begin
    result := (recA.lastName = recB.lastName);
  end
  else
  begin
    result := (recA.firstName = recB.firstName) and
              (recA.middleName = recB.middleName) and
              (recA.lastName = recB.lastName);
  end;
end;
              
// ����� ����������� �� �����
function findByName(visitorName: TName):TVisitors;
var
  list: TVisitorList;
begin
  list := visitors;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    if equal(list^.visitor.name, visitorName) then
    begin
      SetLength(result, length(result) + 1);
      result[length(result) - 1] := list^.visitor;
    end;
  end;
end;

// ����� ���������� �� ������
function findByID(ID: Integer):TVisitor;
var
  list: TVisitorList;
begin
  list := visitors;
  result.ID := ID - 1;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.visitor.ID = ID then
      result := list^.visitor;
  end;
end;

// �������� �������� �� ������
procedure delete(list: TVisitorList);
var
  temp: TVisitorList;
begin
  if list^.next <> nil then
  begin
    temp := list^.next;
    list^.next := temp^.next;
    dispose(temp);
  end;
end;

// �������� ���������� �� ������
procedure deleteByID(ID: Integer);
var
  list: TVisitorList;
begin
  list := visitors;
  while list^.next <> nil do
  begin
    if list^.next^.visitor.ID = ID then
      delete(list)
    else
      list := list^.next;
  end;
end;

// ���������� ������ � ���� ����������� ����������
function returnAllVisitors:TVisitors;
var
  list: TVisitorList;
begin
  list := visitors;
  SetLength(result, 0);
  while list^.next <> nil do
  begin
    list := list^.next;
    SetLength(result, length(result) + 1);
    result[length(result) - 1] := list^.visitor;
  end;
end;

// ���������, ���������� �� ���������� � �����
function visitorExist(code: Integer):Boolean;
var
  list: TVisitorList;
begin
  list := visitors;
  result := false;
  while list^.next <> nil do
  begin
    list := list^.next;
    if list^.visitor.ID = code then
      result := true;
  end;
end;

// ������� ������
procedure clear(list: TVisitorList);
begin
  while list^.next <> nil do
    delete(list);
end;

// �������� ������
procedure create(var list: TVisitorList);
begin
  new(list);
  list^.next := nil;
end;

// �������� ������
procedure destroy(var list: TVisitorList);
begin
  clear(list);
  dispose(list);
  list := nil;
end;

initialization
  create(visitors);
  visitorsLen := 0;

finalization
  destroy(visitors);

end.
