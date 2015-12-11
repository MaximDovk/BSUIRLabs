{$APPTYPE CONSOLE}

uses
  Windows;

const
	signs: set of char = ['+', '-', '*', '/'];
  allowedSym: set of char = ['0'..'9', '+', '-', '*', '/', '(', ')', ' '];

var
	s: string;
	i, len, j, brackets: integer;
  error: boolean;

begin   
  SetConsoleCP(1251);
  SetConsoleOutputCP(1251);

  { ���� ����� }
	write('������� ������: ');
	readln(s);


	i:=1;
  error:=false;
	len:=length(s);

	while (i<=len) and not (error) do
	begin
    { ���� ������������ ������� }
    if not (s[i] in allowedSym) then
      error:=true;

    { ������� �������� � �������� ������ }
    if s[i]='(' then
      inc(brackets);
    if s[i]=')' then
      dec(brackets);

    { ������� ������� � ������ }
		if s[i]=' ' then
		begin
			delete(s, i, 1);
			dec(len);
		end
		else
			inc(i);
	end;

  if (brackets=0) and not error then
  begin                
    { ������� ��� ����� �������� � ���������� �� �� ������ ������� }
		for i:=len downto 1 do
		begin
			if s[i] in signs then
			begin
        { ���� ������ �������� - ��������� }
				if s[i+1] = '(' then
				begin
          brackets:=0;
					j:=i+1;
					repeat
            if s[j] = '(' then
              inc(brackets);
            if s[j] = ')' then
              dec(brackets);
						inc(j);
          until brackets=0;
					insert(s[i], s, j);
					delete(s, i, 1);
				end
				else
        { ���� ������ ������� - ����� }
				begin
					insert(s[i], s, i+2);
					delete(s, i, 1);
				end;
			end;
		end;

    { ������� ��� ������ }
		i:=1;
		while i<=len do
		begin
			if (s[i]='(') or (s[i]=')') then
			begin
				delete(s, i, 1);
				dec(len);
			end
			else
				inc(i);
		end;

	  writeln('���������� ������: ', s);
  end
  { ����� ���������� }
  else
    if error then
      write('������������ ������� � ������')
    else
      write('������������ �������� ������, ��������� ������');
	readln;
end.