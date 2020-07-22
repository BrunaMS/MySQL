-- This database contains the user data of a imaginary juice company
-- According to the company owner, the main data to them is:
-- CPF, Complete name, Address, date of birth, age, genre
-- Credit limit to buy products, minimum volume of juices, if had already made a purchase

USE JUICES;

-- -------------------- CREATING TABLES AND FIELDS -------------------- --

CREATE TABLE IF NOT EXISTS BCLIENTS
(cpf VARCHAR(11), 
name VARCHAR(100),
address_1 VARCHAR(150),
address_2 VARCHAR(150),
neighborhood VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code VARCHAR(8),
age SMALLINT,
genre VARCHAR(1),
credit_limit FLOAT,
vol_purchases FLOAT,
already_bougth BIT(1));

-- They need a control of the salespeople too.alter
-- What we know about them is: registration id, name and percent of commission.

CREATE TABLE IF NOT EXISTS TBSALES
(registration CHAR(5), 
name VARCHAR(100),
commission_percent FLOAT);

-- Seeing that we are making a database related to a juices store, we need some data about the products too

CREATE TABLE IF NOT EXISTS TBPRODUCTS
(product_cod VARCHAR(20), 
name VARCHAR(100), 
package VARCHAR(50),
size VARCHAR(50),
taste VARCHAR(50),
price FLOAT);

-- -------------------- INSERTING DATA (RECORDS/ROWS) INTO TABLES -------------------- --

-- To insert data into the table, we are using a file
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('1040107', 'Light - 350 ml - Melancia', 'Lata', '350 ml', 'Melancia', 4.56);

-- SELECT * FROM TBPRODUCTS;

INSERT INTO TBSALES (registration, name, commission_percent)
VALUES('00233', 'Joao Geraldo da Fonseca', 0.1);

-- SELECT * FROM TBSALES; 

-- -----------------

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('1037797', 'Clean - 2 Litros - Laranja', 'PET', '2 L', 'Laranja', 16.01);

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('1000889', 'Sabor da Montanha - 700 ml - Uva', 'Garrafa', '700 ml', 'Uva', 6.31);

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('1004327', 'Videira do Campo - 1,5 Litros - Melância', 'PET', '1.5 L', 'Melancia', 19.51);

-- SELECT * FROM TBPRODUCTS;

-- -----------------

INSERT INTO TBSALES (registration, name, commission_percent)
VALUES('00235', 'Marcio Almeida Silva', 0.08);

INSERT INTO TBSALES (registration, name, commission_percent)
VALUES('00236', 'Claudia Morais', 0.08);

-- SELECT * FROM TBSALES;

-- -------------------- CHANGING TABLE CONTENTS -------------------- --

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('544931', 'Frescor do Verão - 350 ml - Limão', 'PET', '350 ml','Limão',3.20);

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('1078680', 'Frescor do Verão - 470 ml - Manga', 'Lata', '470 ml','Manga',5.18);

UPDATE TBPRODUCTS SET package = 'Lata', price = 2.46 
WHERE product_cod = '544931';

UPDATE TBPRODUCTS SET package = 'Garrafa'
WHERE product_cod = '544931';

-- SELECT * FROM TBPRODUCTS;

-- ---------------------

UPDATE TBSALES SET commission_percent = 0.11
WHERE registration = '00236';

UPDATE TBSALES SET name = 'Jose Geraldo da Fonseca'
WHERE registration = '00233';

SELECT * FROM TBSALES;

-- -------------------- REMOVING DATA FROM TABLES -------------------- --

DELETE FROM TBPRODUCTS WHERE product_cod = '1078680';

-- SELECT * FROM TBPRODUCTS;

-- ---------------------

DELETE FROM TBSALES WHERE registration = '00233';

-- -------------------- INCLUDING PRIMARY KEYS -------------------- --

ALTER TABLE TBPRODUCTS ADD PRIMARY KEY (product_cod);

SELECT * FROM TBPRODUCTS;

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
VALUES('544931', 'Frescor do Verão - 350 ml - Limão', 'Lata', '350 ml','Limão',2.46);

-- -------------------- MANIPULATING DATA (TYPES DATE AND LOGIC) -------------------- --

ALTER TABLE TBCLIENTS ADD PRIMARY KEY (cpf);

ALTER TABLE TBCLIENTS ADD COLUMN (date_of_birth DATE);

INSERT INTO TBCLIENTS(cpf, name, address_1, address_2, neighborhood, city, 
state, zip_code, age, genre, credit_limit, vol_purchases, already_bougth, date_of_birth)
VALUES('05768415898', 'John da Silva', 'Rua projetada A nro 10', '', 'Vila Roma', 'Caratinda', 
'Amazonas', '2222222', 30, 'M', 10000.00, 2000, 0, '1989-10-05'); -- 'yyyy-mm-dd'

SELECT * FROM TBCLIENTS;

-- ----------------------

ALTER TABLE TBSALES ADD COLUMN (admission_date DATE, vacation BIT);

ALTER TABLE TBSALES ADD PRIMARY KEY(registration);

INSERT INTO TBSALES (registration, name, commission_percent, admission_date, vacation)
VALUES('00235', 'Marcio Almeida Silva', 0.08, '2014-08-15', 0);

INSERT INTO TBSALES (registration, name, commission_percent, admission_date, vacation)
VALUES('00236', 'Claudia Morais', 0.08, '2013-09-13', 1);

INSERT INTO TBSALES (registration, name, commission_percent, admission_date, vacation)
VALUES('00237', 'Roberta Martins', 0.08, '2013-09-17', 1);

INSERT INTO TBSALES (registration, name, commission_percent, admission_date, vacation)
VALUES('00238', 'Pericles Alves', 0.11, '2016-08-21', 0);

DELETE FROM TBSALES WHERE admission_date IS NULL;

SELECT * FROM TBSALES