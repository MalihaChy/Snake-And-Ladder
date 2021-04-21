create or replace function func_check_current_position(n in integer)
	return integer
	is	
	
position integer;	
	
begin	
	case n
		when 4 then
			position := 14;
		when 9 then
			position := 31;
		when 17 then
			position := 7;
		when 20 then
			position := 38;
		when 28 then
			position := 84;
		when 40 then
			position := 59;
		when 51 then
			position := 67;
		when 54 then
			position := 34;
		when 62 then
			position := 19;
		when 63 then
			position := 81;	
		when 64 then
			position := 60;
		when 71 then
			position := 91;
		when 87 then
			position := 24;
		when 93 then
			position := 73;
		when 95 then
			position := 75;
		when 99 then
			position := 78;
		else 
			position := n;
	end case;
	if position > n then
		dbms_output.put_line('Yaay, Ladder!');
	elsif position < n then
		dbms_output.put_line('Oops!');
	end if;	
	return position;
end func_check_current_position;
/	