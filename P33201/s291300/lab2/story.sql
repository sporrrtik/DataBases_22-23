CREATE TABLE "Human" (
	"ID" serial,
	"Name" varchar(32) NOT NULL,
	"Gender" Integer NOT NULL,
	PRIMARY KEY ("ID")
);
CREATE TABLE "Object" (
	"ID" serial,
	"Name" varchar(32) NOT NULL,
	PRIMARY KEY ("ID")
);
CREATE TABLE "Action" (
	"ID" serial,
	"ID_Human_From" Integer REFERENCES "Human",
	"ID_Human_To" Integer REFERENCES "Human",
	"Description" varchar(64) NOT NULL,
	PRIMARY KEY ("ID")
);
CREATE TABLE "Usage" (
	"ID" serial,
	"ID_Human" Integer REFERENCES "Human",
	"ID_Object" Integer REFERENCES "Object",
	"Description" varchar(64) NOT NULL,
	PRIMARY KEY ("ID")
);
CREATE TABLE "Event" (
	"ID" serial,
	"ID_Object_From" Integer REFERENCES "Object",
	"ID_Object_To" Integer REFERENCES "Object",
	"Description" varchar(64) NOT NULL,
	PRIMARY KEY ("ID")
);
INSERT INTO "Human" ("Name", "Gender")
VALUES ('Грант', 1),
	('Лекси', 0),
	('Тим', 1),
	('Алан', 1);
INSERT INTO "Object" ("Name")
VALUES ('лодка'),
	('спасательный жилет'),
	('причал'),
	('лагуна'),
	('весло'),
	('уключина');
INSERT INTO "Action" ("ID_Human_From", "ID_Human_To", "Description")
VALUES (1, 2, 'поманил пальцем'),
	(2, 1, 'бесшумно подошла'),
	(1, 2, 'жестом приказал ей садиться в лодку');
INSERT INTO "Usage" ("ID_Human", "ID_Object", "Description")
VALUES (3, 1, 'уселся'),
	(3, 2, 'надели'),
	(2, 2, 'надели'),
	(1, 1, 'спрыгнул'),
	(1, 3, 'оттолкнулся'),
	(1, 5, 'взял');
INSERT INTO "Event" (
		"ID_Object_From",
		"ID_Object_To",
		"Description"
	)
VALUES (1, 4, 'бесшумно поплыла внутрь'),
	(2, 1, 'бесшумно подошла'),
	(1, 2, 'жестом приказал ей садиться в лодку'),
	(1, 3, 'удалялась от');


INSERT INTO "Usage" ("ID_Human", "ID_Object", "Description")
VALUES (4, 5, 'взял');
INSERT INTO "Event" (
		"ID_Object_From",
		"ID_Object_To",
		"Description"
	)
VALUES (5, 6, 'вставил');