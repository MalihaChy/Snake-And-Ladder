set serveroutput on;

create or replace function func_play_game
return number
is

n number;
current_position number := 0;
move number := 0;
start_game number := 0;
	

begin
	while start_game = 0
	loop
		select trunc(dbms_random.value(1, 7)) into n from dual;
		if n = 1 then
			start_game := 1;
			dbms_output.put_line('Yaay, you are in the game!');
		else
			dbms_output.put_line('No luck!');
		end if;
		move := move + 1;
	end loop;
	
	if start_game = 1 then
		while current_position < 100 
		loop
			select trunc(dbms_random.value(1, 7)) into n from dual;
			dbms_output.put_line('Your Current Position '||current_position);
			dbms_output.put_line('The Dice Rolled '||n);
			current_position := current_position + n;
			current_position := func_check_current_position(current_position);
			dbms_output.put_line('Your New Position '||current_position||chr(13)||chr(10));
			move := move + 1;
		end loop;
	end if;	
	
	dbms_output.put_line(chr(13)||chr(10));
	dbms_output.put_line('Total number of Moves : '||move);
	
	return move;
	
end func_play_game;
/	