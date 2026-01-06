USE Homework01;

SELECT customer_id, (SELECT name FROM customers WHERE customer_id = orders.customer_id) AS 'Tên khách hàng'
FROM orders 
GROUP BY customer_id
HAVING SUM(total_amount) > (SELECT AVG(total_per_customer) FROM ( 
	SELECT SUM(total_amount) AS total_per_customer FROM orders GROUP BY customer_id 
    ) AS per_customer_totals);