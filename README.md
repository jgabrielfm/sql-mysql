# 🗄️ SQL & MySQL

Exercícios práticos de **SQL** feitos no **MySQL Workbench**, organizados por tema. Cada pasta tem o script de criação do banco, as consultas e um README com o modelo de dados.

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=flat-square&logo=databricks&logoColor=white)

## Exercícios

| Pasta | Tema | Conceitos praticados |
|---|---|---|
| [pratica-sql-joins-loja](pratica-sql-joins-loja) | 🛒 **JOINs em uma loja**: clientes, pedidos e pagamentos, em 15 consultas de três níveis | `INNER` / `LEFT` / `RIGHT JOIN`, JOIN triplo, `SUM`, `COUNT`, `GROUP BY`, `UNION`, `FULL OUTER JOIN` simulado |

## Como executar

Em cada pasta, rode primeiro o script de criação (`01-...sql`) e depois o de consultas (`02-...sql`), no MySQL Workbench ou pelo terminal:

```bash
mysql -u root -p < 01-criacao-banco.sql
mysql -u root -p --table < 02-exercicios-joins.sql
```
