CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE customers(
	customer_id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) not null
);

CREATE TABLE orders(
	order_id int primary key auto_increment,
    customer_id int,
    order_date date default(current_date()),
    total_amount int not null,
    foreign key (customer_id) references customers(customer_id)
);

INSERT INTO customers (name, email) VALUES
('Nguyễn Văn A', 'nva@example.com'),
('Trần Thị B', 'ttb@example.com'),
('Lê Văn C', 'lvc@example.com'),
('Phạm Thị D', 'ptd@example.com'),
('Hoàng Minh E', 'hme@example.com'),
('Vũ Thị F', 'vtf@example.com'),
('Đỗ Quốc G', 'dqg@example.com');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-08-01', 120000),
(2, '2024-08-03', 85000),
(1, '2024-08-10', 45000),
(3, '2024-08-12', 230000),
(4, '2024-08-15', 99000),
(5, '2024-08-20', 150000),
(6, '2024-08-22', 76000),
(7, '2024-08-25', 300000),
(2, '2024-08-28', 54000);

SELECT * FROM customers WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders WHERE customer_id IS NOT NULL);
