CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE Products(
	product_id int primary key,
    product_name varchar(255) not null,
    price decimal(10,2) check(price > 0) not null,
    stock int check(stock >= 0),
    product_status enum('active', 'inactive')
);

INSERT INTO Products(product_id, product_name, price, stock, product_status) VALUES
(1, 'Cocacola', '17000', 100, 'active'),
(2, 'Pepsi', '16000', 70, 'active'),
(3, 'Fanta', '15000', 120, 'active'),
(4, 'Sting', '10000', 200, 'inactive'),
(5, 'Rượu vang', '13000000', 20, 'active');

SELECT * FROM Products;

SELECT * FROM Products WHERE product_status = 'active';

SELECT * FROM Products WHERE price > 1000000;

SELECT * FROM Products WHERE product_status = 'active' ORDER BY price ASC;

