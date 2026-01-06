USE Homework01;

SELECT name, (
	SELECT COUNT(*) FROM orders WHERE customer_id = customers.customer_id
) AS 'Số lượng đơn'
FROM customers;