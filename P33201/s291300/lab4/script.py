import random
import string

import psycopg2
from faker import Faker

conn = psycopg2.connect(database="cinema", user="spbgzh",
                        password="010307", host="localhost", port="5432")
cur = conn.cursor()
list_table = ["order_record", "ticket", "remaining_seat_matrix", "session",
              "hall", "comments",  "movie", "role", "client", "cinema"]


# drop tables
cur.execute("DROP TABLE IF EXISTS {table}".format(table=', '.join(list_table)))
conn.commit()


# create tables
cur.execute("""
CREATE TABLE "cinema" (
  "cinema_id" SERIAL,
  "name" varchar(50) NOT NULL,
  "address" varchar(120) NOT NULL,
  PRIMARY KEY ("cinema_id")
);
""")
cur.execute("""
CREATE TABLE "client" (
  "client_id" SERIAL,
  "name" varchar(30) NOT NULL,
  "password" varchar(30) NOT NULL,
  "email" varchar(30) NOT NULL,
  "headimg" varchar(30) DEFAULT NULL,
  PRIMARY KEY ("client_id")
);
""")
cur.execute("""
CREATE TABLE "role" (
  "client_id" Integer REFERENCES "client"(client_id),
  "role" varchar(10) DEFAULT 'USER',
  PRIMARY KEY ("client_id")
);
""")
cur.execute("""
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
""")
cur.execute("""
CREATE TABLE "comments" (
  "comments_id" SERIAL,
  "client_id" Integer REFERENCES "client"(client_id),
  "comments" varchar(300) NOT NULL,
  "movie_id" Integer REFERENCES "movie"(movie_id),
  PRIMARY KEY ("comments_id")
);
""")
cur.execute("""
CREATE TABLE "hall" (
  "hall_id" SERIAL,
  "name" varchar(20) NOT NULL,
  "cinema_id" Integer REFERENCES "cinema"(cinema_id),
  "capacity" Integer NOT NULL,
  PRIMARY KEY ("hall_id")
);
""")
cur.execute("""
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
""")
cur.execute("""
CREATE TABLE "remaining_seat_matrix" (
  "session_id" Integer REFERENCES "session"(session_id),
  "row" Integer NOT NULL,
  "col" Integer NOT NULL,
  "value" varchar(100) NOT NULL,
  PRIMARY KEY ("session_id")
);
""")
cur.execute("""
CREATE TABLE "ticket" (
  "ticket_id" SERIAL,
  "client_id" Integer REFERENCES "client"(client_id),
  "session_id" Integer REFERENCES "session"(session_id),
  "hall_id" Integer REFERENCES "hall"(hall_id),
  "seat" varchar(50) NOT NULL,
  PRIMARY KEY ("ticket_id")
);
""")
cur.execute("""
CREATE TABLE "order_record" (
  "order_record_id" SERIAL,
  "ticket_id" Integer REFERENCES "ticket"(ticket_id),
  "cinema_id" Integer REFERENCES "cinema"(cinema_id),
  PRIMARY KEY ("order_record_id")
);
""")
conn.commit()


# delect data from tables
cur.execute("TRUNCATE TABLE {table}".format(table=', '.join(list_table)))
conn.commit()


num_data = 10000
list_create_data = ["cinema", "client", "movie", "comments", "hall",
                    "session", "ticket", "order_record", "remaining_seat_matrix", "role"]
fake = Faker()


def random_num(len):
    return "".join(str(random.randrange(10)) for _ in range(len))


def random_str(len):
    return "".join(random.sample(string.ascii_letters + string.digits, len))


def random_date():
    return str(random.randint(1900, 2022))+'-'+str(random.randint(1, 1)) + \
        '-'+str(random.randint(1, 28))


def random_id():
    return str(random.randint(1, 100))


def random_time():
    return str(random.randint(1, 12))+":"+str(random.randint(10, 59))+":"+str(random.randint(10, 59))


def random_seat():
    return "".join(str(random.randint(0, 1)) for _ in range(30))


id = 0


def matrix_id():
    global id
    if id == num_data:
        id = 0
    id = id+1
    return id


role_list = ["ADMIN", "USER", "VIP"]


for table in list_create_data:
    for i in range(num_data):
        match table:
            case "cinema":
                cur.execute("INSERT INTO cinema (name, address) VALUES (%s,%s)", (fake.name()+" Cinema",
                            fake.address()))
            case "client":
                cur.execute("INSERT INTO client (name, password, email, headimg) VALUES (%s,%s,%s,%s)", (fake.name(),
                                                                                                         random_num(6), random_num(6)+"@gmail.com", "img/"+random_num(3)+".jpg"))
            case "movie":
                cur.execute("INSERT INTO movie (name, staring, detail, duration,type,score,picture,box_office,comments_count,release_date,box_office_unit,release_point,comments_unit) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
                            (fake.name(), fake.name(), random_str(20), random_num(3), random_str(15), random_num(1), "img/"+random_num(3)+".jpg", random_num(2), random_num(2), random_date(), random_num(9), fake.name(), random_num(5)))
            case "comments":
                cur.execute("INSERT INTO comments (client_id, comments, movie_id) VALUES (%s,%s,%s)",
                            (random_id(), random_str(30), random_id()))
            case "hall":
                cur.execute("INSERT INTO hall (name, cinema_id, capacity) VALUES (%s,%s,%s)",
                            ("Hall"+str(random.randint(1, 10)), random_id(), random.randrange(10, 100, 10)))
            case "session":
                cur.execute("INSERT INTO session (hall_id, cinema_id, movie_id, session_date, start_time, price) VALUES (%s,%s,%s,%s,%s,%s)",
                            (random_id(), random_id(), random_id(), random_date(), random_time(), random.randrange(10, 100, 10)))
            case "ticket":
                cur.execute("INSERT INTO ticket (client_id, session_id, hall_id, seat) VALUES (%s,%s,%s,%s)",
                            (random_id(), random_id(), random_id(), 'R'+str(random.randint(1, 20))))
            case "order_record":
                cur.execute("INSERT INTO order_record (ticket_id, cinema_id) VALUES (%s,%s)",
                            (random_id(), random_id()))
            case "remaining_seat_matrix":
                cur.execute("INSERT INTO remaining_seat_matrix (session_id,row, col, value) VALUES (%s,%s,%s,%s)",
                            (matrix_id(), '5', '6', random_seat()))
            case "role":
                cur.execute("INSERT INTO role VALUES (%s,%s)",
                            (matrix_id(), random.choice(role_list)))


conn.commit()
cur.close()
conn.close()
