create or replace function f1(x in integer)
return integer
is

x1 integer := x/2;
is_prime integer := 1;

begin
	for i in 2..x1 loop
		if (x mod i) = 0 then
			is_prime := 0;
			exit;
		end if;	
	end loop;
	if is_prime = 0 then
		return -1;
	else 
		return x;
	end if;	
end;
/
-----------------------------------------------------
create or replace function f2(a in integer, b in integer)
return integer
is

begin
	if a = 0 then
		return b;
	end if;
	return f2(b mod a, a);
end;
/	
----------------------------------------------------------------
create or replace function f3(a in integer, p in integer, m in integer)
return integer
is

tmp integer;

begin
	if p = 0 then
		return 1;
	end if;
	if (p mod 2) = 1 then
		return ((a mod m) * (f3(a, p-1, m))) mod m;
	else
		tmp := f3(a, p/2, m);
		return (tmp * tmp) mod m;
	end if;	
end;
/
























