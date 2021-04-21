set verify off;
--accept x integer prompt 'Do you want to challenge anyone? 1.Yes  2.No '
--accept y integer prompt 'Who do you want to challenge? '
--accept z integer prompt 'How many points? '

---------------------- site unfinished -----------------------

set serveroutput on;

create or replace view dashboard(ID, Player, Score, PlayerLevel) as
(select player_id, display_name, score, player_level
from Player_Info)
union
(select player_id, display_name, score, player_level
from Player_Info@site_link) 
order by display_name;

select * from dashboard;

declare
	answer integer := &x;
	receiver Chat.receiver%type := &opponent_id;
	point_input Challenge_Game_Info.point%type := &point;
	player1_moves Challenge_Game_Info.player1_total_moves%type;
	player1_id Challenge_Game_Info.player1%type := &your_player_id;
	match_id Challenge_Game_Info.match_id%type;
	
begin
	if answer = 1 then
		dbms_output.put_line('CHALLENGE TIME!!!');
		player1_moves := func_play_game;
		
		insert into Challenge_Game_Info (player1, player2, player1_total_moves, point, winner) 
		values (player1_id, receiver, player1_moves, point_input, -200);
		commit;
		
		select max(match_id) into match_id from Challenge_Game_Info;
		
		proc_challenge_someone(player1_id, receiver, match_id, point_input);
		
	else dbms_output.put_line('Okay, maybe some other time :(');
	
	end if;
end;
/
