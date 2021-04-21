create or replace view view1(Player_Id, Name) as
(select player_id, display_name from player_info)
union
(select player_id, display_name from player_info@site_link);

select * from view1;

execute proc_profile(6);

create or replace view view2(Match_Id, Player1, 
Player2, Player1_Moves, Player2_Moves, Winner, Point) as
select * from Challenge_Game_Info
where player1 = 6 or player2 = 6;

select * from view2;