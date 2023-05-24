CREATE TABLE games (
	id int,
	title text,
	release_date int,
	genre_id int,
	platform_id int
);

CREATE TABLE players (
	id int,
	username text
);

CREATE TABLE developers (
	id int,
	name text,
	office_room_id int
);

CREATE TABLE officerooms (
	id int,
	room_name text
);

CREATE TABLE sales (
	id int,
	game_id int,
	player_id int,
	sale_date int,
	price int
);

CREATE TABLE genres (
	id int,
	name text
);

CREATE TABLE platforms (
	id int,
	name text
);

CREATE TABLE ratings (
	id int,
	game_id int,
	player_id int,
	rating int
);

CREATE TABLE developed_by (
	developer_id int,
	game_id int
);










