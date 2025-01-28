# CREATE DATABASE monkeys;

#SELECT * FROM products;
#SELECT * FROM classicmodels.products;

USE monkeys;

#USE classicmodels;
#SHOW tables;
DROP TABLE IF EXISTS monkey_food;
CREATE TABLE IF NOT EXISTS monkey_food(
	food_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    food_name VARCHAR(100) NOT NULL,
    weight DOUBLE NOT NULL,
    calories DOUBLE NOT NULL,
    likeability_scale INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

DROP TABLE IF EXISTS monkeys;
CREATE TABLE IF NOT EXISTS monkeys(
	monkey_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    monkey_name VARCHAR(100) NOT NULL,
    dob DATETIME
);

ALTER TABLE monkeys
ADD COLUMN species VARCHAR(50) NOT NULL;

DROP TABLE IF EXISTS monkey_likes_foods;
CREATE TABLE IF NOT EXISTS monkey_likes_foods(
	fk_monkey_id INT NOT NULL,
    fk_food_id INT NOT NULL,
    FOREIGN KEY(fk_monkey_id) 
    REFERENCES monkeys(monkey_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY (fk_food_id)
    REFERENCES monkey_food (food_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO monkeys (monkey_name, dob, species)
VALUES ('Fred', '2020-01-01', 'Silveback Gorilla');

INSERT INTO monkeys (monkey_id, monkey_name, dob, species)
VALUES (5, 'Petunia', '2019-01-01', 'Silveback Gorilla');

INSERT INTO monkeys (monkey_name, dob, species)
VALUES ('Dot', '2025-01-01', 'Silveback Gorilla');

ALTER TABLE monkey_food
DROP COLUMN likeability_scale;

ALTER TABLE monkey_likes_foods
ADD COLUMN likeability_scale INT NOT NULL DEFAULT 0;

INSERT INTO monkey_food(food_name, weight, calories)
VALUES ('Bananas', 100, 150);

INSERT INTO monkey_food(food_name, weight, calories)
VALUES 
('Grapes', 10, 25),
('Crickets', 10, 250),
('Apples', 150, 100);

INSERT INTO monkey_likes_foods(fk_monkey_id, fk_food_id, likeability_scale)
VALUES 
(1, 1, 100),
(1, 3, 75),
(5, 2, 100);