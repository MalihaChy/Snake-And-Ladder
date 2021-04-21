create or replace procedure proc_profile(player_id_input in integer)
is

display_name Player_Info.display_name%type;
user_name Player_Info.user_name%type;
score integer;
player_level integer;
bio Player_Info.bio%type;
total_match integer;
won integer;
lost integer;
draw integer;


begin
	
	select display_name, user_name, score, player_level, bio
	into display_name, user_name, score, player_level, bio
	from
	(
	(select display_name, user_name, score, player_level, bio 
	from Player_Info where player_id = player_id_input) 
	union
	(select display_name, user_name, score, player_level, bio 
	from Player_Info@host_link where player_id = player_id_input)
	);
	
	select count(match_id) into total_match from Challenge_Game_Info@host_link
	where player1 = player_id_input or player2 = player_id_input;
	
	select count(match_id) into won from Challenge_Game_Info@host_link
	where winner = player_id_input;
	
	select count(match_id) into lost from Challenge_Game_Info@host_link
	where ((player1 = player_id_input or player2 = player_id_input)
	and winner != player_id_input and winner != -100);
	
	select count(match_id) into draw from Challenge_Game_Info@host_link
	where ((player1 = player_id_input or player2 = player_id_input)
	and winner = -100);
	
	
	dbms_output.put_line('Here is '||display_name||' Profile!!');
	dbms_output.put_line('Player Id : '||player_id_input);
	dbms_output.put_line('Display Name : '||display_name);
	dbms_output.put_line('username : '||user_name);	
	dbms_output.put_line('Total Score : '||score);
	dbms_output.put_line('Current Level : '||player_level);
	dbms_output.put_line('Bio : '||bio);
	dbms_output.put_line('Total Matches Played : '||total_match);
	dbms_output.put_line('So Far Won : '||won);
	dbms_output.put_line('Lost Matches : '||lost);
	dbms_output.put_line('Draw : '||draw);
	
exception
	when no_data_found then
		dbms_output.put_line('Sorry, No Data Found :(');
	
end proc_profile;
/