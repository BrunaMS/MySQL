CREATE DATABASE IF NOT EXISTS sucos_vendas; -- I had to use this name because the imported data works only with this database

-- Here, import data from the folder "DumpSucosVendas"

USE sucos_vendas; 

-- REVISION ABOUT SELECT COMMAND, QUERIES AND SOME FILTERS

SELECT * FROM tabela_de_clientes;

SELECT CPF, NOME FROM tabela_de_clientes;

SELECT CPF, NOME AS NAME, ENDERECO_1 AS ADDRESS FROM tabela_de_clientes;

SELECT * FROM tabela_de_produtos WHERE CODIGO_DO_PRODUTO > '1005000';

SELECT * FROM tabela_de_produtos WHERE PRECO_DE_LISTA BETWEEN 19 AND 20;

SELECT * FROM tabela_de_produtos WHERE SABOR = 'uva';

SELECT * FROM tabela_de_produtos WHERE SABOR = 'laranja';

-- CONDITIONAL QUERIES

-- LOGICAL OPERATORS
	-- NOT(EXPRESSION)
	-- EXPRESSION1 AND EXPRESSION2
	-- EXPRESSION1 OR EXPRESSION2
    
SELECT * FROM tabela_de_produtos WHERE SABOR = 'manga' OR TAMANHO = '470 ml';
SELECT * FROM tabela_de_produtos WHERE SABOR = 'manga' AND TAMANHO = '470 ml';
SELECT * FROM tabela_de_produtos WHERE SABOR = 'manga' AND NOT(TAMANHO = '470 ml');
SELECT * FROM tabela_de_produtos WHERE SABOR = 'manga' OR NOT(TAMANHO = '470 ml');
SELECT * FROM tabela_de_produtos WHERE SABOR IN ('manga', 'laranja'); -- SABOR = 'laranja' OR SABOR = 'manga';
SELECT * FROM tabela_de_clientes WHERE CIDADE IN ('Rio de Janeiro', 'São Paulo') AND IDADE <= 22;

-- LIKE OPERATOR 
	-- ... WHERE <FIELD> LIKE '<CONDITION>'
	-- % - Any generic record that contains the values/text into <condition>
		-- At the beginning('<TEXT>%')
        -- At the end ('%<TEXT>')
        -- Anywhere ('%<TEXT>%')
    -- EXAMPLE: LIKE '%Soares%' --> Anyone with 'Soares' into the name
    
SELECT * FROM tabela_de_clientes WHERE NOME LIKE '%Silva%';
SELECT * FROM tabela_de_clientes WHERE NOME LIKE '%a%' AND IDADE > 20; 

SELECT * FROM tabela_de_clientes WHERE NOME LIKE '%Mattos';

-- ------------------------- QUERY DATA EXHIBITION ------------------------- -- 
-- DISTINCT
	-- SELECT DISTINCT * FROM TABLE
    -- Similar to unique()
	-- Show each available data only one time
    
SELECT DISTINCT EMBALAGEM, TAMANHO FROM tabela_de_produtos;

--

SELECT DISTINCT BAIRRO FROM tabela_de_clientes WHERE CIDADE = 'Rio de Janeiro';

-- LIMIT
	-- Always in the end of the command
    -- Define the quantity of records will be shown
    -- Can choose the from wich record it will count using <quantity of lines to skip>, <quantity of lines to show>

SELECT * FROM tabela_de_produtos LIMIT 2, 3;

--

SELECT * FROM notas_fiscais WHERE DATA_VENDA = '2017-01-01' LIMIT 10;

-- ORDER BY
	-- SELECT * FROM TABLE ORDER BY CAMPO
	-- Can be ascending (ASC) or descending (DES)
    -- Can use 2 fields to order the data: ORDER BY <FIELD1>, <FIELD2>
    
SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA;
SELECT * FROM tabela_de_produtos ORDER BY PRECO_DE_LISTA DESC;
SELECT * FROM tabela_de_produtos ORDER BY SABOR, PRECO_DE_LISTA DESC;

-- 

