CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE customers(
	customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

CREATE TABLE orders(
	order_id int primary key,
    customer_id int,
    order_date date default(current_date()),
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

INSERT INTO customers (customer_id, full_name, city) VALUES
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Hải Phòng'),
(3, 'Lê Văn C', 'Đà Nẵng'),
(4, 'Phạm Thị D', 'Hồ Chí Minh'),
(5, 'Hoàng Văn E', 'Cần Thơ');

INSERT INTO orders (order_id, customer_id, order_date, status, total_amount) VALUES
(1,  1, '2025-09-01', 'completed', 100000),
(2,  2, '2025-09-02', 'pending', 150000),
(3,  3, '2025-09-03', 'completed', 2235000),
(4,  4, '2025-09-04', 'cancelled', 1000000),
(5,  1, '2025-09-05', 'completed', 500000),
(6,  1, '2025-09-06', 'pending', 1250000),
(7,  2, '2025-09-07', 'completed', 600000),
(8,  3, '2025-09-08', 'pending', 550000),
(9,  4, '2025-09-09', 'completed', 300000),
(10, 4, '2025-09-10', 'cancelled', 400000);

SELECT o.order_id, o.order_date, o.status, c.full_name
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE o.status <> 'cancelled';

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id AND o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name;

SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 0;