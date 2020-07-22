-- This database contains the user data of a imaginary juice company
-- According to the company owner, the main data to them is:
-- CPF, Complete name, Address, date of birth, age, genre
-- Credit limit to buy products, minimum volume of juices, if had already made a purchase

USE JUICES;
DROP TABLE TBPRODUCTS;
DROP TABLE TBCLIENTS;
DROP TABLE TBSALES;

-- -------------------- CREATING TABLES AND FIELDS -------------------- --

CREATE TABLE IF NOT EXISTS TBCLIENTS
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

-- INSERT INTO TBSALES (registration, name, commission_percent)
-- VALUES('00235', 'Marcio Almeida Silva', 0.08);

-- INSERT INTO TBSALES (registration, name, commission_percent)
-- VALUES('00236', 'Claudia Morais', 0.08);

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

-- INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price)
-- VALUES('544931', 'Frescor do Verão - 350 ml - Limão', 'Lata', '350 ml','Limão',2.46);

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

-- SELECT * FROM TBSALES

 -- -------------------- CONSULTING DATA FROM TABLES -------------------- --
DROP TABLE TBCLIENTS;

DROP TABLE TBPRODUCTS;

CREATE TABLE TBCLIENTS
(cpf VARCHAR (11) ,
name VARCHAR (100) ,
address_1 VARCHAR (150) ,
address_2 VARCHAR (150) ,
neighborhood VARCHAR (50) ,
city VARCHAR (50) ,
state VARCHAR (2) ,
zip_code VARCHAR (8) ,
date_of_birth DATE,
age SMALLINT,
genre VARCHAR (1) ,
credit_limit FLOAT ,
vol_purchases FLOAT ,
first_purchase BIT, 
PRIMARY KEY (cpf));

CREATE TABLE TBPRODUCTS
(product_cod VARCHAR (20) ,
name VARCHAR (150) ,
package VARCHAR(50) ,
size VARCHAR (50) ,
taste VARCHAR (50) ,
price FLOAT,
PRIMARY KEY (product_cod));

INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('19290992743','Fernando Cavalcante','R. Dois de Fevereiro','','Água Santa','Rio de Janeiro','RJ','22000000','2000-02-12',18,'M',100000,200000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('2600586709','César Teixeira','Rua Conde de Bonfim','','Tijuca','Rio de Janeiro','RJ','22020001','2000-03-12',18,'M',120000,220000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('95939180787','Fábio Carvalho','R. dos Jacarandás da Península','','Barra da Tijuca','Rio de Janeiro','RJ','22002020','1992-01-05',16,'M',90000,180000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('9283760794','Edson Meilelles','R. Pinto de Azevedo','','Cidade Nova','Rio de Janeiro','RJ','22002002','1995-10-07',22,'M',150000,250000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('7771579779','Marcelo Mattos','R. Eduardo Luís Lopes','','Brás','São Paulo','SP','88202912','1992-03-25',25,'M',120000,200000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('5576228758','Petra Oliveira','R. Benício de Abreu','','Lapa','São Paulo','SP','88192029','1995-11-14',22,'F',70000,160000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('8502682733','Valdeci da Silva','R. Srg. Édison de Oliveira','','Jardins','São Paulo','SP','82122020','1995-10-07',22,'M',110000,190000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('1471156710','Érica Carvalho','R. Iriquitia','','Jardins','São Paulo','SP','80012212','1990-09-01',27,'F',170000,245000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('3623344710','Marcos Nougeuira','Av. Pastor Martin Luther King Junior','','Inhauma','Rio de Janeiro','RJ','22002012','1995-01-13',23,'M',110000,220000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('50534475787','Abel Silva ','Rua Humaitá','','Humaitá','Rio de Janeiro','RJ','22000212','1995-09-11',22,'M',170000,260000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('5840119709','Gabriel Araujo','R. Manuel de Oliveira','','Santo Amaro','São Paulo','SP','80010221','1985-03-16',32,'M',140000,210000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('94387575700','Walber Lontra','R. Cel. Almeida','','Piedade','Rio de Janeiro','RJ','22000201','1989-06-20',28,'M',60000,120000,1);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('8719655770','Carlos Eduardo','Av. Gen. Guedes da Fontoura','','Jardins','São Paulo','SP','81192002','1983-12-20',34,'M',200000,240000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('5648641702','Paulo César Mattos','Rua Hélio Beltrão','','Tijuca','Rio de Janeiro','RJ','21002020','1991-08-30',26,'M',120000,220000,0);
INSERT INTO TBCLIENTS (cpf, name, address_1, address_2, neighborhood, city,  state, zip_code, date_of_birth, age, genre, credit_limit, vol_purchases, first_purchase) VALUES ('492472718','Eduardo Jorge','R. Volta Grande','','Tijuca','Rio de Janeiro','RJ','22012002','1994-07-19',23,'M',75000,95000,1);

INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1040107','Light - 350 ml - Melância','Lata','350 ml','Melância',4.555);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1037797','Clean - 2 Litros - Laranja','PET','2 Litros','Laranja',16.008);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1000889','Sabor da Montanha - 700 ml - Uva','Garrafa','700 ml','Uva',6.309);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1004327','Videira do Campo - 1,5 Litros - Melância','PET','1,5 Litros','Melância',19.51);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1088126','Linha Citros - 1 Litro - Limão','PET','1 Litro','Limão',7.004);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('544931','Frescor do Verão - 350 ml - Limão','Lata','350 ml','Limão',2.4595);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1078680','Frescor do Verão - 470 ml - Manga','Garrafa','470 ml','Manga',5.1795);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1042712','Linha Citros - 700 ml - Limão','Garrafa','700 ml','Limão',4.904);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('788975','Pedaços de Frutas - 1,5 Litros - Maça','PET','1,5 Litros','Maça',18.011);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1002767','Videira do Campo - 700 ml - Cereja/Maça','Garrafa','700 ml','Cereja/Maça',8.41);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('231776','Festival de Sabores - 700 ml - Açai','Garrafa','700 ml','Açai',13.312);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('479745','Clean - 470 ml - Laranja','Garrafa','470 ml','Laranja',3.768);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1051518','Frescor do Verão - 470 ml - Limão','Garrafa','470 ml','Limão',3.2995);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1101035','Linha Refrescante - 1 Litro - Morango/Limão','PET','1 Litro','Morango/Limão',9.0105);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('229900','Pedaços de Frutas - 350 ml - Maça','Lata','350 ml','Maça',4.211);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1086543','Linha Refrescante - 1 Litro - Manga','PET','1 Litro','Manga',11.0105);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('695594','Festival de Sabores - 1,5 Litros - Açai','PET','1,5 Litros','Açai',28.512);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('838819','Clean - 1,5 Litros - Laranja','PET','1,5 Litros','Laranja',12.008);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('326779','Linha Refrescante - 1,5 Litros - Manga','PET','1,5 Litros','Manga',16.5105);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('520380','Pedaços de Frutas - 1 Litro - Maça','PET','1 Litro','Maça',12.011);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1041119','Linha Citros - 700 ml - Lima/Limão','Garrafa','700 ml','Lima/Limão',4.904);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('243083','Festival de Sabores - 1,5 Litros - Maracujá','PET','1,5 Litros','Maracujá',10.512);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('394479','Sabor da Montanha - 700 ml - Cereja','Garrafa','700 ml','Cereja',8.409);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('746596','Light - 1,5 Litros - Melância','PET','1,5 Litros','Melância',19.505);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('773912','Clean - 1 Litro - Laranja','PET','1 Litro','Laranja',8.008);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('826490','Linha Refrescante - 700 ml - Morango/Limão','Garrafa','700 ml','Morango/Limão',6.3105);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('723457','Festival de Sabores - 700 ml - Maracujá','Garrafa','700 ml','Maracujá',4.912);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('812829','Clean - 350 ml - Laranja','Lata','350 ml','Laranja',2.808);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('290478','Videira do Campo - 350 ml - Melância','Lata','350 ml','Melância',4.56);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('783663','Sabor da Montanha - 700 ml - Morango','Garrafa','700 ml','Morango',7.709);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('235653','Frescor do Verão - 350 ml - Manga','Lata','350 ml','Manga',3.8595);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1002334','Linha Citros - 1 Litro - Lima/Limão','PET','1 Litro','Lima/Limão',7.004);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1013793','Videira do Campo - 2 Litros - Cereja/Maça','PET','2 Litros','Cereja/Maça',24.01);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1096818','Linha Refrescante - 700 ml - Manga','Garrafa','700 ml','Manga',7.7105);
INSERT INTO TBPRODUCTS (product_cod, name, package, size, taste, price) VALUES ('1022450','Festival de Sabores - 2 Litros - Açai','PET','2 Litros','Açai',38.012);

-- SELECT COLUMNS

SELECT * FROM TBCLIENTS;
SELECT cpf FROM TBCLIENTS;
SELECT cpf, name FROM TBCLIENTS LIMIT 5;
SELECT vol_purchases as vol_pur FROM TBCLIENTS; -- Alias (like a nickname to the column ;D)

-- -----------------------------------------------

SELECT name, registration FROM TBSALES;

-- FILTERING THE DATA
SELECT * FROM TBCLIENTS WHERE city = 'Rio de Janeiro';
SELECT * FROM TBPRODUCTS WHERE taste = 'limão';
UPDATE TBPRODUCTS SET taste = 'citrico' WHERE taste = 'limão';
SELECT * FROM TBPRODUCTS WHERE taste = 'citrico';

-- --------------------------------------------------

SELECT * FROM TBSALES WHERE name = 'Cláudia Morais';

-- MORE ABOUT FILTERS

SELECT * FROM TBCLIENTS WHERE age >= 22;
SELECT * FROM TBCLIENTS WHERE age < 22;
SELECT * FROM TBCLIENTS WHERE age <> 22; -- '<>' == '!='
SELECT * FROM TBCLIENTS WHERE name > 'Fernando Cavalcante';

SELECT * FROM TBPRODUCTS WHERE price > 16; -- with FLOAT we can't use = or <>, because is a floating value (need to be a DECIMAL value)
SELECT * FROM TBPRODUCTS WHERE price BETWEEN 16 AND 17;

-- ---------------------------------------------------

SELECT * FROM TBSALES WHERE commission_percent > 0.1;

-- FILTERING DATE TYPE
SELECT * FROM TBCLIENTS WHERE date_of_birth < '1995-01-13';
SELECT * FROM TBCLIENTS WHERE year(date_of_birth) = 1995;
SELECT * FROM TBCLIENTS WHERE month(date_of_birth) > 6;

-- -----------------------------------------------------

SELECT * FROM TBSALES WHERE year(admission_date) >= 2016;

-- MULTIPLE FILTERS (OR COMPOUND FILTERS)

SELECT * FROM TBPRODUCTS WHERE price >= 16.007 AND price <= 16.008;
SELECT * FROM TBCLIENTS WHERE age > 18 AND genre = 'M';
SELECT * FROM TBCLIENTS WHERE city = 'Rio de Janeiro' OR neighborhood = 'Jardins';

-- ---------------------------------------------------------------------------------

SELECT * FROM TBSALES WHERE year(admission_date) < 2016 AND vacation = TRUE;