DROP DATABASE IF EXISTS cda_final_charles;
CREATE DATABASE IF NOT EXISTS cda_final_charles;
USE cda_final_charles;

DROP TABLE IF EXISTS game;
CREATE TABLE game (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(255),
    min_players INT,
    max_players INT
);

DROP TABLE IF EXISTS player;
CREATE TABLE player (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email VARCHAR(255),
    nickname VARCHAR(255)
);

DROP TABLE IF EXISTS contest;
CREATE TABLE contest (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    game_id INT,
    start_date DATE,
    winner_id INT NULL
);

DROP TABLE IF EXISTS player_contest;
CREATE TABLE player_contest (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    player_id INT,
    contest_id INT
);

ALTER TABLE contest ADD CONSTRAINT FK_contest_game_id FOREIGN KEY (game_id) REFERENCES game(id);
ALTER TABLE contest ADD CONSTRAINT FK_contest_winner_id FOREIGN KEY (winner_id) REFERENCES player(id);
ALTER TABLE player_contest ADD CONSTRAINT FK_player_contest_player_id FOREIGN KEY (player_id) REFERENCES player(id);
ALTER TABLE player_contest ADD CONSTRAINT FK_player_contest_contest_id FOREIGN KEY (contest_id) REFERENCES contest(id);

INSERT INTO game (id, title, min_players, max_players) VALUES (23, "7 Wonders", 2, 7),(24, "Ticket To Ride", 2, 5),(25, "Pandemic", 2, 4),(26, "Munchkin", 3, 6);
INSERT INTO player (email, nickname) VALUES ("luke.skywalker@rogue.sw", "Luke"),("amidala.padme@naboo.gov", "Padme"),("han.solo@millenium-falcon.com", "HanSolo"),("chewbacca@wook.ie", "Chewbie"),("rey@jakku.planet", "Rey");
INSERT INTO contest (game_id, start_date, winner_id) VALUES (23, "2019-12-25", 2), (25, "2020-12-25", null);
INSERT INTO player_contest (player_id, contest_id) VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(2,2),(3,2),(5,2);