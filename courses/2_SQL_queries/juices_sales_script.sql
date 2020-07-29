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