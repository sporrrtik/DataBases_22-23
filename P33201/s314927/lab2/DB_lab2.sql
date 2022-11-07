CREATE TABLE "public.Космический корабль" (
	"spaceship_id" serial NOT NULL,
	"Название" VARCHAR(255) NOT NULL UNIQUE,
	"Дата вылета" DATE NOT NULL,
	CONSTRAINT "Космический корабль_pk" PRIMARY KEY ("spaceship_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Оборудование" (
	"tech_id" serial NOT NULL,
	"spaceship_id" integer REFERENCES "public.Космический корабль" ("spaceship_id"),
	"название" VARCHAR(255) NOT NULL,
	"дата обслуживания" DATE NOT NULL,
	"состояние" BOOLEAN NOT NULL,
	CONSTRAINT "Оборудование_pk" PRIMARY KEY ("tech_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Скорость" (
	"speed_id" serial NOT NULL,
	"spaceship_id" integer REFERENCES "public.Космический корабль" ("spaceship_id"),
	"дата" DATE NOT NULL,
	"время" TIME NOT NULL,
	"значение" FLOAT,
	CONSTRAINT "Скорость_pk" PRIMARY KEY ("speed_id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.Температура" (
	"temperature_id" serial NOT NULL,
	"spaceship_id" integer REFERENCES "public.Космический корабль" ("spaceship_id"),
	"дата" DATE NOT NULL,
	"время" TIME NOT NULL,
	"значение" FLOAT,
	CONSTRAINT "Температура_pk" PRIMARY KEY ("temperature_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Продукты" (
	"product-id" serial NOT NULL,
	"spaceship_id" integer REFERENCES "public.Космический корабль" ("spaceship_id"),
	"название" VARCHAR(255) NOT NULL,
	"дата изготовления" DATE NOT NULL,
	"срок годности" DATE NOT NULL,
	CONSTRAINT "Продукты_pk" PRIMARY KEY ("product-id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Персонал" (
	"worker_id" serial NOT NULL,
	"spaceship_id" integer REFERENCES "public.Космический корабль" ("spaceship_id"),
	"фамилия" VARCHAR(255) NOT NULL,
	"имя" VARCHAR(255) NOT NULL,
	"отчество" VARCHAR(255) NOT NULL,
	"дата рождения" DATE NOT NULL,
	"дата найма" DATE NOT NULL,
	"должность" VARCHAR(255) NOT NULL,
	CONSTRAINT "Персонал_pk" PRIMARY KEY ("worker_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Пассажир" (
	"traveller_id" serial NOT NULL,
	"фамилия" VARCHAR(255) NOT NULL,
	"имя" VARCHAR(255) NOT NULL,
	"отчество" VARCHAR(255) NOT NULL,
	"дата рождения" DATE NOT NULL,
	"документ" VARCHAR(255) NOT NULL,
	CONSTRAINT "Пассажир_pk" PRIMARY KEY ("traveller_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.Билет" (
	"ticket_id" serial NOT NULL,
	"spaceship_id" serial REFERENCES "public.Космический корабль" ("spaceship_id"),
	"traveller_id" serial REFERENCES "public.Пассажир" ("traveller_id"),
	"пункт отправления" VARCHAR(255) NOT NULL,
	"пункт прибытия" VARCHAR(255) NOT NULL,
	"дата покупки" DATE NOT NULL,
	"стоимость" FLOAT NOT NULL,
	CONSTRAINT "Билет_pk" PRIMARY KEY ("ticket_id")
) WITH (
  OIDS=FALSE
);

INSERT INTO "public.Космический корабль" VALUES
    (1, 'Дискавери', '03.03.2023');

INSERT INTO "public.Космический корабль" VALUES
    (2, 'Навуходоносор', '01.02.2012');

INSERT INTO "public.Оборудование" VALUES
    (1, 1, 'Камера', '02.03.2010', TRUE);

INSERT INTO "public.Оборудование" VALUES
    (2, 1, 'Холодильник', '02.03.2010', TRUE);

INSERT INTO "public.Оборудование" VALUES
    (3, 1, 'Утюг', '02.03.2010', FALSE);

INSERT INTO "public.Скорость" VALUES
    (1, 1, '03.03.2023', '12:00:02', 1234.00);

INSERT INTO "public.Температура" VALUES
    (1, 1, '03.03.2023', '12:00:02', 273);

INSERT INTO "public.Продукты" VALUES
    (1, 1, 'Вода','01.03.2023', '01.03.2026');
INSERT INTO "public.Продукты" VALUES
    (2, 1, 'Гречка','01.03.2023', '01.03.2026');
INSERT INTO "public.Продукты" VALUES
    (3, 1, 'Рис','01.03.2023', '01.03.2026');

INSERT INTO "public.Персонал" VALUES
    (1, 1, 'Иванов', 'Иван', 'Иванович', '01.01.1990', '16.01.2018', 'Пилот');
INSERT INTO "public.Персонал" VALUES
    (2, 1, 'Петров', 'Петр', 'Петрович', '02.02.1991', '16.02.2018', 'Второй пилот');
INSERT INTO "public.Персонал" VALUES
    (3, 1, 'Васильева', 'Мария', 'Викторовна', '03.03.1992', '19.01.2018', 'Повар');
INSERT INTO "public.Персонал" VALUES
    (4, 1, 'Кимчи', 'Евгения', 'Васильевна', '04.04.1993', '16.03.2018', 'Слесарь');

INSERT INTO "public.Пассажир" VALUES
    (1, 'Ди', 'Леонардо', 'Каприо', '02.08.1978', 'паспорт серия 0000 номер 123456');
INSERT INTO "public.Пассажир" VALUES
    (2, 'Карлов', 'Карл', 'Карлович', '07.12.1989', 'паспорт серия 1010 номер 039827');

INSERT INTO "public.Билет" VALUES
    (1, 1, 1, 'Земля', 'Юпитер', '02.08.2020', 1284903);
INSERT INTO "public.Билет" VALUES
    (2, 1, 2, 'Земля', 'Юпитер', '07.12.2021', 2849031);