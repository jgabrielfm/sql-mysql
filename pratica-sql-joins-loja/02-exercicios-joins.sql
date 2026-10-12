-- Lista de Exercícios — SQL JOINS
-- Banco de Dados: db_loja_completa
-- Tabelas: clientes, pedidos, pagamentos

USE db_loja_completa;

-- =========================================================
-- MÓDULO 1: NÍVEL BÁSICO (RELACIONAMENTOS DE 2 TABELAS)
-- =========================================================

-- Exercício 1 — INNER JOIN entre Clientes e Pedidos
SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;

-- Exercício 2 — LEFT JOIN Preservando Clientes
SELECT clientes.nome, clientes.cidade, pedidos.id_pedido
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;

-- Exercício 3 — RIGHT JOIN Preservando Pedidos
SELECT pedidos.id_pedido, pedidos.valor_total, clientes.nome
FROM clientes
RIGHT JOIN pedidos ON pedidos.id_cliente = clientes.id_cliente;

-- Exercício 4 — INNER JOIN com Pagamentos
SELECT pedidos.id_pedido, pedidos.valor_total, pagamentos.forma_pagamento
FROM pedidos
INNER JOIN pagamentos ON pedidos.id_pedido = pagamentos.id_pedido;

-- Exercício 5 — Identificando Lacunas (LEFT JOIN + IS NULL)
SELECT clientes.id_cliente, clientes.nome, clientes.cidade
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
WHERE pedidos.id_pedido IS NULL;

-- =========================================================
-- MÓDULO 2: NÍVEL INTERMEDIÁRIO (FILTROS E AGRUPAMENTOS)
-- =========================================================

-- Exercício 6 — Visão de Status de Pagamento
SELECT pedidos.id_pedido, pedidos.valor_total, pagamentos.status
FROM pedidos
LEFT JOIN pagamentos ON pedidos.id_pedido = pagamentos.id_pedido;

-- Exercício 7 — Filtrando Vendas de Balcão
SELECT pedidos.id_pedido, pedidos.data_pedido, pedidos.valor_total
FROM pedidos
WHERE pedidos.id_cliente IS NULL;

-- Exercício 8 — Total Consumido por Cliente (INNER JOIN + SUM)
SELECT clientes.nome, SUM(pedidos.valor_total) AS total_gasto
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.nome
ORDER BY total_gasto DESC;

-- Exercício 9 — Total por Cliente Amplo (LEFT JOIN + SUM)
SELECT clientes.nome, SUM(pedidos.valor_total) AS total_gasto
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.nome
ORDER BY total_gasto DESC;

-- Exercício 10 — Contagem por Cidade (COUNT + GROUP BY)
SELECT clientes.cidade, COUNT(pedidos.id_pedido) AS quantidade_pedidos
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
GROUP BY clientes.cidade
ORDER BY quantidade_pedidos DESC;

-- =========================================================
-- MÓDULO 3: NÍVEL AVANÇADO (3 TABELAS E FULL JOIN VIA UNION)
-- =========================================================

-- Exercício 11 — JOIN Triplo Estrito
SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total, pagamentos.forma_pagamento
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
INNER JOIN pagamentos ON pedidos.id_pedido = pagamentos.id_pedido;

-- Exercício 12 — Funil Completo com LEFT JOIN Triplo
SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total, pagamentos.forma_pagamento
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
LEFT JOIN pagamentos ON pedidos.id_pedido = pagamentos.id_pedido;

-- Exercício 13 — Diagnóstico de Inadimplência
SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total,
       'Pendente' AS status_pagamento
FROM clientes
INNER JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente
LEFT JOIN pagamentos ON pedidos.id_pedido = pagamentos.id_pedido
WHERE pagamentos.id_pagamento IS NULL;

-- Exercício 14 — Tratamento de Nulos com Junção de Conjuntos (UNION)
SELECT pagamentos.id_pagamento, pagamentos.forma_pagamento, clientes.nome AS nome_cliente
FROM pagamentos
INNER JOIN pedidos ON pagamentos.id_pedido = pedidos.id_pedido
INNER JOIN clientes ON pedidos.id_cliente = clientes.id_cliente

UNION

SELECT pagamentos.id_pagamento, pagamentos.forma_pagamento, 'Cliente Não Identificado'
FROM pagamentos
INNER JOIN pedidos ON pagamentos.id_pedido = pedidos.id_pedido
WHERE pedidos.id_cliente IS NULL

ORDER BY id_pagamento;

-- Exercício 15 — Simulação de FULL OUTER JOIN no MySQL
SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total
FROM clientes
LEFT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente

UNION

SELECT clientes.nome, pedidos.id_pedido, pedidos.valor_total
FROM clientes
RIGHT JOIN pedidos ON clientes.id_cliente = pedidos.id_cliente;
