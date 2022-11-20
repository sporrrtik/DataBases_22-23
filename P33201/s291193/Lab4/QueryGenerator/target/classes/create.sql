CREATE TABLE transport(
                          id SERIAL PRIMARY KEY,
                          model VARCHAR(50) NOT NULL,
                          tonnage INTEGER NOT NULL
);
CREATE TABLE people (
                        id SERIAL PRIMARY KEY,
                        name VARCHAR(50) NOT NULL,
                        birthday DATE NOT NULL,
                        id_transport INTEGER REFERENCES transport NOT NULL
);
CREATE TABLE part(
                     id SERIAL PRIMARY KEY,
                     name VARCHAR(50) NOT NULL,
                     weight INTEGER NOT NULL
);
CREATE TABLE salvage (
                         id SERIAL PRIMARY KEY,
                         content VARCHAR(50) NOT NULL,
                         time TIMESTAMP NOT NULL,
                         place VARCHAR(50) NOT NULL
);
CREATE TABLE order(
                      person_id INTEGER REFERENCES people NOT NULL,
                      salvage_id INTEGER REFERENCES salvage NOT NULL
);
CREATE TABLE content_salvage(
                                salvage_id INTEGER REFERENCES salvage NOT NULL,
                                part_id INTEGER REFERENCES part NOT NULL
);