SELECT CODIGO_DO_PRODUTO FROM tabela_de_produtos WHERE NOME_DO_PRODUTO = 'Linha Refrescante - 1 Litro - Morango/Limão';
SELECT * FROM itens_notas_fiscais WHERE CODIGO_DO_PRODUTO = '1101035' ORDER BY QUANTIDADE DESC LIMIT 5;

--  GROUP BY
	-- SELECT <FIELDS> FROM <TABLE> GROUP BY <FIELD>;
    -- POSSIBLE OPERATORS: 
		-- SUM, MAX, MIN, AVG (average), COUNT (occurrences)
        
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) FROM tabela_de_clientes GROUP BY ESTADO;

SELECT NOME_DO_PRODUTO, EMBALAGEM, MAX(PRECO_DE_LISTA) FROM tabela_de_produtos;        

SELECT COUNT(*), EMBALAGEM FROM tabela_de_produtos GROUP BY EMBALAGEM;
  
SELECT BAIRRO, SUM(LIMITE_DE_CREDITO) AS SUM_LIMITE FROM tabela_de_clientes GROUP BY BAIRRO ORDER BY SUM_LIMITE DESC;  
      
-- 

SELECT QUANTIDADE, COUNT(*) FROM itens_notas_fiscais WHERE CODIGO_DO_PRODUTO = '1101035' GROUP BY QUANTIDADE  ORDER BY QUANTIDADE DESC LIMIT 5;
        
-- HAVING
	-- USED TO FILTER RESULTS AFTER GROUP BY WAS USED
    -- SELECT <FIELDS> FROM <TABLE> GROUP BY <FIELD> HAVING <CONDITION> 
    
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS SUM_LIMIT FROM tabela_de_clientes GROUP BY ESTADO HAVING SUM_LIMIT > 980000;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA), MIN(PRECO_DE_LISTA) FROM tabela_de_produtos GROUP BY EMBALAGEM;

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA), MIN(PRECO_DE_LISTA), SUM(PRECO_DE_LISTA) FROM tabela_de_produtos 
GROUP BY EMBALAGEM HAVING SUM(PRECO_DE_LISTA) <= 80;

--
SELECT MAX(VOLUME_DE_COMPRA) AS MAX_COMPRAS FROM tabela_de_clientes;
SELECT NOME, VOLUME_DE_COMPRA FROM tabela_de_clientes WHERE VOLUME_DE_COMPRA > 2000 ORDER BY VOLUME_DE_COMPRA DESC;

SELECT CPF, COUNT(*) AS NUMBER_OF_TIMES FROM notas_fiscais 
WHERE year(DATA_VENDA) = '2016'
GROUP BY CPF HAVING NUMBER_OF_TIMES > 2000;

-- CASE
-- SELECT <FIELD>
-- CASE
-- 	WHEN <CONDITION1> THEN <SOMETHING1>;
--     WHEN <CONDITION2> THEN <SOMETHING2>;
--     WHEN <CONDITION3> THEN <SOMETHING3>;
--     ELSE <SOMETHING>

SELECT EMBALAGEM, 
CASE
	WHEN PRECO_DE_LISTA >= 12 THEN "EXPENSIVE"
    WHEN PRECO_DE_LISTA < 12 AND PRECO_DE_LISTA > 6 THEN "REASONABLE"
    ELSE 'CHEAP'
END AS PRICE_CLASSIFICATION,
AVG(PRECO_DE_LISTA) AS AVG_PRICE
FROM tabela_de_produtos 
GROUP BY EMBALAGEM, PRICE_CLASSIFICATION;

SELECT NOME, IDADE, 
CASE
	WHEN YEAR(DATA_DE_NASCIMENTO) < 1990 THEN 'OLD'
    WHEN YEAR(DATA_DE_NASCIMENTO) >= 1990 AND YEAR(DATA_DE_NASCIMENTO) <= 1995 THEN 'YOUNG'
    ELSE 'CHILD'
END AS AGE_CLASSIFICATION FROM tabela_de_clientes;

