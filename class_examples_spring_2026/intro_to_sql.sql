#DROP DATABASE IF EXISTS dmb72;

#CREATE DATABASE IF NOT EXISTS dmb72;

USE dmb72;

# USE classicmodels;
# SHOW tables;

DROP TABLE IF EXISTS registration;
DROP TABLE IF EXISTS vehicle;

CREATE TABLE vehicle
(
	vehicle_id VARCHAR(36) NOT NULL PRIMARY KEY,
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    prod_year INT NOT NULL,
    body_type VARCHAR(100) NOT NULL
);


/*
CREATE TABLE IF NOT EXISTS registration(
	registration_id VARCHAR(36) NOT NULL PRIMARY KEY,
    fk_vehicle_id VARCHAR(36) NOT NULL,
    registration_date DATE NOT NULL
);

ALTER TABLE registration	
ADD CONSTRAINT 	
FOREIGN KEY (fk_vehicle_id)
REFERENCES vehicle(vehicle_id)
ON DELETE CASCADE	
ON UPDATE CASCADE;
*/




CREATE TABLE IF NOT EXISTS registration(
	registration_id VARCHAR(36) NOT NULL PRIMARY KEY,
    fk_vehicle_id VARCHAR(36) NOT NULL,
    registration_date DATE NOT NULL,
    CONSTRAINT FOREIGN KEY (fk_vehicle_id) REFERENCES vehicle(vehicle_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);


# Date functions
SELECT CURDATE();
SELECT NOW();


DESCRIBE vehicle;

INSERT INTO vehicle (vehicle_id, make, model, prod_year, body_type)
VALUES (uuid(), 'Ford', 'Escape', 2024, 'SUV');

INSERT INTO vehicle (vehicle_id, make, model, prod_year, body_type)
VALUES (uuid(), 'Hyundai', 'Santa Fe', 2024, 'SUV');

SELECT * FROM vehicle;

DESCRIBE registration;

INSERT INTO registration (registration_id, fk_vehicle_id, registration_date)
VALUES (uuid(), '33533231-fd54-11f0-ace5-fa52c99c4aae', CURDATE());

SELECT * FROM registration;

SET @vehicle_id = uuid();

INSERT INTO vehicle (vehicle_id, make, model, prod_year, body_type)
VALUES (@vehicle_id, 'Toyota', 'Camry', 2026, 'Sedan');

INSERT INTO registration (registration_id, fk_vehicle_id, registration_date)
VALUES (@vehicle_id, '33533231-fd54-11f0-ace5-fa52c99c4aae', CURDATE());



USE classicmodels;

SHOW tables;

# Get all columns and all rows from table
SELECT * FROM customers;

# Get subset of columns
SELECT customerNumber, customerName, phone, country FROM customers;

# Get subset of rows
SELECT customerNumber, customerName, phone, country FROM customers
WHERE country = 'USA';

SELECT customerNumber, customerName, phone, country FROM customers
WHERE country = 'USA' AND customerName LIKE '%Toys%';

# UPDATE STATEMENT
USE dmb72;
SELECT * FROM vehicle;

ALTER TABLE vehicle
ADD COLUMN color VARCHAR(20) NOT NULL;

DESCRIBE vehicle;

UPDATE vehicle SET color = 'blue';

SELECT * FROM vehicle WHERE vehicle_id = '33533231-fd54-11f0-ace5-fa52c99c4aae';

UPDATE vehicle SET color = 'red' WHERE vehicle_id = '33533231-fd54-11f0-ace5-fa52c99c4aae';

UPDATE vehicle SET color = 'green', model = 'Expedition' 
WHERE vehicle_id = '33533231-fd54-11f0-ace5-fa52c99c4aae';

SELECT * FROM vehicle WHERE vehicle_id = '33533231-fd54-11f0-ace5-fa52c99c4aae';
DELETE FROM vehicle  WHERE vehicle_id = '33533231-fd54-11f0-ace5-fa52c99c4aae';

SELECT * FROM registration;

INSERT INTO registration (registration_id, fk_vehicle_id, registration_date)
VALUES (@vehicle_id, '33576851-fd54-11f0-ace5-fa52c99c4aae', CURDATE());

DELETE FROM vehicle WHERE vehicle_id != '33576851-fd54-11f0-ace5-fa52c99c4aae';
