set serveroutput on;

create or replace procedure proc_challenge_someone(sender in Player_Info.player_id%type, 
													receiver in Player_Info.player_id%type,
													match_id in integer,
													point in integer)
is

sent_at timestamp;
text varchar2(160);
name Player_Info.display_name%type;

begin
	dbms_output.put_line('j');
	select sysdate into sent_at from dual;
	
	select display_name into name from
	((select display_name from Player_Info where player_id = sender)
	union
	(select display_name from Player_Info@host_link where player_id = sender));
	
	text := name||' has challenged you for '||point||' points!';
	
	insert into Chat@host_link (sender, receiver, message, sent_at, match_id) 
	values(sender, receiver, text, sent_at, match_id);
	commit;
end proc_challenge_someone;
/	