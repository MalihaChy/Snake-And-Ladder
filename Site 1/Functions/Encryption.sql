drop function func_encryption;
create or replace function func_encryption(input_password in varchar2,
											e in integer,
											x in integer,
											y in integer)
return varchar2
is

a varchar2(500);
encrypted varchar2(500);
z integer;
l integer;
c integer;
n integer := x * y;

begin
	l := length(input_password);
	for i in 1..l loop
		a := substr(input_password, i);
		z := ascii(a);
		c := f3(z, e, n);
		encrypted := concat(encrypted, to_char(c));
		encrypted := concat(encrypted, '.');
	end loop;
	return encrypted;
end;
/