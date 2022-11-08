CREATE TABLE "public.Агентство" (
	"ID Агентства" serial NOT NULL,
	"Адрес" TEXT NOT NULL,
	CONSTRAINT "Агентство_pk" PRIMARY KEY ("ID Агентства")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Клиент" (
	"ID Клиента" serial NOT NULL,
	"ID Агентства" integer NOT NULL REFERENCES "public.Агентство" ("ID Агентства"),
	"ФИО" text NOT NULL,
	"Почта" text NOT NULL,
	"Телефон" text NOT NULL,
	CONSTRAINT "Клиент_pk" PRIMARY KEY ("ID Клиента")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Тур" (
	"ID Тура" serial NOT NULL,
	"Название" TEXT NOT NULL,
	"Планета или координаты" TEXT NOT NULL,
	"Продолжительность" TEXT NOT NULL,
	"Стоимость" TEXT NOT NULL,
	CONSTRAINT "Тур_pk" PRIMARY KEY ("ID Тура")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Персонал" (
	"ID Работника" serial NOT NULL,
	"ID Агентства" integer NOT NULL REFERENCES "public.Агентство" ("ID Агентства"),
	"ФИО" TEXT NOT NULL,
	"Должность" TEXT NOT NULL,
	CONSTRAINT "Персонал_pk" PRIMARY KEY ("ID Работника")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Заявка" (
	"ID Заявки" serial NOT NULL,
	"ID Клиента" integer NOT NULL REFERENCES "public.Клиент" ("ID Клиента"),
	"ID Работника" integer NOT NULL REFERENCES "public.Персонал" ("ID Работника"),
	"Дата подачи" TEXT NOT NULL,
	"Статус заявки" BOOLEAN NOT NULL DEFAULT '0',
	CONSTRAINT "Заявка_pk" PRIMARY KEY ("ID Заявки")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.Договор" (
	"ID Договора" serial NOT NULL,
	"ID Клиента" integer NOT NULL REFERENCES "public.Клиент" ("ID Клиента"),
	"ID Тура" integer NOT NULL REFERENCES "public.Тур" ("ID Тура"),
	"ID Работника" integer NOT NULL REFERENCES "public.Персонал" ("ID Работника"),
	"ID Заявки" integer NOT NULL REFERENCES "public.Заявка" ("ID Заявки"),
	"Дата заключения" DATE NOT NULL,
	"Дата начала тура" DATE NOT NULL,
	"Дата окончания тура" DATE NOT NULL,
	"Стоимость услуги" text NOT NULL,
	CONSTRAINT "Договор_pk" PRIMARY KEY ("ID Договора")
) WITH (
  OIDS=FALSE
);

INSERT INTO "public.Агентство"  VALUES (1, 'Ломоносова 9');
INSERT INTO "public.Агентство"  VALUES (2, 'Кронверкский 49');
INSERT INTO "public.Агентство"  VALUES (3, 'Биржевая 4-6');

INSERT INTO "public.Клиент"  VALUES (1, 2, 'Иван Попов Игоревич', 'test@ya.ru', '+7-961-558-72-55');
INSERT INTO "public.Клиент"  VALUES (2, 3, 'Иван Ильин Игоревич', 'test@mail.ru', '+7-800-558-72-55');
INSERT INTO "public.Клиент"  VALUES (3, 1, 'Александр Попов Игоревич', 'test@rum.ru', '+7-960-560-72-55');

INSERT INTO "public.Тур"  VALUES (1, 'На Юпитер', 'Юпитер', '5 лет', '10 000 долларов');
INSERT INTO "public.Тур"  VALUES (2, 'На Сатурн', 'Сатурн', '8 лет', '15 000 долларов');
INSERT INTO "public.Тур"  VALUES (3, 'На Плутон', '12 32 11 23', '15 лет', '50 000 долларов');

INSERT INTO "public.Персонал"  VALUES (1, 3, 'Иван Лосев Игоревич', 'Старший инспектор');
INSERT INTO "public.Персонал"  VALUES (2, 1, 'Кирилл Лосев Игоревич', 'Старший прапорщик');
INSERT INTO "public.Персонал"  VALUES (3, 2, 'Виталий Лосев Игоревич', 'Младший инспектор');

INSERT INTO "public.Заявка"  VALUES (1, 3, 2, '25.06.2020', '1');
INSERT INTO "public.Заявка"  VALUES (2, 2, 2, '25.08.2020', '1');
INSERT INTO "public.Заявка"  VALUES (3, 1, 2, '31.06.2020');

INSERT INTO "public.Договор"  VALUES (1, 1, 1, 1, 1, 'Jan-08-1999', 'Jan-08-1999', 'Jan-08-1999', '40 000 долларов');
INSERT INTO "public.Договор"  VALUES (2, 3, 3, 2, 3, 'Jan-08-1999', 'Jan-08-1999', 'Jan-08-1999', '30 000 долларов');
INSERT INTO "public.Договор"  VALUES (3, 2, 2, 2, 2, 'Jan-08-1999', 'Jan-08-1999', 'Jan-08-1999', '3 000 долларов');
