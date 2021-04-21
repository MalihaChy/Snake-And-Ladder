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


drop table Challenge_Game_Info cascade constraints;

drop table Chat cascade constraints;

drop table Password cascade constraints;

create table Password(
	player_id integer,
	password varchar2(50),
	x integer,
	y integer,
	e integer,
	d integer
);	

commit;
/*
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
insert into Chat (sender, receiver, message, sent_at) values (1, 2, 'hello', sysdate);
*/





















