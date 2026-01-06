USE Homework01;

SELECT (
	SELECT name 
    FROM customers 
    WHERE customer_id = t.customer_id) 
    AS customer_name, t.total_spent
FROM (
	SELECT customer_id, SUM(total_amount) 
    AS total_spent 
    FROM orders 
    GROUP BY customer_id) 
    AS t
WHERE t.total_spent = (
	SELECT MAX(total_per_customer) 
    FROM (
		SELECT SUM(total_amount) 
        AS total_per_customer 
        FROM orders 
        GROUP BY customer_id
  ) AS per_customer_totals
);
