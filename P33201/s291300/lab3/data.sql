-- ----------------------------
-- Records of cinema
-- ----------------------------
INSERT INTO "cinema" VALUES ('1', 'Cinemart Cinemas', '106-03 Metropolitan Ave, Queens, NY 11375, United States');
INSERT INTO "cinema" VALUES ('2', 'Alamo Drafthouse Cinema', '445 Albee Square W 4th floor, Brooklyn, NY 11201, United States');
INSERT INTO "cinema" VALUES ('3', 'College Point Multiplex Cinemas', '2855 Ulmer St, Queens, NY 11357, United States');
INSERT INTO "cinema" VALUES ('4', 'Alpine Cinema', '6817 5th Ave, Brooklyn, NY 11220, United States');
INSERT INTO "cinema" VALUES ('5', 'Concourse Plaza Multiplex Cinemas', '214 E 161 St, The Bronx, NY 10451, United States');

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO "client" VALUES ('1', 'admin', '123', '365166709@gmail.com', 'img/head/admin.jpg');
INSERT INTO "client" VALUES ('2', 'fyf', '123', '2569548856@hotmail.com', 'img/head/fyf.jpg');
INSERT INTO "client" VALUES ('3', 'test1', '123', 'zms@qq.com', 'img/head/zms.jpg');
INSERT INTO "client" VALUES ('4', 'gg', '123', 'liuyang@163.com', 'img/head/ly.jpg');
INSERT INTO "client" VALUES ('5', 'test2', '123', 'test@tt.com', 'img/head/tt.jpg');

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO "movie" VALUES ('1', 'Venom', 'Ruben Fleischer', 'In the film, struggling journalist Brock gains superpowers after becoming the host of an alien symbiote, Venom, whose species plans to invade Earth.', '112', 'Action,Sci-fi', '9.3', 'img/movies/movie1.jpg', '14.86', '66.8', '2018-11-09', '100000000', 'America', '10000');
INSERT INTO "movie" VALUES ('2', 'Fantastic Beasts', 'David Yates', 'Set in 1927, it follows Newt Scamander and Albus Dumbledore as they attempt to take down the dark wizard Gellert Grindelwald while facing new threats in a more divided wizarding world.', '134', 'Fantasy,Adventure', '7.7', 'img/movies/movie2.jpg', '2.92', '90291', '2018-11-16', '100000000', 'Britain', '1');
INSERT INTO "movie" VALUES ('3', 'Case Closed: Zero the Enforcer', 'Yuzuru Tachikawa', 'Located in Tokyo Bay, the newly built integrated resort and convention center "Edge of Ocean" is going to host an upcoming Summit Meeting. ', '111', 'animation, action', '8.5', 'img/movies/movie4.jpg', '1.22', '95339', '2018-11-09', '100000000', 'Japan', '1');

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO "comments" VALUES ('1', '1', 'Such a good movie!', '1');
INSERT INTO "comments" VALUES ('2', '2', 'I love this movie!', '2');
INSERT INTO "comments" VALUES ('3', '3', 'No doubt great mobie!', '2');
INSERT INTO "comments" VALUES ('4', '4', 'So bad!', '3');
INSERT INTO "comments" VALUES ('5', '1', 'Looking forward next movie!', '3');

-- ----------------------------
-- Records of hall
-- ----------------------------
INSERT INTO "hall" VALUES ('1', 'Hall number one', '1', '30');
INSERT INTO "hall" VALUES ('2', 'Hall number two', '1', '30');
INSERT INTO "hall" VALUES ('3', 'Hall number three', '1', '30');
INSERT INTO "hall" VALUES ('4', 'Hall number one', '2', '30');
INSERT INTO "hall" VALUES ('5', 'Hall number two', '2', '30');

-- ----------------------------
-- Records of session
-- ----------------------------
INSERT INTO "session" VALUES ('1', '1', '1', '1', '2022-11-28', '20:30:00', '43');
INSERT INTO "session" VALUES ('2', '2', '1', '2', '2022-11-30', '20:50:00', '43');
INSERT INTO "session" VALUES ('3', '1', '1', '3', '2022-11-30', '10:30:00', '38');
INSERT INTO "session" VALUES ('4', '1', '2', '2', '2022-11-30', '19:45:00', '39');
INSERT INTO "session" VALUES ('5', '2', '2', '3', '2022-11-30', '19:45:00', '39');

-- ----------------------------
-- Records of ticket
-- ----------------------------
INSERT INTO "ticket" VALUES ('1', '1', '2', '2', 'R1');
INSERT INTO "ticket" VALUES ('2', '1', '2', '2', 'P2');
INSERT INTO "ticket" VALUES ('3', '1', '2', '2', 'I1');
INSERT INTO "ticket" VALUES ('4', '1', '2', '2', 'R13');
INSERT INTO "ticket" VALUES ('5', '1', '2', '2', 'J10');

-- ----------------------------
-- Records of order_record
-- ----------------------------
INSERT INTO "order_record" VALUES ('1','1','1');
INSERT INTO "order_record" VALUES ('2','2','1');
INSERT INTO "order_record" VALUES ('3','3','2');
INSERT INTO "order_record" VALUES ('4','4','2');
INSERT INTO "order_record" VALUES ('5','5','2');

-- ----------------------------
-- Records of remaining_seat_matrix
-- ----------------------------
INSERT INTO "remaining_seat_matrix" VALUES ('1','5','6','000010101010100000100010000110');
INSERT INTO "remaining_seat_matrix" VALUES ('2','5','6','000010101010100000100010000110');
INSERT INTO "remaining_seat_matrix" VALUES ('3','5','6','000010101010100000100010000110');
INSERT INTO "remaining_seat_matrix" VALUES ('4','5','6','000010101010100000100010000110');
INSERT INTO "remaining_seat_matrix" VALUES ('5','5','6','000010101010100000100010000110');

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO "role" VALUES ('1', 'ADMIN');
INSERT INTO "role" VALUES ('2', 'USER');
INSERT INTO "role" VALUES ('3', 'VIP');
INSERT INTO "role" VALUES ('4', 'USER');
INSERT INTO "role" VALUES ('5', 'VIP');
