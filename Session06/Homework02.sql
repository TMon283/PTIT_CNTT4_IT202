USE Homework01;

ALTER TABLE orders ADD total_amount decimal(10,0);

SELECT c.customer_id, c.full_name, SUM(o.total_amount) AS 'Tổng tiền'
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id AND o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id, c.full_name, MAX(o.total_amount) AS 'Tổng tiền'
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id AND o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id, c.full_name, SUM(o.total_amount) AS 'Tổng tiền'
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id AND o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY SUM(o.total_amount) DESC;