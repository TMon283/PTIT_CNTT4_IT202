USE Homework01;

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS 'Tổng đơn hàng', SUM(o.total_amount) AS 'Tổng chi', AVG(o.total_amount) AS 'Giá trị trung bình'
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) >= 3 AND SUM(o.total_amount) > 10000000
ORDER BY SUM(o.total_amount) DESC;