-- ------------------------ FOURTH CLASS ------------------------ -- 
-- JOIN
	-- - Allow us to unit one or more tables, according to the keys
    -- - INNER JOIN - Join data from both tables.
    -- - LEFT  JOIN - Take records with the same ID from the 2nd table to the 1st one.
    -- - RIGHT JOIN - Take records with the same ID from the 1st table to the 2nd one.
    -- - FULL  JOIN - Take all records from the 2nd table to the 1st one. (DOESN'T WORK WITH MYSQL)
    -- - CROSS JOIN - Use cartesian product to join both tables.
    
SELECT * FROM tabela_de_vendedores;
SELECT * FROM notas_fiscais;

SELECT A.MATRICULA, A.NOME, COUNT(*) FROM tabela_de_vendedores A
INNER JOIN notas_fiscais B
ON A.MATRICULA = B.MATRICULA 
GROUP BY A.MATRICULA, A.NOME;

-- -------------------------------

SELECT * FROM itens_notas_fiscais;
SELECT * FROM notas_fiscais;

SELECT YEAR(B.DATA_VENDA), SUM(A.QUANTIDADE * A.PRECO) AS GAIN
FROM itens_notas_fiscais A INNER JOIN notas_fiscais B
ON A.NUMERO = B.NUMERO
GROUP BY YEAR(B.DATA_VENDA); 

-- -------------------------- LEFT AND RIGHT JOIN EXAMPLES -------------------------- --

SELECT COUNT(*) FROM tabela_de_clientes; -- NUMBER OF REGISTERED CUSTOMERS 
SELECT CPF, COUNT(*) FROM notas_fiscais GROUP BY CPF; 
-- There is 1 customer out of this table, what means that it have never bought a product there.

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A 
INNER JOIN notas_fiscais B ON A.CPF = B.CPF;

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A 
LEFT JOIN notas_fiscais B ON A.CPF = B.CPF;

SELECT DISTINCT A.CPF, A.NOME, B.CPF FROM tabela_de_clientes A 
LEFT JOIN notas_fiscais B ON A.CPF = B.CPF WHERE B.CPF IS NULL;

-- -------------------------- FULL AND CROSS JOIN EXAMPLES -------------------------- --

SELECT * FROM tabela_de_clientes;
SELECT * FROM tabela_de_vendedores;

SELECT * FROM tabela_de_vendedores
INNER JOIN tabela_de_clientes ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores INNER JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores FULL JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO; -- DOES NOT WORK.

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME 
FROM tabela_de_vendedores CROSS JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;




-- -------------------------------------- JOIN QUERIES -------------------------------------- --

-- UNION: join two queries
	-- The queries need to have the same type and number of fields
    -- Join and make DISTINCT automatically
-- UNION ALL: DOESN'T apply DISTINCT in the obtained result

SELECT DISTINCT BAIRRO FROM tabela_de_clientes;
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT DISTINCT BAIRRO FROM tabela_de_clientes UNION
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT DISTINCT BAIRRO FROM tabela_de_clientes UNION ALL
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT DISTINCT BAIRRO, NOME, 'CLIENT' AS TIPO, CPF AS ID FROM tabela_de_clientes UNION
SELECT DISTINCT BAIRRO, NOME, 'SALESPERSON' AS TIPO, MATRICULA FROM tabela_de_vendedores;
-- Show the alias defined in the first query.

-- USING UNION TO DO A FULL JOIN

SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, DE_FERIAS 
FROM tabela_de_vendedores RIGHT JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO
UNION
SELECT tabela_de_vendedores.BAIRRO, tabela_de_vendedores.NOME, tabela_de_clientes.BAIRRO, tabela_de_clientes.NOME, NULL 
FROM tabela_de_vendedores LEFT JOIN tabela_de_clientes 
ON tabela_de_clientes.BAIRRO = tabela_de_vendedores.BAIRRO;

-- ------------------------------ SUB-QUERIES ------------------------------ --

-- Query into another Query 0.0)
	-- Example: SELECT X, Y FROM TAB1 WHERE Y IN (SELECT Y FROM TAB2)
    
SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

SELECT * FROM tabela_de_clientes WHERE BAIRRO IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) FROM tabela_de_produtos GROUP BY EMBALAGEM;

