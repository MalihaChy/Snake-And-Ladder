set verify off;
set serveroutput on;

create or replace procedure proc_sign_up(input_user_name in Player_Info.user_name%type,
										input_display_name in Player_Info.display_name%type,
										input_bio in Player_Info.bio%type,
										input_password in varchar2
										)
is

input_player_level Player_Info.player_level%type := 1;
input_score Player_Info.score%type := 0;
n Player_Info.player_id%type := -1;
id integer;

user_name_exists exception;


begin
	select player_id into n from 
	((select player_id from Player_Info where user_name = input_user_name)
	union 
	(select player_id from Player_Info@host_link where user_name = input_user_name));
	
	if n != -1 then
		raise user_name_exists;
	end if;
	
exception
	when user_name_exists then
		dbms_output.put_line('This user name is already in use! Please try something else!');	
	when no_data_found then
		select max(player_id) into id from 
		((select player_id from Player_Info)
		union
		(select player_id from Player_Info@host_link));
		id := id + 1;
		insert into Player_Info@host_link (player_id, user_name, display_name, bio, player_level, score) 
		values(id, input_user_name, input_display_name, input_bio, input_player_level, input_score);
		
		proc_RSA_encryption(input_password, id);
		
		commit;
		
		dbms_output.put_line('Hello '||input_display_name||'! You are one of us now!!');	
	
end proc_sign_up;
/	