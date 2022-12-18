CREATE TABLE "achievement" (
  "id" int4 NOT NULL,
  "title" varchar(50) NOT NULL,
  "description" text,
  "aсquired_date" date NOT NULL,
  "player_id" int4,
  PRIMARY KEY ("id")
);

CREATE TABLE "chat" (
  "id" int4 NOT NULL,
  "title" varchar(60) NOT NULL,
  "creation_date" date NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "developer" (
  "id" int4 NOT NULL,
  "name" varchar(60) NOT NULL,
  "country" varchar(30),
  "creation_date" date NOT NULL,
  "ceo" varchar(60),
  PRIMARY KEY ("id")
);

CREATE TABLE "dlc" (
  "id" int4 NOT NULL,
  "name" varchar(30) NOT NULL,
  "description" text,
  "creation_date" date,
  "parent_id" int4 NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "game" (
  "id" int4 NOT NULL,
  "name" varchar(30) NOT NULL,
  "creation_date" date NOT NULL,
  "description" text,
  "genre" varchar(30) NOT NULL,
  "developer_id" int4 NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "item" (
  "id" int4 NOT NULL,
  "name" varchar(30) NOT NULL,
  "description" text,
  "img_url" varchar(100) NOT NULL,
  "user_id" int4 NOT NULL,
  "game_id" int4 NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "message" (
  "id" int8 NOT NULL,
  "chat_id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "content" text NOT NULL,
  "send_datetime" timestamp NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "paper" (
  "id" int4 NOT NULL,
  "title" varchar(30) NOT NULL,
  "author" varchar(30) NOT NULL,
  "game_id" int4 NOT NULL,
  "creation_date" date NOT NULL,
  "content" text NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "review" (
  "id" int4 NOT NULL,
  "user_id" int4 NOT NULL,
  "game_id" int4 NOT NULL,
  "content" text,
  "rating" int2 NOT NULL,
  "creation_date" date NOT NULL,
  "like_count" int4,
  "dislike_count" int4,
  PRIMARY KEY ("id")
);

CREATE TABLE "user" (
  "id" int4 NOT NULL,
  "name" varchar(30) NOT NULL,
  "status" varchar(60),
  "avatar_url" varchar(100),
  "creation_date" date NOT NULL,
  PRIMARY KEY ("id")
);

CREATE TABLE "user_chat" (
  "user_id" int4 NOT NULL,
  "chat_id" int4 NOT NULL
);

CREATE TABLE "user_game" (
  "user_id" int4 NOT NULL,
  "game_id" int4 NOT NULL
);

ALTER TABLE "achievement" ADD CONSTRAINT "fk_achievement_user_1" FOREIGN KEY ("player_id") REFERENCES "user" ("id");
ALTER TABLE "dlc" ADD CONSTRAINT "fk_DLC_game_1" FOREIGN KEY ("parent_id") REFERENCES "game" ("id");
ALTER TABLE "game" ADD CONSTRAINT "fk_game_developer_1" FOREIGN KEY ("developer_id") REFERENCES "developer" ("id");
ALTER TABLE "item" ADD CONSTRAINT "fk_item_user_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "item" ADD CONSTRAINT "fk_item_game_1" FOREIGN KEY ("game_id") REFERENCES "game" ("id");
ALTER TABLE "message" ADD CONSTRAINT "fk_message_chat_1" FOREIGN KEY ("chat_id") REFERENCES "chat" ("id");
ALTER TABLE "message" ADD CONSTRAINT "fk_message_user_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "paper" ADD CONSTRAINT "fk_paper_game_1" FOREIGN KEY ("game_id") REFERENCES "game" ("id");
ALTER TABLE "review" ADD CONSTRAINT "fk_review_user_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "review" ADD CONSTRAINT "fk_review_game_1" FOREIGN KEY ("game_id") REFERENCES "game" ("id");
ALTER TABLE "user_chat" ADD CONSTRAINT "fk_user_chat_user_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_chat" ADD CONSTRAINT "fk_user_chat_chat_1" FOREIGN KEY ("chat_id") REFERENCES "chat" ("id");
ALTER TABLE "user_game" ADD CONSTRAINT "fk_user_game_user_1" FOREIGN KEY ("user_id") REFERENCES "user" ("id");
ALTER TABLE "user_game" ADD CONSTRAINT "fk_user_game_game_1" FOREIGN KEY ("game_id") REFERENCES "game" ("id");

