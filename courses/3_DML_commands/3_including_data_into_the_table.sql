-- --------------------- INCLUDING DATA --------------------- --
/*
-- INSERT
	- Syntax
		INSERT INTO <table> (<field1>, <field2>, ... , <fieldn)
        VALUES (<values to be included 1>), (<values to be included 2>) ... (<values to be included n>);
*/

USE JUICE_SALES;
DELETE FROM TB_PRODUCTS;

INSERT INTO TB_PRODUCTS
VALUES
('1040107', 'Light - 350 ml - Melância', 'Melância', '350 ml', 'Lata', 4.56),
('1040108', 'Light - 350 ml - Graviola', 'Graviola', '350 ml', 'Lata', 4.00),
('1040109', 'Light - 350 ml - Açaí', 'Açaí', '350 ml', 'Lata', 5.60),
('1040110', 'Light - 350 ml - Jaca', 'Jaca', '350 ml', 'Lata', 6.00),
('1040111', 'Light - 350 ml - Manga', 'Manga', '350 ml', 'Lata', 3.50);

-- SELECT * FROM TB_PRODUCTS;

INSERT INTO TB_CLIENTS
VALUES
('1471156710',  'Érica Carvalho', 'R. Iriquitia', 'Jardins', 'São Paulo', 'SP', '80012212', '1990-09-01', 27, 'F', 170000, 24500, 0),

('19290992743',  'Fernando Cavalcante', 'R. Dois de Fevereiro', 'Água Santa', 'Rio de Janeiro', 'RJ', '22000000', '2000-02-12', 18, 'M', 100000, 20000, 1),

('2600586709',  'César Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 'Rio de Janeiro', 'RJ', '22020001', '2000-03-12', 18, 'M', 120000, 22000, 0);

SELECT * FROM TB_CLIENTS;

-- DROP DATABASE IF EXISTS sucos_vendas;
CREATE DATABASE IF NOT EXISTS sucos_vendas;

-- Administration -> Data Import/restore -> DumpSucosVendas
USE sucos_vendas;

SELECT * FROM notas_fiscais LIMIT 50; 

USE JUICE_SALES;
SELECT * FROM sucos_vendas.tabela_de_produtos;

INSERT INTO TB_PRODUCTS
SELECT CODIGO_DO_PRODUTO AS product_code,
	   NOME_DO_PRODUTO AS descriptor,
       SABOR AS flavor,
       TAMANHO AS size,
       EMBALAGEM AS package,       
       PRECO_DE_LISTA AS list_price
FROM sucos_vendas.tabela_de_produtos
WHERE CODIGO_DO_PRODUTO NOT IN(SELECT product_code from TB_PRODUCTS);

SELECT * FROM TB_PRODUCTS;

-- ----------------------------

SELECT * FROM sucos_vendas.tabela_de_clientes;

INSERT INTO TB_CLIENTS
SELECT CPF AS cpf,
	   NOME AS name,
	   CONCAT(ENDERECO_1, ' ', ENDERECO_2) AS address,
       BAIRRO AS district, 
       CIDADE AS city,
       ESTADO AS state,
       CEP    AS zip_code, 
       DATA_DE_NASCIMENTO AS date_of_birth, 
       IDADE  AS age, 
       SEXO   AS genre, 
       LIMITE_DE_CREDITO AS credit_limit, 
       VOLUME_DE_COMPRA  AS buy_volume, 
       PRIMEIRA_COMPRA   AS first_buy
FROM sucos_vendas.tabela_de_clientes
WHERE CPF NOT IN(SELECT cpf FROM TB_CLIENTS);

SELECT * FROM TB_CLIENTS;

-- ---------------- IMPORTING FROM AN EXTERN FILES ---------------- --
-- Using Table data import wizard;
SELECT * FROM TB_SALESPEOPLE;

        
