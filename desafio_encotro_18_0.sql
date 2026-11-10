-- DESAFIO 01 
USE DB_T05072B_JERUZA_PEREIRA;
-- 2. Limpeza prévia das tabelas
-- 1. Criação e seleção do banco de dados
CREATE DATABASE IF NOT EXISTS DB_T05072_JERUZA_PEREIRA;
USE DB_T05072_JERUZA_PEREIRA;

-- 2. Desativar temporariamente a checagem de chave estrangeira para limpeza segura
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS tb_funcionarios;
DROP TABLE IF EXISTS tb_departamentos;
DROP TABLE IF EXISTS tb_faixa_salarial;

SET FOREIGN_KEY_CHECKS = 1;

-- 3. Criação das Tabelas
CREATE TABLE tb_departamentos (
    id_departamento INT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE tb_funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES tb_departamentos(id_departamento)
);

CREATE TABLE tb_faixa_salarial (
    id_faixa INT PRIMARY KEY,
    nivel VARCHAR(50) NOT NULL,
    salario_min DECIMAL(10,2) NOT NULL,
    salario_max DECIMAL(10,2) NOT NULL
);

-- 4. Inserção de Dados

-- Departamentos (incluindo 'Inovação' sem funcionários)
INSERT INTO tb_departamentos (id_departamento, nome_departamento) VALUES
(1, 'Financeiro'),
(2, 'RH'),
(3, 'TI'),
(4, 'Vendas'),
(5, 'Inovação');

-- Funcionários
INSERT INTO tb_funcionarios (id_funcionario, nome_funcionario, salario, id_departamento) VALUES
(1, 'Ana', 1800.00, 1),
(2, 'Bruno', 2500.00, 4), 
(3, 'Carlos', 3200.00, 2),
(4, 'Daniela', 4500.00, 4), 
(5, 'Eduardo', 5200.00, 3),
(6, 'Fernanda', 7000.00, 4);

-- Faixas Salariais
INSERT INTO tb_faixa_salarial (id_faixa, nivel, salario_min, salario_max) VALUES
(1, 'Junior', 0.00, 2000.00),
(2, 'Pleno', 2001.00, 5000.00),
(3, 'Senior', 5001.00, 99999.00);

-- CONSULTAS DOS DESAFIOS PARA TESTES

-- Desafio 1: Mapeamento de Departamentos (Join Externa / LEFT JOIN)
-- Lista todos os departamentos, mostrando o funcionário ou NULL se não houver
SELECT 
    d.nome_departamento,
    f.nome_funcionario
FROM tb_departamentos AS d
LEFT JOIN tb_funcionarios AS f 
    ON d.id_departamento = f.id_departamento;


-- Desafio 2: Classificação de Salários (Join Não-Identificada com BETWEEN)
-- Associa cada funcionário ao seu respectivo nível salarial
SELECT 
    f.nome_funcionario,
    f.salario,
    fs.nivel AS nivel_salarial
FROM tb_funcionarios AS f
JOIN tb_faixa_salarial AS fs
    ON f.salario BETWEEN fs.salario_min AND fs.salario_max;


-- Desafio 3: Relatório Específico (3 Tabelas + WHERE)
-- Lista funcionários do nível 'Pleno' que trabalham no departamento de 'Vendas'
SELECT 
    f.nome_funcionario
FROM tb_funcionarios AS f
JOIN tb_departamentos AS d 
    ON f.id_departamento = d.id_departamento
JOIN tb_faixa_salarial AS fs 
    ON f.salario BETWEEN fs.salario_min AND fs.salario_max
WHERE fs.nivel = 'Pleno' 
  AND d.nome_departamento = 'Vendas';