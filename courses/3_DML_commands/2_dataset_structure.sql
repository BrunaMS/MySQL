-- ---------------------------------- Making a dataset structure ---------------------------------- --
/*
-- CREATE DATASET
 Steps:
	1. Create dataset;
		- Syntax:
			CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] DB_NAME
				[create_specification] ...
                
			create_specification:
					[DEFAULT] CHARACTER SET [=] charset_name
                |	[DEFAULT] COLLATE		[=] collation_name
                |	DEFAULT ENCRYPTION 		[=] {'Y' | 'N'}
                
		- CHARACTER SET: SPECIFY THE STANDARD CHAR SET TO USE IN THE DATASET 
			- UTF8, ASCII ETC
        - CREATE / DROP DATABASE = CREATE / DROP SCHEMA
*/

-- CREATE DATABASE IF NOT EXISTS `JUICE_SALES`;

-- DROP DATABASE IF EXISTS `JUICE_SALES`;

CREATE DATABASE IF NOT EXISTS `JUICE_SALES`
	DEFAULT CHARACTER SET utf8; -- can be utf8 to use brazilian portuguese or ascii to english

USE JUICE_SALES;

/*
-- CREATE TABLE
	- 1st Syntax 
		CREATE [TEMPORARY] TABLE [IF NOT EXISTS] TBL_NAME
			(create_definition, ...)
			[table_options]
			[partition_options]
	
    - 2nd Syntax	
        CREATE [TEMPORARY] TABLE [IF NOT EXISTS] TBL_NAME
			[(create_definition, ...)]
			[table_options]
			[partition_options]
            [IGNORE | REPLACE]
            [AS] query_expression
	
    - 3rd Syntax
        CREATE [TEMPORARY] TABLE [IF NOT EXISTS] TBL_NAME
			{	LIKE old_tbl_name | (LIKE old_tbl_name)	}			
*/

CREATE TABLE IF NOT EXISTS TB_PRODUCTS (
	product_code VARCHAR(10) NOT NULL,
    descriptor VARCHAR(100) NULL,
    flavor VARCHAR(50) NULL,
    size VARCHAR(50) NULL,
    package VARCHAR(50) NULL,
    list_price FLOAT NULL,
	PRIMARY KEY (product_code)
);

CREATE TABLE IF NOT EXISTS TB_SALESPEOPLE(
    register VARCHAR(5) NOT NULL,
    name VARCHAR(100) NULL,
    district VARCHAR(50) NULL,
    comission FLOAT NULL,
    admission_date DATE NULL,
    vacation BOOLEAN NULL,
	PRIMARY KEY (register)
);
    
-- ALTER TABLE TB_SALESPEOPLE CHANGE adimission_date admission_date DATE;
-- ... RENAME COLUMN <> TO <> didn't work

CREATE TABLE IF NOT EXISTS TB_CLIENTS(
    cpf VARCHAR(11) NOT NULL,
    name VARCHAR(100) NULL,
    address VARCHAR(150) NULL,
    district VARCHAR(50) NULL,
    city VARCHAR(50) NULL,
    state VARCHAR(50) NULL,
    zip_code VARCHAR(8) NULL,
    date_of_birth DATE NULL,
    age SMALLINT,
    genre ENUM('F', 'M', 'O') NULL,
	credit_limit FLOAT NULL,
    buy_volume FLOAT NULL,
    first_buy BOOLEAN NULL,
	PRIMARY KEY (cpf)
);

CREATE TABLE IF NOT EXISTS TB_SALES(
number VARCHAR(5) NOT NULL,
date DATE DEFAULT NULL,
cpf VARCHAR(11) NOT NULL,
register VARCHAR(5) NOT NULL,
tax FLOAT DEFAULT NULL,
PRIMARY KEY(number),
FOREIGN KEY(cpf) REFERENCES TB_CLIENTS(cpf), 
FOREIGN KEY(register) REFERENCES TB_SALESPEOPLE(register) 
);

CREATE TABLE IF NOT EXISTS TB_SOLD_ITEMS(
number VARCHAR(5) NOT NULL,
product_code VARCHAR(10) NOT NULL,
quantity INT DEFAULT NULL,
price FLOAT DEFAULT NULL,
-- PRIMARY KEY(number),
FOREIGN KEY(number) REFERENCES TB_SALES(number),
FOREIGN KEY(product_code) REFERENCES TB_PRODUCTS(product_code)
);

-- If you need to convert a field in a key later the table was created:
	-- ALTER TABLE TB_SOLD_ITEMS ADD CONSTRAINT fk_product_code
	-- FOREIGN KEY(product_code) REFERENCES TB_PRODUCTS(product_code)
    
-- To change a table name:
ALTER TABLE TB_SALES RENAME INVOICES;
ALTER TABLE TB_SOLD_ITEMS RENAME ITEMS_INVOICES;

-- PS.: DEFAULT NULL IS NOT NECESSARY BECAUSE THE FIELDS ALWAYS BEGIN WITH NULL BY DEFAULT (IF THERE IS NOT ´NOT NULL´)
