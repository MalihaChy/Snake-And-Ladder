set serveroutput on;

create or replace procedure proc_RSA_encryption(input_password in varchar2, 
												input_player_id in integer)
is

	encrypted varchar2(500);
	decrypted varchar2(100);
	a varchar2(40);
	
	l integer;
	
	z integer;
	x integer := -1;
	y integer := 0;
	n integer;
	tn integer;
	e integer;
	d integer := 1;
	k integer := 0;
	c integer;
	tem integer := 0;

begin
	while x = -1 
	loop
		select trunc(dbms_random.value(2, 100)) into x from dual;
		x := f1(x); -- prime 1
	end loop;	
	dbms_output.put_line('x'||x);
	
	y := x;
	while x = y or y = -1
	loop
		select trunc(dbms_random.value(2, 100)) into y from dual;
		y := f1(y);
	end loop;
	dbms_output.put_line('y'||y);
	n := x * y;
	tn := (x-1)*(y-1);
	
	while tem != 1
	loop
		select trunc(dbms_random.value(2, tn)) into e from dual;
		if tn != e then
			tem := f2(tn, e);
		end if;	
	end loop;
	dbms_output.put_line('e'||e);
	
	while ((d * e) mod tn) != 1 
	loop
		k := k + 1;
		d := ((k * tn) + 1) / e;
	end loop;
	dbms_output.put_line('d'||d);
	dbms_output.put_line('k'||k);
	
	l := length(input_password);
	for i in 1..l loop
		a := substr(input_password, i);
		z := ascii(a);
		c := f3(z, e, n);
		dbms_output.put_line(c);
		encrypted := concat(encrypted, to_char(c));
		encrypted := concat(encrypted, '.');
	end loop;
	dbms_output.put_line(encrypted);
	
	/*
	l := length(encrypted);
	for i in 1..26 loop
		a := substr(encrypted, i);
		dbms_output.put_line(a);
		x := ascii(a)-96;
		c := power(x, d);
		c := c mod n;
		dbms_output.put_line('bye?');
		dbms_output.put_line(chr(c+96));
		decrypted := concat(decrypted, chr(c+96));
	end loop;
	dbms_output.put_line(decrypted);
	*/
	
	insert into Password@site_link values(input_player_id, encrypted, x, y, e, d);
	
	commit;

end;
/