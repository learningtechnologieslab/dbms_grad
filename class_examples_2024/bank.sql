USE dmb72;

# customers (customer_id, f_name, l_name, dob, gender, phone1, phone2)
# accounts (account_number, routing_number, balance, account_type)
# transactions (transaction_id, datetime, origin_account_id, dest_account_id, amount)
# addresses (address_id, street1, street2, city, state, zip)

SELECT uuid();


CREATE TABLE accounts 
(account_number VARCHAR(36) PRIMARY KEY NOT NULL,
routing_number VARCHAR(36) NOT NULL, 
balance DOUBLE NOT NULL DEFAULT 0, 
account_type VARCHAR(20)
);

CREATE TABLE transactions (
transaction_id VARCHAR(36) PRIMARY KEY NOT NULL,
transaction_timestamp datetime NOT NULL, 
origin_account_id VARCHAR(36) NOT NULL, 
dest_account_id VARCHAR(36) NOT NULL, 
amount DOUBLE NOT NULL default 0);

CREATE TABLE customers(
	customer_id VARCHAR(36) PRIMARY KEY NOT NULL,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL
);

CREATE TABLE customer_accounts(
	fk_customer_id VARCHAR(36) NOT NULL,
    fk_account_id VARCHAR(36) NOT NULL
);

INSERT INTO accounts 
(account_number, routing_number, balance, account_type)
VALUES
(UUID(), UUID(), 5000000, 'checking');

INSERT INTO accounts 
(account_number, routing_number, balance, account_type)
VALUES
(UUID(), UUID(), 100, 'savings');


INSERT INTO customers (customer_id,f_name,l_name)
VALUES (UUID(), 'Dmitriy', 'Babichenko');

INSERT INTO customers (customer_id,f_name,l_name)
VALUES (UUID(), 'Pat', 'Healy');

SELECT * FROM customers;
SELECT * FROM accounts;

INSERT INTO customer_accounts(fk_customer_id, fk_account_id)
VALUES ('36b1965d-b956-11ee-8449-d2cf09eadf20', '08f1931a-b956-11ee-8449-d2cf09eadf20');


SELECT * FROM customer_accounts;
DELETE FROM customers WHERE customer_id = '36b1965d-b956-11ee-8449-d2cf09eadf20';