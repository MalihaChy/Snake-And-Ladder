set verify off;
set serveroutput on;

declare
	player2 Challenge_Game_Info.player1%type := &player2_id;
	j integer := 0;
	match_id Challenge_Game_Info.match_id%type;	
	player2_moves Challenge_Game_Info.player2_total_moves%type;

begin
	for i in (select sender, match_id, message, sent_at 
				from Chat 
				where receiver = player2
				order by sent_at desc) loop
		select winner into j from Challenge_Game_Info where match_id = i.match_id;		
		if j = -200 then
			dbms_output.put_line(i.sent_at||' : '||i.message);
			match_id := i.match_id;	
			exit;
		end if;
	end loop;
	
	if j != 0 and j = -200 then
		player2_moves := func_play_game;
		proc_match_info_update(match_id, player2_moves);
	else 
		dbms_output.put_line('Nobody challenged you, maybe you can challenge someone!! ;)');
	end if;
	commit;
	
end;
/
