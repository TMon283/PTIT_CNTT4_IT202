USE Homework01;

SELECT order_id, order_date, total_amount FROM orders WHERE total_amount > (SELECT AVG(total_amount) FROM orders);