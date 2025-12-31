USE Homework02;

CREATE TABLE Orders(
	order_id int primary key,
    customer_id int,
    total_amount decimal(10,2) not null,
    order_date date default(current_date()),
    order_status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references Customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, order_status) VALUES
(1,  1, 4500000.00, '2025-09-01', 'completed'),
(2,  2, 5200000.50, '2025-09-02', 'pending'),
(3,  3, 7500000.00, '2025-09-03', 'completed'),
(4,  4, 1200000.00, '2025-09-04', 'cancelled'),
(5,  5, 9800000.00, '2025-09-05', 'completed'),
(6,  1, 3000000.00, '2025-09-06', 'pending'),
(7,  1, 5100000.00, '2025-09-07', 'completed'),
(8,  1, 15000000.00,'2025-09-08', 'completed'),
(9,  2, 4999999.99, '2025-09-09', 'pending'),
(10, 3, 6000000.00, '2025-09-10', 'completed'),
(11, 2, 2500000.00, '2025-09-11', 'pending'),
(12, 3, 8200000.00, '2025-09-12', 'completed'),
(13, 3, 430000.00,  '2025-09-13', 'cancelled'),
(14, 1, 12500000.00,'2025-09-14', 'completed'),
(15, 2, 2750000.00, '2025-09-15', 'pending'),
(16, 4, 5050000.00, '2025-09-16', 'completed'),
(17, 5, 1999999.99, '2025-09-17', 'pending'),
(18, 1, 9990000.00, '2025-09-18', 'completed'),
(19, 3, 150000.00,  '2025-09-19', 'cancelled'),
(20, 2, 7200000.00, '2025-09-20', 'completed');

SELECT * FROM orders WHERE order_status = 'completed';

SELECT * FROM orders WHERE total_amount > 5000000;

SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;

SELECT * FROM orders WHERE order_status = 'completed' ORDER BY total_amount DESC;



