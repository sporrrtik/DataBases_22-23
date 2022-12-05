create or replace function s291193.get_total_amount_from_sponsors(_team_id INTEGER)
RETURNS BIGINT
LANGUAGE 'plpgsql'
AS $$
    DECLARE
        _total_amount BIGINT;
    BEGIN
        SELECT sum(sponsor_amount) into _total_amount from sponsor_club where club_id = _team_id;
        return _total_amount;
    end;
    $$;

create or replace function s291193.update_amount(_team_id INTEGER, new_amount BIGINT)
RETURNS VOID
LANGUAGE 'plpgsql'
AS $$
    BEGIN
        update club set amount = new_amount where id = _team_id;
    end;
    $$;

drop function get_infor_player(_player_id integer);

create or replace function s291193.get_attribute_player(_player_id integer)
returns setof attribute
language 'plpgsql'
as $$
    begin
        return query select * from s291193.attribute where id in (select id_attribute from player where id = _player_id);
    end;
    $$;

create or replace function s291193.insert_new_player_1()
returns trigger
language 'plpgsql'
as $$BEGIN
    insert into attribute values (new.id, 60,60,60,60,60,60,60);
    return new;
end;
$$;

create or replace function insert_new_match_on_league()
returns trigger
language 'plpgsql'
as $$BEGIN
    insert into match values (new.match_id,'Match','01/01/1900','Sunny',1000);
    return new;
end;
$$;

