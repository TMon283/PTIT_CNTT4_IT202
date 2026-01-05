USE Homework01;

SELECT p.product_id, p.product_name, SUM(oit.quantity) AS 'Tổng số lượng bán', SUM(oit.quantity * p.price) AS 'Tổng doanh thu', SUM(oit.quantity * p.price) / SUM(oi.quantity) AS 'Giá trung bình'
FROM products AS p
JOIN order_item AS oit ON p.product_id = oit.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oit.quantity) >= 10
ORDER BY total_revenue DESC LIMIT 5;