SELECT MAX_PACKAGE_PRICE.EMBALAGEM, MAX_PACKAGE_PRICE.MAX_PRICE FROM
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAX_PRICE FROM tabela_de_produtos GROUP BY EMBALAGEM) MAX_PACKAGE_PRICE
WHERE MAX_PACKAGE_PRICE.MAX_PRICE > 10;

-- -------------------------------------

SELECT CPF, COUNT(*) FROM notas_fiscais
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000;

SELECT SUB_CPF.CPF, SUB_CPF.TIMES_COUNT FROM
(SELECT CPF, COUNT(*) AS TIMES_COUNT FROM notas_fiscais WHERE YEAR(DATA_VENDA) = 2016 GROUP BY CPF) SUB_CPF
WHERE SUB_CPF.TIMES_COUNT > 2000;


-- --------------------------- VIEW --------------------------- --

-- Query that can be saved as a table
	-- Very useful when we need to show only some fields of a table
    -- Similar to a sub-query

SELECT X.EMBALAGEM, X.MAIOR_PRECO FROM    
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos GROUP BY EMBALAGEM) X
WHERE MAIOR_PRECO >= 10;

CREATE OR REPLACE VIEW `VW_HIGHER_PACKAGES` AS 
SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM tabela_de_produtos GROUP BY EMBALAGEM;

SELECT EMBALAGEM, MAIOR_PRECO FROM VW_HIGHER_PACKAGES WHERE MAIOR_PRECO >= 10;

SELECT A.EMBALAGEM, A.NOME_DO_PRODUTO, A.PRECO_DE_LISTA, X.MAIOR_PRECO,
(A.PRECO_DE_LISTA * 100 / X.MAIOR_PRECO) AS 'PERCENT'
FROM tabela_de_produtos A INNER JOIN  VW_HIGHER_PACKAGES X
ON A.EMBALAGEM = X.EMBALAGEM; 

-- -------------------------------------------- FUNCTIONS -------------------------------------------- --

-- Greater difference between types of SQL

-- Math functions (manipulate numeric fields)
-- String functions (manipulate text/strings fields)
	-- Example: CONCAT() function
		-- SELECT CONCAT("Hello ", "World", "!");
	-- LCASE() or UCASE() functions
		-- convert all characters to lower/uppercase.
-- Date functions (manipulate date fields)

-- Documentation: https://dev.mysql.com/doc/refman/8.0/en/functions.html
-- W3schools: https://www.w3schools.com/sql/sql_ref_mysql.asp

-- ----------------------------------------- STRING FUNCTIONS ----------------------------------------- --

SELECT LTRIM('     Hello     ') AS result_ltrim, 
RTRIM('     Hello     ') AS result_rtrim, 
TRIM('     Hello     ') AS result_trim;

SELECT SUBSTRING("Hello, How are you?", 1,5);
SELECT UCASE("Do you know SQL?");
SELECT LCASE("Have you ever learned SQL with MySQL?");

-- ------------------------------------------------------

SELECT NOME, CONCAT(CIDADE, " ", BAIRRO, " ", ENDERECO_1, " ", ENDERECO_2) AS ADDRESS FROM tabela_de_clientes;

-- ----------------------------------------- DATE FUNCTIONS ----------------------------------------- --

SELECT ADDDATE("2020-06-19", INTERVAL 15 DAY);
SELECT CURDATE();
SELECT CURRENT_TIMESTAMP();
SELECT CURRENT_TIME();
SELECT DATEDIFF("2020-08-20", CURDATE());

SELECT DAY(CURRENT_TIMESTAMP());
SELECT MONTH(CURRENT_TIMESTAMP());

SELECT DATEDIFF(CURDATE(), "1998-06-19");

SELECT DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 5 DAY) AS RESULT;

SELECT DATA_VENDA, DAYNAME(DATA_VENDA), MONTHNAME(DATA_VENDA) FROM notas_fiscais;

SELECT NOME, (YEAR(CURDATE()) - YEAR(DATA_DE_NASCIMENTO)) AS AGE FROM tabela_de_clientes;
SELECT NOME, TIMESTAMPDIFF(YEAR, DATA_DE_NASCIMENTO, CURDATE()) AS AGE FROM tabela_de_clientes;

