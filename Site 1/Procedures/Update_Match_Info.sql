set serveroutput on;

create or replace procedure proc_match_info_update(match_id_input in integer, player2_moves in integer)
	is

player1_moves integer;
winner_n integer;
loser integer := -100;
player1_n integer;
player2_n integer;
point_n integer;
l integer;
id integer;
score integer;
txt varchar2(100);

begin
	select player1_total_moves, player1, player2, point 
	into player1_moves, player1_n, player2_n, point_n
	from Challenge_Game_Info
	where match_id = match_id_input;
	
	if player1_moves < player2_moves then
		winner_n := player1_n;
		loser := player2_n;
	elsif player1_moves	> player2_moves then
		winner_n := player2_n;
		loser := player1_n;
	else winner_n := -100;
	end if;
	
	update Challenge_Game_Info set 
	player2_total_moves = player2_moves, 
	winner = winner_n 
	where match_id = match_id_input;
	---------------------------------------level modify-------------
	for i in ((select * from Player_Info 
			where player_id in (winner_n, loser))
			union
			(select * from Player_Info@site_link
			where player_id in (winner_n, loser))) 
	loop
		if i.player_level < 6 then
			if i.player_id = winner_n then
				i.score := i.score + point_n;
				txt := i.display_name||' won!!';
				insert into chat values(match_id_input, player2_n, player1_n, txt, sysdate);
			elsif i.player_id = loser then
				i.score := i.score - point_n;
			end if;	
			if i.score >= 1000 then
				i.player_level := floor(i.score / 1000);
			else 
				i.player_level := 1;
			end if;	
			dbms_output.put_line('score'||i.score||'level'||i.player_level);
			if i.player_level > 5 then
				-- insert
				insert into Player_Info@site_link 
				(player_id, user_name, display_name, bio, player_level, score) 
				values(i.player_id, i.user_name, i.display_name, i.bio, i.player_level, i.score);
				-- delete
				delete from Player_Info where player_id = i.player_id;
			elsif i.player_level < 6 then	
				update Player_Info set score = i.score,
				player_level = i.player_level 
				where player_id = i.player_id;
				dbms_output.put_line('Score : '||i.score);
				dbms_output.put_line('Id : '||i.player_id);
			end if;	
		elsif i.player_level > 5 then
			if i.player_id = winner_n then
				i.score := i.score + point_n;
				txt := i.display_name||' won!!';
				insert into chat values(match_id_input, player2_n, player1_n, txt, sysdate);
			elsif i.player_id = loser then
				i.score := i.score - point_n;
			end if;	
			if i.score >= 1000 then
				i.player_level := floor(i.score / 1000);
			else 
				i.player_level := 1;
			end if;
			dbms_output.put_line('score'||i.score||'level'||i.player_level);
			if i.player_level < 6 then
				-- insert
				insert into Player_Info 
				(player_id, user_name, display_name, bio, player_level, score) 
				values(i.player_id, i.user_name, i.display_name, i.bio, i.player_level, i.score);
				
				--select max(player_id) into id from Player_Info;
				--update Password@site_link set player_id = id where player_id = i.player_id;
				
				-- delete
				delete from Player_Info@site_link where player_id = i.player_id;				
			elsif i.player_level > 5 then	
				update Player_Info@site_link set score = i.score,
				player_level = i.player_level 
				where player_id = i.player_id;
				dbms_output.put_line('Score : '||i.score);
				dbms_output.put_line('Id : '||i.player_id);
			end if;	
		end if;	
		
	end loop;
	
	commit;
end proc_match_info_update;
/	
													