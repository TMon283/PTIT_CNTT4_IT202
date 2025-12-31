USE Homework02;

SELECT * FROM Orders WHERE order_status <> 'cancelled' ORDER BY order_date DESC, order_id DESC LIMIT 5 OFFSET 0;

SELECT * FROM Orders WHERE order_status <> 'cancelled' ORDER BY order_date DESC, order_id DESC LIMIT 5 OFFSET 5; 

SELECT * FROM Orders WHERE order_status <> 'cancelled' ORDER BY order_date DESC, order_id DESC LIMIT 5 OFFSET 10;