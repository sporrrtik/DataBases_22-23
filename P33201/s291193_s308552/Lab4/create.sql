CREATE TYPE _POSITION  AS ENUM  ('GK', 'CB', 'LB', 'RB', 'CDM', 'CAM', 'CM', 'CF',
    'RF', 'LF', 'LM', 'RM')  ;
CREATE TYPE _LEVEL AS ENUM ('CLUB', 'INTERNATIONAL');
CREATE TABLE IF NOT EXISTS attribute (
                                         id SERIAL PRIMARY KEY,
                                         attack INTEGER DEFAULT 50,
                                         defense INTEGER DEFAULT 50,
                                         dribble INTEGER DEFAULT 50,
                                         pass INTEGER DEFAULT 50,
                                         speed INTEGER DEFAULT 50,
                                         power INTEGER DEFAULT 50,
                                         stamina INTEGER DEFAULT 50
);
CREATE TABLE IF NOT EXISTS player (
                                      id SERIAL PRIMARY KEY,
                                      full_name VARCHAR(50) NOT NULL,
                                      height INTEGER NOT NULL,
                                      weight REAL NOT NULL,
                                      position _POSITION NOT NULL,
                                      nationality VARCHAR(50) NOT NULL,
                                      shirt_number INTEGER NOT NULL,
                                      birthday DATE NOT NULL,
                                      image VARCHAR(100),
                                      id_attribute INTEGER REFERENCES attribute NOT NULL
);
CREATE TABLE IF NOT EXISTS sponsor (
                                       id SERIAL PRIMARY KEY,
                                       name VARCHAR(50) NOT NULL,
                                       headquarter VARCHAR(50) NOT NULL,
                                       management VARCHAR(50) NOT NULL,
                                       assets BIGINT NOT NULL
);
CREATE TABLE IF NOT EXISTS goal (
                                    id SERIAL PRIMARY KEY,
                                    time TIMESTAMP NOT NULL,
                                    video VARCHAR(100) NOT NULL,
                                    rating INTEGER
);
CREATE TABLE IF NOT EXISTS league (
                                      id SERIAL PRIMARY KEY,
                                      name VARCHAR(50) NOT NULL,
                                      region VARCHAR(50) NOT NULL,
                                      level _level NOT NULL
);
CREATE TABLE IF NOT EXISTS stadium (
                                       id SERIAL PRIMARY KEY,
                                       name VARCHAR(50) NOT NULL,
                                       coordinate VARCHAR(50) NOT NULL,
                                       capacity BIGINT NOT NULL,
                                       owner VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS coach (
                                     id SERIAL PRIMARY KEY,
                                     full_name VARCHAR(50) NOT NULL,
                                     birthday DATE NOT NULL,
                                     nationality VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS referee (
                                       id SERIAL PRIMARY KEY,
                                       full_name VARCHAR(50) NOT NULL,
                                       birthday DATE NOT NULL,
                                       nationality VARCHAR(50) NOT NULL,
                                       rating FLOAT4 NOT NULL
);
CREATE TABLE IF NOT EXISTS club (
                                    id SERIAL PRIMARY KEY,
                                    full_name VARCHAR(50) NOT NULL,
                                    nationality VARCHAR(50) NOT NULL,
                                    owner VARCHAR(50) NOT NULL,
                                    logo VARCHAR(100) NOT NULL,
                                    id_coach INTEGER REFERENCES coach NOT NULL,
                                    id_stadium INTEGER REFERENCES stadium NOT NULL
);
CREATE TABLE IF NOT EXISTS match (
                                     id SERIAL PRIMARY KEY,
                                     special_name VARCHAR(50) NOT NULL UNIQUE,
                                     time TIMESTAMP NOT NULL,
                                     weather VARCHAR(50) NOT NULL,
                                     audience INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS player_club (
                                           id_player INTEGER REFERENCES player NOT NULL,
                                           id_team INTEGER REFERENCES club NOT NULL
);
CREATE TABLE IF NOT EXISTS club_league (
                                           club_id INTEGER REFERENCES club NOT NULL,
                                           league_id INTEGER REFERENCES league NOT NULL
);
CREATE TABLE IF NOT EXISTS club_match (
                                          club_id INTEGER REFERENCES club NOT NULL,
                                          match_id INTEGER REFERENCES match NOT NULL
);
CREATE TABLE IF NOT EXISTS match_league(
                                           match_id INTEGER REFERENCES match NOT NULL,
                                           league_id INTEGER REFERENCES league NOT NULL
);
CREATE TABLE IF NOT EXISTS match_goal(
                                         match_id INTEGER REFERENCES match NOT NULL,
                                         goal_id INTEGER REFERENCES goal NOT NULL
);
CREATE TABLE IF NOT EXISTS match_referee (
                                             match_id INTEGER REFERENCES match NOT NULL,
                                             referee_id INTEGER REFERENCES referee NOT NULL
);
CREATE TABLE IF NOT EXISTS match_stadium (
                                             match_id INTEGER REFERENCES match NOT NULL,
                                             stadium_id INTEGER REFERENCES stadium NOT NULL
);
CREATE TABLE IF NOT EXISTS player_goal (
                                           player_id INTEGER REFERENCES player NOT NULL,
                                           goal_id INTEGER REFERENCES goal NOT NULL
);
CREATE TABLE IF NOT EXISTS play_MOTM (
                                         player_id INTEGER REFERENCES player NOT NULL,
                                         match_id INTEGER REFERENCES match NOT NULL
);
CREATE TABLE IF NOT EXISTS sponsor_club (
                                            sponsor_id INTEGER REFERENCES sponsor NOT NULL,
                                            club_id INTEGER REFERENCES club NOT NULL
);




