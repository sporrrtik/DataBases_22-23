-- Test
-- SELECT * from find_movies('Venom','Cinemart Cinemas');
-- CALL delect_ticket(1);
-- call buy_ticket(1, 'R18', '2022-11-28', '20:30:00');
-- call add_movie('Venom', 'Ruben Fleischer', 'In the film, struggling journalist Brock gains superpowers after becoming the host of an alien symbiote, Venom, whose species plans to invade Earth.', '112', 'Action,Sci-fi', '9.3', 'img/movies/movie1.jpg', '14.86', '66.8', '2018-11-09', '100000000', 'America', '10000');
-- INSERT into client VALUES (6,'tessss','123','1232132','123123')

CREATE OR REPLACE FUNCTION find_movies(movie_name varchar, cinema_name varchar) RETURNS text AS $$
declare temp_date date;
temp_time time;
BEGIN
select session.session_date,
    session.start_time into temp_date,
    temp_time
from session
where movie_id =(
        select movie_id
        from movie
        where name = movie_name
    )
    AND cinema_id =(
        select cinema_id
        from cinema
        where name = cinema_name
    );
return format(
    'The time of %s is %s, %s',
    movie_name,
    temp_date,
    temp_time
);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE buy_ticket(
        user_client_id Integer,
        user_seat varchar,
        user_session_date date,
        user_start_time time
    ) LANGUAGE plpgsql AS $$
declare temp_session_id Integer;
temp_cinema_id Integer;
temp_hall_id Integer;
temp_ticket_id Integer;
temp_order_id Integer;
BEGIN
select session.session_id,
    session.cinema_id,
    session.hall_id into temp_session_id,
    temp_cinema_id,
    temp_hall_id
from session
where session.session_date = user_session_date
    AND session.start_time = user_start_time;
SELECT MAX(ticket_id) into temp_ticket_id
FROM ticket;
temp_ticket_id = temp_ticket_id + 1;
INSERT INTO ticket (ticket_id, client_id, session_id, hall_id, seat)
VALUES (
        temp_ticket_id,
        user_client_id,
        temp_session_id,
        temp_hall_id,
        user_seat
    );
SELECT MAX(order_record_id) into temp_order_id
FROM order_record;
temp_order_id = temp_order_id + 1;
INSERT INTO order_record (order_record_id, ticket_id, cinema_id)
VALUES (temp_order_id, temp_ticket_id, temp_cinema_id);
END;
$$;


CREATE OR REPLACE PROCEDURE delect_ticket(id Integer) LANGUAGE plpgsql AS $$ BEGIN
DELETE FROM order_record
WHERE ticket_id = id;
DELETE FROM ticket
WHERE ticket_id = id;
END $$;


CREATE OR REPLACE PROCEDURE add_movie(
        user_name VARCHAR,
        user_staring VARCHAR,
        user_detail VARCHAR,
        user_duration VARCHAR,
        user_type VARCHAR,
        user_score VARCHAR,
        user_picture VARCHAR,
        user_box_office VARCHAR,
        user_comments_count VARCHAR,
        user_release_date date,
        user_box_office_unit INTEGER,
        user_release_point VARCHAR,
        user_comments_unit INTEGER
    ) LANGUAGE plpgsql AS $$
declare temp_movie_id Integer;
BEGIN
SELECT MAX(movie_id) into temp_movie_id
FROM movie;
temp_movie_id = temp_movie_id + 1;
INSERT INTO movie (
        movie_id,
        name,
        staring,
        detail,
        duration,
        type,
        score,
        picture,
        box_office,
        comments_count,
        release_date,
        box_office_unit,
        release_point,
        comments_unit
    )
VALUES (
        temp_movie_id,
        user_name,
        user_staring,
        user_detail,
        user_duration,
        user_type,
        user_score,
        user_picture,
        user_box_office,
        user_comments_count,
        user_release_date,
        user_box_office_unit,
        user_release_point,
        user_comments_unit
    );
END;
$$;




CREATE OR REPLACE FUNCTION function_tr()
RETURNS TRIGGER
AS
$$
BEGIN
    if position('@' in new.email) =0
		then
			RAISE EXCEPTION 'Its not a email';
    end if;
		
    if length(new.password)<=6 
		then
		RAISE EXCEPTION 'Password is too short';
    end if;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER check_client_data
   BEFORE INSERT ON client
   FOR EACH ROW
	 EXECUTE PROCEDURE function_tr();