-- ----------------------------------------- NUMERIC FUNCTIONS ----------------------------------------- --

SELECT ((23 + 25) / 2 * 45);

SELECT 10/3;
SELECT CEILING(10/3);
SELECT ROUND(10/3);
SELECT FLOOR(10/3);

SELECT RAND();

SELECT NUMERO, QUANTIDADE, PRECO, QUANTIDADE * PRECO AS FATURAMENTO FROM itens_notas_fiscais;
SELECT NUMERO, QUANTIDADE, PRECO, ROUND(QUANTIDADE * PRECO, 2) AS FATURAMENTO FROM itens_notas_fiscais;

-- -----------------------------------------------------------
CREATE OR REPLACE VIEW `VW_NF_INF` AS 
SELECT NF.CPF, NF.NUMERO, NF.IMPOSTO, YEAR(NF.DATA_VENDA) AS YEAR, INF.PRECO, INF.QUANTIDADE
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
ON NF.NUMERO = INF.NUMERO; 

SELECT * FROM VW_NF_INF;

SELECT YEAR, FLOOR(SUM(QUANTIDADE * PRECO * IMPOSTO)) AS IMPOSTO_TOTAL 
FROM VW_NF WHERE YEAR = 2016 GROUP BY YEAR;

SELECT YEAR(DATA_VENDA), IMPOSTO FROM notas_fiscais;


-- ------------------------------------ DATA CONVERSION ------------------------------------ --
-- DATE_FORMAT 
	-- DOCUMENTATION: https://www.w3schools.com/sql/func_mysql_date_format.asp

SELECT CURRENT_TIMESTAMP();
SELECT CONCAT("CURRENT DATE: ", CURRENT_TIMESTAMP());


SELECT CONCAT("CURRENT YEAR (4D): ", DATE_FORMAT(CURRENT_TIMESTAMP(), "%Y"));
SELECT CONCAT("CURRENT YEAR (2D): ", DATE_FORMAT(CURRENT_TIMESTAMP(), "%y"));
SELECT CONCAT("CURRENT MONTH/YEAR: ", DATE_FORMAT(CURRENT_TIMESTAMP(), "%m/%y"));
SELECT CONCAT("COMPLETE CURRENT DATE: ", DATE_FORMAT(CURRENT_TIMESTAMP(), "%d/%m/%Y"));


SELECT CONVERT(23.3, CHAR);
SELECT SUBSTRING(CONVERT(23.3, CHAR), 1, 1) AS FIRST_DIGIT;

-- ----------------------------------------------------

SELECT NOME, YEAR, VW_NF_INF.CPF, ROUND(SUM(VW_NF_INF.QUANTIDADE * VW_NF_INF.PRECO), 2) AS SPENT 
FROM VW_NF_INF INNER JOIN tabela_de_clientes ON VW_NF_INF.CPF = tabela_de_clientes.CPF
WHERE YEAR = 2016
GROUP BY VW_NF_INF.CPF;

SELECT CONCAT('The costumer ', NOME, ' spent around R$ ', 
CONVERT(ROUND(SUM(VW_NF_INF.QUANTIDADE * VW_NF_INF.PRECO), 2), CHAR), 
' in ', CONVERT(YEAR, CHAR)) AS PHRASE
FROM VW_NF_INF INNER JOIN tabela_de_clientes ON VW_NF_INF.CPF = tabela_de_clientes.CPF
WHERE YEAR = 2016
GROUP BY VW_NF_INF.CPF;

-- ----------------------------- Report examples ----------------------------- --

-- We need to show which sales are valid and which are not.
	-- It will be done using VOLUME_DE_VENDAS, where is the limit that any customer has in a month;
    -- We'll compare this value with the value spent by the same customer and authenticate it or not.
    
SELECT * FROM tabela_de_clientes;
SELECT * FROM notas_fiscais;
SELECT * FROM itens_notas_fiscais;

