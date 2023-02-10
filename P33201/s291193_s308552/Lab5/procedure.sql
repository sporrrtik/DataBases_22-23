Create or replace procedure s291193.tranfer_player(_player_id INTEGER, _team_id INTEGER)
LANGUAGE 'plpgsql'
AS $$
    DECLARE
        _price INTEGER;
        _current_amount BIGINT;
    BEGIN
        IF (EXISTS(SELECT * FROm player where id = _player_id) and
            exists(select * from club where id = _team_id)
            and not exists(select * from player_club where id_player = _player_id and id_team = _team_id))
            then
            select get_total_amount_from_sponsors(_team_id) into _current_amount;
            update club set amount = _current_amount where id = _team_id;
            select player_club._price into _price from player_club where player_club.id_player = _player_id;
            if(_current_amount > _price) then
                update player_club set id_team =_team_id where id_player = _player_id;
                perform update_amount(_team_id, _current_amount - _price);
            else
                RAISE notice 'Amount not enough';
            end if;
        else
            raise notice 'player or club not found';
        end if;
        Commit;
    END;
$$;

create or replace procedure s291193.sponsor_new_club(_team_id INTEGER, _sponsor_id INTEGER, amount BIGINT)
LANGUAGE 'plpgsql'
AS $$
    DECLARE
        new_amount BIGINT;
    BEGIN
        if(exists(select * from club where id = _team_id) and
           exists(select * from sponsor where id = _sponsor_id)
            and not exists(select * from sponsor_club where sponsor_id = _sponsor_id and club_id = _team_id))
            then
                insert into sponsor_club values (_sponsor_id, _team_id, amount);
                if(exists(select club.amount from club where id = _team_id))
                then
                select club.amount into new_amount from club where id = _team_id;
                else
                    new_amount = 0;
                end if;
                perform update_amount(_team_id,new_amount + amount);
        end if;
    end;
    $$;

create or replace procedure s291193.transfer_new_coach(_coach_id integer, _team_id integer)
language 'plpgsql'
as $$
    declare
        id_old_club integer;
    begin
        if(exists(select * from coach where id = _coach_id) and
           exists(select * from club where id = _team_id))
            then
            update club set id_coach = _coach_id where id = _team_id;
            if(exists(select id from club where id_coach = _coach_id))
                then
                select id into id_old_club from club where id_coach = _coach_id;
                update club set id_coach = -1 where id = id_old_club;
            end if;
        end if;
    end;
$$;

