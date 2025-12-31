CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE Products(
	product_id int primary key,
    product_name varchar(255) not null,
    price decimal(10,0) check(price > 0) not null,
    stock int check(stock >= 0),
    product_status enum('active', 'inactive')
);

INSERT INTO Products(product_id, product_name, price, stock, product_status) VALUES
(1,  'Điện thoại A1', 4990000.00, 50, 'active'),
(2,  'Tai nghe Bluetooth X', 1250000.00, 120, 'active'),
(3,  'Laptop Lite 14"', 12990000.00, 20, 'active'),
(4,  'Chuột không dây M2', 1200000.00, 200, 'inactive'),
(5,  'Bàn phím cơ K7', 1200000.00, 80, 'active');

SELECT * FROM Products;

SELECT * FROM Products WHERE product_status = 'active';

SELECT * FROM Products WHERE price > 1000000;

SELECT * FROM Products WHERE product_status = 'active' ORDER BY price ASC;

