import psycopg2
from sshtunnel import SSHTunnelForwarder
import io
import hashlib
import string
from random import randint
from datetime import datetime
import random

PORT = 5432
REMOTE_USERNAME = 's285905'
REMOTE_HOST = 'helios.cs.ifmo.ru'
REMOTE_SSH_PORT = 2222
REMOTE_PASSWORD = 'GKxj.2817'

server = SSHTunnelForwarder((REMOTE_HOST, REMOTE_SSH_PORT),
         ssh_username=REMOTE_USERNAME,
         ssh_password=REMOTE_PASSWORD,
         remote_bind_address=('192.168.10.80', PORT),
         local_bind_address=('localhost', 10022))

server.start()

con = psycopg2.connect(user='s285905',
                 database='studs',
                 password='vjt9fZGAGQWvqis9',
                 host='localhost',
                 port=10022)

cur = con.cursor()

new_names = []
new_clubs = []
new_regions = []

def new_cortej(name, start=0, fin=None, limit=None):
    cortej = []
    end = 0
    with open(name, 'r') as f:
        for line in f:
            if limit is not None:
                if limit == end:
                    break
                end += 1
            
            if line.split():
                cortej.append(tuple(line.split()[start:fin]))
    return cortej

def union_2(item):
    res = (f"{item[0]} {item[1]}",) + item[2:]
    return res

def union(cortej):
    new_result = []
    for item in cortej:
        while len(item) > 1:
            item = union_2(item)
        new_result.append(tuple(item))

    return new_result

def add_winner(item):
    res = (f"{item[0]} winner",)
    return res

def add_mvp(item):
    res = (f"{item[0]} mvp",)
    return res

def event_winner(cortej):
    new_result = []
    for item in cortej:
        item = add_winner(item)
        new_result.append(tuple(item))

    return new_result

def event_mvp(cortej):
    new_result = []
    for item in cortej:
        item = add_mvp(item)
        new_result.append(tuple(item))

    return new_result


new_clubs = new_cortej("clubs.txt", 1, -1)
new_names = new_cortej("names.txt")
new_regions = new_cortej("regions.txt")
new_events = new_cortej("events.txt")
new_coach = new_cortej("surnames.txt", limit=len(new_clubs))


new_clubs = union(new_clubs)

new_events = union(new_events)

new_regions = union(new_regions)

new_trophy = event_winner(new_events)

new_achievement = event_mvp(new_events)


for idbd in range(len(new_clubs)):
    cur.execute("insert into club values (%s, %s)", (idbd, new_clubs[idbd]))

for idbd in range(len(new_regions)):
    cur.execute("insert into region values (%s, %s)", (idbd, new_regions[idbd]))

for idbd in range(len(new_clubs)):
    cur.execute("insert into region_club values (%s, %s)", (idbd, idbd % len(new_regions)))

for idbd in range(len(new_coach)):
    cur.execute("insert into coach values (%s, %s, %s)", (idbd, new_coach[idbd], idbd % len(new_clubs)))

for idbd in range(len(new_events)):
    cur.execute("insert into tournament values (%s, %s)", (idbd, new_events[idbd]))

for idbd in range(len(new_names)):
    cur.execute("insert into player values (%s, %s, %s)", (idbd, new_names[idbd], idbd % len(new_clubs)))

for idbd in range(len(new_clubs)):
    cur.execute("insert into rate values (%s, %s)", (idbd, idbd))

for idbd in range(len(new_events)):
    cur.execute("insert into trophy values (%s, %s, %s)", (idbd, new_trophy[idbd], idbd % len(new_coach)))

for idbd in range(len(new_names)):
    cur.execute("insert into player_trophy values (%s, %s)", (idbd, idbd % len(new_events)))

for idbd in range(len(new_events)):
    cur.execute("insert into achievements values (%s, %s)", (idbd, new_achievement[idbd]))


def add_ct(value):
    for i in range(len(new_trophy)):
        cur.execute("insert into club_tournament values (%s, %s)", (value, i))

for i in range(len(new_clubs)):
    add_ct(i)



con.commit()










