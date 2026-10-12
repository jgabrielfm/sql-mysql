-- 1. Criação e Seleção do Banco de Dados
CREATE DATABASE IF NOT EXISTS db_loja_completa;
USE db_loja_completa;

-- 2. Limpeza prévia (remover tabelas se já existirem)
DROP TABLE IF EXISTS pagamentos;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;

-- 3. Tabela 1: CLIENTES
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50)
);

-- 4. Tabela 2: PEDIDOS
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    valor_total DECIMAL(10,2),
    data_pedido DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 5. Tabela 3: PAGAMENTOS
CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    forma_pagamento VARCHAR(50),
    status VARCHAR(30),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- 6. Inserção de Dados: CLIENTES
INSERT INTO clientes (id_cliente, nome, cidade) VALUES
(1, 'Ana Silva', 'São Paulo'),
(2, 'Bruno Costa', 'Rio de Janeiro'),
(3, 'Carla Dias', 'Belo Horizonte'),
(4, 'Diego Lima', 'Curitiba');

-- 7. Inserção de Dados: PEDIDOS
INSERT INTO pedidos (id_pedido, id_cliente, valor_total, data_pedido) VALUES
(101, 1, 150.50, '2026-03-01'), -- Pedido da Ana
(102, 1, 89.90,  '2026-03-05'), -- Outro pedido da Ana
(103, 2, 210.00, '2026-03-10'), -- Pedido do Bruno
(104, NULL, 45.00, '2026-03-12'),-- Pedido balcão (Sem cliente)
(105, NULL, 300.00, '2026-03-15');-- Pedido balcão (Sem cliente)

-- 8. Inserção de Dados: PAGAMENTOS
INSERT INTO pagamentos (id_pagamento, id_pedido, forma_pagamento, status) VALUES
(1, 101, 'Cartão de Crédito', 'Aprovado'),
(2, 102, 'Pix', 'Aprovado'),
(3, 104, 'Dinheiro', 'Aprovado'); -- Pagamento do pedido 104 (que é anônimo!)
                                 -- Observação: O pedido 103 (Bruno) e 105 não possuem pagamento cadastrado.
