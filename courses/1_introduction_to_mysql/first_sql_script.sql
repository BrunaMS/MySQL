-- This database contains the user data of a imaginary juice company
-- According to the company owner, the main data to them is:
-- CPF, Complete name, Address, date of birth, age, genre
-- Credit limit to buy products, minimum volume of juices, if had already made a purchase

CREATE TABLE JUICES.TBCLIENTS
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

CREATE TABLE JUICES.TBSALES
(registration CHAR(5), 
name VARCHAR(100),
commission_percent FLOAT);

-- Seeing that we are making a database related to a juices store, we need some data about the products too

CREATE TABLE JUICES.TBPRODUCTS
(product_cod VARCHAR(20), 
name VARCHAR(100), 
package VARCHAR(50),
size VARCHAR(50),
taste VARCHAR(50),
price FLOAT);
