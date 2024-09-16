create or replace trigger insert_new_player before insert on player
    for each row
    execute function insert_new_player_1();

create or replace trigger insert_new_match_on_league before insert on match_league
    for each row
    execute function insert_new_match_on_league();