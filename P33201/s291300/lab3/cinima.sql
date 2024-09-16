DROP TABLE IF EXISTS "order_record";
DROP TABLE IF EXISTS "ticket";
DROP TABLE IF EXISTS "remaining_seat_matrix";
DROP TABLE IF EXISTS "session";
DROP TABLE IF EXISTS "hall";
DROP TABLE IF EXISTS "comments";
DROP TABLE IF EXISTS "movie";
DROP TABLE IF EXISTS "role";
DROP TABLE IF EXISTS "client";
DROP TABLE IF EXISTS "cinema";

CREATE TABLE "cinema" (
  "cinema_id" SERIAL,
  "name" varchar(50) NOT NULL,
  "address" varchar(120) NOT NULL,
  PRIMARY KEY ("cinema_id")
);
CREATE TABLE "client" (
  "client_id" SERIAL,
  "name" varchar(30) NOT NULL,
  "password" varchar(30) NOT NULL,
  "email" varchar(30) NOT NULL,
  "headimg" varchar(30) DEFAULT NULL,
  PRIMARY KEY ("client_id")
);
CREATE TABLE "role" (
  "client_id" Integer REFERENCES "client"(client_id),
  "role" varchar(10) DEFAULT 'USER',
  PRIMARY KEY ("client_id")
);
CREATE TABLE "movie" (
  "movie_id" SERIAL,
  "name" varchar(30) NOT NULL,
  "staring" varchar(30) DEFAULT NULL,
  "detail" varchar(350) NOT NULL,
  "duration" varchar(20) DEFAULT NULL,
  "type" varchar(20) NOT NULL,
  "score" varchar(20) DEFAULT NULL,
  "picture" varchar(35) NOT NULL,
  "box_office" varchar(20) DEFAULT NULL,
  "comments_count" varchar(30) DEFAULT NULL,
  "release_date" date DEFAULT NULL,
  "box_office_unit" Integer DEFAULT NULL,
  "release_point" varchar(30) DEFAULT NULL,
  "comments_unit" Integer DEFAULT NULL,
  PRIMARY KEY ("movie_id")
);
CREATE TABLE "comments" (
  "comments_id" SERIAL,
  "client_id" Integer REFERENCES "client"(client_id),
  "comments" varchar(300) NOT NULL,
  "movie_id" Integer REFERENCES "movie"(movie_id),
  PRIMARY KEY ("comments_id")
);
CREATE TABLE "hall" (
  "hall_id" SERIAL,
  "name" varchar(20) NOT NULL,
  "cinema_id" Integer REFERENCES "cinema"(cinema_id),
  "capacity" Integer NOT NULL,
  PRIMARY KEY ("hall_id")
);
CREATE TABLE "session" (
  "session_id" SERIAL,
  "hall_id" Integer REFERENCES "hall"(hall_id),
  "cinema_id" Integer REFERENCES "cinema"(cinema_id),
  "movie_id" Integer REFERENCES "movie"(movie_id),
  "session_date" date NOT NULL,
  "start_time" time DEFAULT NULL,
  "price" Integer NOT NULL,
  PRIMARY KEY ("session_id")
);
CREATE TABLE "remaining_seat_matrix" (
  "session_id" Integer REFERENCES "session"(session_id),
  "row" Integer NOT NULL,
  "col" Integer NOT NULL,
  "value" varchar(100) NOT NULL,
  PRIMARY KEY ("session_id")
);
CREATE TABLE "ticket" (
  "ticket_id" SERIAL,
  "client_id" Integer REFERENCES "client"(client_id),
  "session_id" Integer REFERENCES "session"(session_id),
  "hall_id" Integer REFERENCES "hall"(hall_id),
  "seat" varchar(50) NOT NULL,
  PRIMARY KEY ("ticket_id")
);
CREATE TABLE "order_record" (
  "order_record_id" SERIAL,
  "ticket_id" Integer REFERENCES "ticket"(ticket_id),
  "cinema_id" Integer REFERENCES "cinema"(cinema_id),
  PRIMARY KEY ("order_record_id")
);