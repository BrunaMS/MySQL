-- --------------------- UPDATING DATA --------------------- --
/*
- Syntax
	UPDATE <table> SET <field1> = <value1>, <field2> = <value2>, ...
    WHERE <condition>;
*/
USE JUICE_SALES;

UPDATE TB_PRODUCTS SET list_price = 5.3 WHERE product_code = 1000889;

UPDATE TB_PRODUCTS SET size = '1 Litro', package = 'PET',
descriptor  = 'Sabor da Montanha - 1 Litro - Uva' 
WHERE product_code = 1000889;

UPDATE TB_PRODUCTS SET list_price = list_price * 1.1 WHERE flavor = 'Maracujá';


SELECT * FROM TB_PRODUCTS WHERE flavor = 'Maracujá';

-- --------------------------

UPDATE TB_CLIENTS SET 
address = 'R. Jorge Emílio 23',
district = 'Santo Amaro',
city = 'São Paulo',
state = 'SP',
zip_code = '8833223'
WHERE cpf = '19290992743';

SELECT * FROM TB_CLIENTS; 

-- ------------- USING UPDATE WITH FROM ------------- --

SELECT * FROM TB_SALESPEOPLE; 
SELECT * FROM sucos_vendas.tabela_de_vendedores;

UPDATE TB_SALESPEOPLE A 
INNER JOIN sucos_vendas.tabela_de_vendedores B
ON A.register = SUBSTRING(B.MATRICULA, 3, 3)
SET vacation = B.DE_FERIAS;

-- ------------------------------------------

SELECT cpf, A.name, A.district, B.register, B.name, B.district  
FROM TB_CLIENTS A INNER JOIN TB_SALESPEOPLE B WHERE A.district = B.district;

UPDATE TB_CLIENTS A INNER JOIN TB_SALESPEOPLE B
SET buy_volume = buy_volume * 1.3 WHERE A.district = B.district;

SELECT * FROM TB_CLIENTS;

-- ----------------- DELETE DATA FROM A TABLE ----------------- --
/*
DELETE
- SYNTAX
	DELETE <table> WHERE <conditions>
    
- Obs.: Need to include records from a file before. 

SELECT * FROM TB_PRODUCTS WHERE SUBSTRING(descriptor, 1, 15) = 'Sabor dos Alpes';

DELETE * FROM TB_PRODUCTS WHERE product_code = '1001000';

DELETE * FROM TB_PRODUCTS WHERE TAMANHO = '1 Litro' AND SUBSTRING(descriptor, 1, 15) = 'Sabor dos Alpes';

;

DELETE FROM TB_PRODUCTS WHERE product_code NOT IN 
(SELECT CODIGO_DO_PRODUTO AS product_code FROM sucos_vendas.TABELA_DE_PRODUTOS);
*/

-- -----------------------

SELECT * FROM sucos_vendas.notas_fiscais;

INSERT INTO TB_SALESPEOPLE
SELECT DISTINCT MATRICULA AS register, 
	   NULL AS name, 
       NULL AS district,
       NULL AS comission, 
       NULL AS admission_date,
       NULL AS vacation
FROM sucos_vendas.notas_fiscais WHERE MATRICULA NOT IN (SELECT register FROM TB_SALESPEOPLE);

INSERT INTO INVOICES
SELECT NUMERO AS number,
	   DATA_VENDA AS date,
       CPF AS cpf,
	   MATRICULA AS register,       
       IMPOSTO AS tax
FROM sucos_vendas.notas_fiscais;

SELECT * FROM TB_SALESPEOPLE;
SELECT * FROM INVOICES;

/*
Desafio: Vamos excluir as notas fiscais (Apenas o cabeçalho) cujos clientes tenham menos que 18 anos.
*/

DELETE A FROM INVOICES A 
INNER JOIN (SELECT cpf, age FROM TB_CLIENTS) B
ON A.cpf = B.cpf WHERE age <= 18;

SELECT * FROM INVOICES A 
INNER JOIN (SELECT cpf, age FROM TB_CLIENTS) B
ON A.cpf = B.cpf WHERE age <= 18;

-- ---------------------- ALTER AND DROP ALL THE TABLE ---------------------- --
-- TB_PRODUCTS -> Send to SQL Editor -> Create Statement
CREATE TABLE `TB_PRODUCTS_2` (
  `product_code` varchar(10) NOT NULL,
  `descriptor` varchar(100) DEFAULT NULL,
  `flavor` varchar(50) DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `package` varchar(50) DEFAULT NULL,
  `list_price` float DEFAULT NULL,
  PRIMARY KEY (`product_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO TB_PRODUCTS_2 
SELECT * FROM TB_PRODUCTS;

UPDATE TB_PRODUCTS_2 SET list_price = 8;

SELECT * FROM TB_PRODUCTS_2;

DELETE FROM TB_PRODUCTS_2;

DROP TABLE TB_PRODUCTS_2;
-- ---------------------------

CREATE TABLE `INVOICES_2` (
number VARCHAR(5) NOT NULL,
date DATE DEFAULT NULL,
cpf VARCHAR(11) NOT NULL,
register VARCHAR(5) NOT NULL,
tax FLOAT DEFAULT NULL,
PRIMARY KEY(number),
FOREIGN KEY(cpf) REFERENCES TB_CLIENTS(cpf), 
FOREIGN KEY(register) REFERENCES TB_SALESPEOPLE(register) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO INVOICES_2 
SELECT * FROM INVOICES;

CREATE TABLE `ITEMS_INVOICES_2` (
number VARCHAR(5) NOT NULL,
product_code VARCHAR(10) NOT NULL,
quantity INT DEFAULT NULL,
price FLOAT DEFAULT NULL,
PRIMARY KEY(number),
FOREIGN KEY(number) REFERENCES INVOICES(number),
FOREIGN KEY(product_code) REFERENCES TB_PRODUCTS(product_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ITEMS_INVOICES_2 
SELECT * FROM ITEMS_INVOICES;

DELETE FROM ITEMS_INVOICES_2;
DELETE FROM INVOICES_2;

SELECT * FROM ITEMS_INVOICES_2;
SELECT * FROM INVOICES_2;

DROP TABLE INVOICES_2;
DROP TABLE ITEMS_INVOICES_2;
-- ------------------- COMMIT AND ROLLBACK ------------------- --
/*
- Syntax
	START TRANSACTION
    .
    .
    .
    COMMIT or ROLLBACK
    
- Definitions
	- START TRANSACTION: Create a state point into the database
    - COMMIT: Confirm all operations between START TRANSACTION and COMMIT 
    - ROLLBACK: Ignore all operations between START TRANSACTION and ROLLBACK 
*/

START TRANSACTION;
SELECT * FROM TB_SALESPEOPLE;
UPDATE TB_SALESPEOPLE SET comission = comission * 1.15;
ROLLBACK;

SELECT * FROM TB_SALESPEOPLE;

START TRANSACTION;
SELECT * FROM TB_SALESPEOPLE;
UPDATE TB_SALESPEOPLE SET comission = comission * 1.15;
INSERT INTO TB_SALESPEOPLE VALUES
('239', 'João da Silva', 'Icaraí', 0.08, '2012-01-15', 0);
COMMIT;

SELECT * FROM TB_SALESPEOPLE;