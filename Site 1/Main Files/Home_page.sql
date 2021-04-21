set verify off;
set serveroutput on;

declare
	user_name varchar2(100);
	display_name varchar2(25);
	bio varchar2(160);
	password varchar2(500);
begin
	proc_sign_up('&user_name', '&display_name', '&bio', '&password');
end;
/

declare
	user_name varchar2(100);
	input_password varchar2(500);
begin	
	proc_log_in('&user_name','&input_password');
end;
/	