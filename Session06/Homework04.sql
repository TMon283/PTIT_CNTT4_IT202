USE Homework01;

CREATE TABLE products(
	product_id int primary key,
    product_name varchar(255) not null,
    price decimal(10,0) not null
);

CREATE TABLE order_item(
	order_id int,
    product_id int,
    quantity int not null,
    primary key(order_id, product_id),
    foreign key(order_id) references orders(order_id),
	foreign key(product_id) references products(product_id)
);

INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Điện thoại A1', 4990000),
(2, 'Tai nghe Bluetooth X', 750000),
(3, 'Laptop Lite 14', 12990000),
(4, 'Chuột không dây M2', 250000),
(5, 'Ổ cứng SSD 512GB', 1590000),
(6, 'Sạc dự phòng 10000mAh', 350000),
(7, 'Loa Bluetooth B5', 890000);

INSERT INTO order_item (order_id, product_id, quantity) VALUES
(1, 1, 1),  
(1, 4, 2),   
(2, 2, 1), 
(3, 3, 1),   
(5, 5, 2),   
(6, 6, 3),  
(7, 7, 1),   
(8, 2, 2),   
(9, 4, 1);  

SELECT p.product_id, p.product_name, SUM(oit.quantity) AS 'Sản phẩm'
FROM products AS p
JOIN order_item AS oit ON p.product_id = oit.product_id
GROUP BY p.product_id, p.product_name;

SELECT p.product_id, p.product_name, SUM(oit.quantity*p.price) AS 'Doanh thu'
FROM products AS p
JOIN order_item AS oit ON p.product_id = oit.product_id
GROUP BY p.product_id, p.product_name;

SELECT p.product_id, p.product_name, SUM(oit.quantity*p.price) AS 'Doanh thu'
FROM products AS p
JOIN order_item AS oit ON p.product_id = oit.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(oit.quantity*p.price) > 5000000;
