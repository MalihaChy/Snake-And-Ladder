set serveroutput on;

drop table Player_Info cascade constraints;

create table Player_Info(
	player_id integer,
	user_name varchar2(100),
	display_name varchar2(25),
	bio varchar2(160),
	player_level integer,
	score integer,
	primary key(player_id)
);


drop sequence player_sequence;
drop trigger player_trigger_1;
/*
create sequence player_sequence start with 1 increment by 1;
	
create or replace trigger player_trigger_1
before insert on Player_Info
for each row
begin
select player_sequence.nextval
into :new.player_id
from dual;
end;
/	
*/


drop table Challenge_Game_Info cascade constraints;

create table Challenge_Game_Info(
	match_id integer,
	player1 integer,
	player2 integer,
	player1_total_moves integer,
	player2_total_moves integer,
	winner integer,
	point integer,
	primary key(match_id)
);	

drop sequence match_sequence;
drop trigger match_trigger_1;

create sequence match_sequence start with 1 increment by 1;
	
create or replace trigger match_trigger_1
before insert on Challenge_Game_Info
for each row
begin
select match_sequence.nextval
into :new.match_id
from dual;
end;
/	


drop table Chat cascade constraints;

create table Chat(
	match_id integer,
	sender integer,
	receiver integer,
	message varchar2(160),
	sent_at timestamp,
	foreign key(match_id) references Challenge_Game_Info(match_id)
);	
	

drop table Password cascade constraints;
/*
create table Password(
	player_id integer,
	password varchar2(500),
	x integer,
	y integer,
	e integer,
	d integer
);	
*/
commit;
/*
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
*/





















