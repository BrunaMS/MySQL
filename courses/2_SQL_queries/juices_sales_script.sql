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
