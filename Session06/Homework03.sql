USE Homework01;

SELECT order_date, SUM(total_amount) AS 'Tổng tiền'
FROM orders
WHERE status <> 'cancelled'
GROUP BY order_date;

SELECT order_date, COUNT(order_id) AS 'Số đơn hàng'
FROM orders
WHERE status <> 'cancelled'
GROUP BY order_date;

SELECT order_date, SUM(total_amount) AS 'Tổng tiền'
FROM orders
WHERE status <> 'cancelled'
GROUP BY order_date
HAVING SUM(total_amount) > 1000000;