SELECT NOME, TC.CPF, DATE_FORMAT(DATA_VENDA, '%m/%Y') AS MONTH_YEAR, SUM(QUANTIDADE) AS QNT, 
VOLUME_DE_COMPRA AS SALES_LIMIT, 
CASE WHEN SUM(QUANTIDADE) < VOLUME_DE_COMPRA THEN 'Valid' else 'Invalid' end as AUTHENTICATED
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF RIGHT JOIN tabela_de_clientes TC
ON NF.NUMERO = INF.NUMERO AND TC.CPF = NF.CPF
GROUP BY TC.CPF, MONTH_YEAR
ORDER BY NOME, YEAR(MONTH_YEAR), MONTH(MONTH_YEAR);

/* COMMENT


SELECT * FROM tabela_de_produtos;
SELECT * FROM itens_notas_fiscais;

CREATE OR REPLACE VIEW VW_FLAVORS_SPENT_VALUE AS
SELECT SABOR, MAX(YEAR(DATA_VENDA)) AS YEAR, SUM(QUANTIDADE * PRECO) AS SPENT_VALUE, 
PRECO_DE_LISTA, ROUND(SUM(QUANTIDADE * PRECO) * 100 / MAX(INF_T.TOTAL), 2) AS PARTICIPATION
FROM tabela_de_produtos TP 
INNER JOIN itens_notas_fiscais INF
INNER JOIN notas_fiscais NF
INNER JOIN (SELECT SUM(QUANTIDADE * PRECO) AS TOTAL 
FROM itens_notas_fiscais INF INNER JOIN notas_fiscais NF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016)  INF_T
ON NF.NUMERO = INF.NUMERO AND INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY TP.CODIGO_DO_PRODUTO
ORDER BY PARTICIPATION DESC;

SELECT * FROM VW_FLAVORS_SPENT_VALUE;
SELECT SUM(PARTICIPATION) FROM VW_FLAVORS_SPENT_VALUE;

SELECT SUM(QUANTIDADE * PRECO) AS TOTAL FROM itens_notas_fiscais;
SELECT SUM(QUANTIDADE * PRECO) AS TOTAL FROM itens_notas_fiscais;
*/

-- -----------------------------------------------------------------

CREATE OR REPLACE VIEW VW_FLAVORS_QNT AS
SELECT SABOR, MAX(YEAR(DATA_VENDA)) AS YEAR, SUM(QUANTIDADE) AS QNT, ROUND(SUM(QUANTIDADE) * 100 / MAX(INF_T.TOTAL), 2) AS PARTICIPATION
FROM tabela_de_produtos TP 
INNER JOIN itens_notas_fiscais INF
INNER JOIN notas_fiscais NF
INNER JOIN (SELECT SUM(QUANTIDADE) AS TOTAL 
FROM itens_notas_fiscais INF INNER JOIN notas_fiscais NF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016)  INF_T
ON NF.NUMERO = INF.NUMERO AND INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY TP.SABOR
ORDER BY PARTICIPATION DESC;

SELECT * FROM VW_FLAVORS_QNT;
SELECT SUM(PARTICIPATION) FROM VW_FLAVORS_QNT;

-- ------------------------------------------------------------

CREATE OR REPLACE VIEW VW_SIZE_QNT AS
SELECT TAMANHO, MAX(YEAR(DATA_VENDA)) AS YEAR, SUM(QUANTIDADE) AS QNT, ROUND(SUM(QUANTIDADE) * 100 / MAX(INF_T.TOTAL), 2) AS PARTICIPATION
FROM tabela_de_produtos TP 
INNER JOIN itens_notas_fiscais INF
INNER JOIN notas_fiscais NF
INNER JOIN (SELECT SUM(QUANTIDADE) AS TOTAL 
FROM itens_notas_fiscais INF INNER JOIN notas_fiscais NF
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA_VENDA) = 2016)  INF_T
ON NF.NUMERO = INF.NUMERO AND INF.CODIGO_DO_PRODUTO = TP.CODIGO_DO_PRODUTO
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY TP.TAMANHO
ORDER BY PARTICIPATION DESC;

SELECT * FROM VW_SIZE_QNT;
SELECT SUM(PARTICIPATION) FROM VW_SIZE_QNT;