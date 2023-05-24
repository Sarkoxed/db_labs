CREATE TABLE `games` (
	`id` int NOT NULL,
	`title` TEXT NOT NULL,
	`release_date` int NOT NULL,
	`genre_id` int NOT NULL,
	`platform_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `players` (
	`id` int NOT NULL,
	`username` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `developers` (
	`id` int NOT NULL,
	`name` TEXT NOT NULL,
	`office_room_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `officerooms` (
	`id` int NOT NULL,
	`room_name` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `sales` (
	`id` int NOT NULL,
	`game_id` int NOT NULL,
	`player_id` int NOT NULL,
	`sale_date` int NOT NULL,
	`price` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `genres` (
	`id` int NOT NULL,
	`name` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `platforms` (
	`id` int NOT NULL,
	`name` TEXT NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `ratings` (
	`id` int NOT NULL,
	`game_id` int NOT NULL,
	`player_id` int NOT NULL,
	`rating` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `developed_by` (
	`developer_id` int NOT NULL,
	`game_id` int NOT NULL,
	PRIMARY KEY (`developer_id`,`game_id`)
);

ALTER TABLE `games` ADD CONSTRAINT `games_fk0` FOREIGN KEY (`genre_id`) REFERENCES `genres`(`id`);

ALTER TABLE `games` ADD CONSTRAINT `games_fk1` FOREIGN KEY (`platform_id`) REFERENCES `platforms`(`id`);

ALTER TABLE `developers` ADD CONSTRAINT `developers_fk0` FOREIGN KEY (`office_room_id`) REFERENCES `officerooms`(`id`);

ALTER TABLE `sales` ADD CONSTRAINT `sales_fk0` FOREIGN KEY (`game_id`) REFERENCES `games`(`id`);

ALTER TABLE `sales` ADD CONSTRAINT `sales_fk1` FOREIGN KEY (`player_id`) REFERENCES `players`(`id`);

ALTER TABLE `ratings` ADD CONSTRAINT `ratings_fk0` FOREIGN KEY (`game_id`) REFERENCES `games`(`id`);

ALTER TABLE `ratings` ADD CONSTRAINT `ratings_fk1` FOREIGN KEY (`player_id`) REFERENCES `players`(`id`);

ALTER TABLE `developed_by` ADD CONSTRAINT `developed_by_fk0` FOREIGN KEY (`developer_id`) REFERENCES `developers`(`id`);

ALTER TABLE `developed_by` ADD CONSTRAINT `developed_by_fk1` FOREIGN KEY (`game_id`) REFERENCES `games`(`id`);










