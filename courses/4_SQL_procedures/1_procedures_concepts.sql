-- ----------------- Basic Stored Procedures ----------------- --
-- Basic Concepts
/*
Creating Procedures
- Syntax
	CREATE PROCEDURE
    procedure_name(parameters)
    BEGIN
    DECLARE declaration_statement;
    ...
    executable_statement;
    ...
    END;

- Rules
	- Only letters;
    - Max 64 characters;
    - Only name;
    - Case sensitive.
    
*/

use JUICE_SALES;

DROP PROCEDURE IF EXISTS `DO_NOTHING`;

DELIMITER $$
CREATE PROCEDURE `DO_NOTHING`()
BEGIN
END$$

CREATE PROCEDURE `HELLO_WORLD` ()
BEGIN
select 'Hello world with stored procedures!!' ;
END$$

DELIMITER ; 
call HELLO_WORLD;

DELIMITER $$

CREATE PROCEDURE `SHOW_NUMBER`()
BEGIN
SELECT rand() AS number;
END$$

call SHOW_NUMBER$$

DROP PROCEDURE IF EXISTS `print_date` $$

CREATE PROCEDURE `print_date_eua`()
BEGIN
SELECT CONCAT('Today is: ', monthname(CURRENT_TIMESTAMP), ' ', day(CURRENT_TIMESTAMP), ', ', year(CURRENT_TIMESTAMP)) as Today;
END$$

call print_date$$

-- ------------------------------- VARIABLES ------------------------------- --
/*
Declaring a variable
- Rules
	- Name only with letters, numbers, $ and/or undercore;
    - Can't repeat into the sp (stored procedure);
    - Case sensitive;
    - Max size of 255 caracters;
    - If there isn't DEFAULT, the value is NULL;
    - the declaration line has to finish with ';'.
- One DECLARE can declare more than one variable since they are all of the same type.
*/

DROP PROCEDURE IF EXISTS `print_var`$$

CREATE PROCEDURE `print_var`()
BEGIN
DECLARE text, another_text VARCHAR(50) DEFAULT "My First variables into the SQL World!";
DECLARE rand_number FLOAT DEFAULT rand();
SET another_text = 'My second variable into the SQL World!';
SELECT text, another_text, rand_number;
END$$

CALL print_var$$

-- -------------------------------------------
DROP PROCEDURE IF EXISTS create_vars$$
CREATE PROCEDURE create_vars()
BEGIN
DECLARE name  VARCHAR(10)  DEFAULT 'John';
DECLARE age   SMALLINT     DEFAULT 10;
DECLARE date_of_birth DATE DEFAULT '2017-01-20';
DECLARE cost FLOAT DEFAULT 10.23;

SET name = 'John';
SET age = 10;
SET date_of_birth = '2017-01-20';
SET cost = 10.23;

SELECT name, age, date_of_birth, cost;
END$$

call create_vars()$$



