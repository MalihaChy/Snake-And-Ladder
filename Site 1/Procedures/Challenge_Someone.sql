set serveroutput on;

create or replace procedure proc_challenge_someone(sender in Player_Info.player_id%type, 
													receiver in Player_Info.player_id%type,
													match_id in Challenge_Game_Info.match_id%type,
													point in integer)
is


sent_at timestamp;
text Chat.message%type;
name Player_Info.display_name%type;

begin
	select sysdate into sent_at from dual;
	
	select display_name into name from
	((select display_name from Player_Info where player_id = sender)
	union
	(select display_name from Player_Info@site_link where player_id = sender));
	
	text := name||' has challenged you for '||point||' points!';
	
	insert into Chat (sender, receiver, message, sent_at, match_id) 
	values(sender, receiver, text, sent_at, match_id);
	commit;
	
end proc_challenge_someone;
/	