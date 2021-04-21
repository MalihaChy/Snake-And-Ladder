set verify off;
set serveroutput on;

declare
	player2 integer := &player2_id;
	j integer := 0;
	match_id integer;	
	player2_moves integer;

begin
	for i in (select sender, match_id, message, sent_at 
				from Chat@host_link 
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
