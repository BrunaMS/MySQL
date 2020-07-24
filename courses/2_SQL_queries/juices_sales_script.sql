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