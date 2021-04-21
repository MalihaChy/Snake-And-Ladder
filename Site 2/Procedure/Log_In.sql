set serveroutput on;

create or replace procedure proc_log_in(input_user_name in Player_Info.user_name%type,
										input_password in Password.password%type
										)
is

pw Password.password%type;
ee integer;
xx integer;
yy integer;


begin
	select password, e, x, y into pw, ee, xx, yy from Password
	where player_id = 
	(	
	(select player_id from Player_Info 
	where user_name = input_user_name)
	union
	(select player_id from Player_Info@host_link 
	where user_name = input_user_name)
	);
	
	input_password := func_encryption(input_password, ee, xx, yy);
	
	if pw = input_password then
		dbms_output.put_line('Successfully logged in!');
	else 
		dbms_output.put_line('Wrong password! Please try again!');
	end if;
	
exception
	when no_data_found then
		dbms_output.put_line('Incorrect user name! Please try again!');	
	
end proc_log_in;
/	