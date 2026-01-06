USE Homework01;

CREATE TABLE products(
	product_id int primary key auto_increment,
    product_name varchar(255) not null,
    price decimal(10,0) not null
);

CREATE TABLE order_items(
	order_id int,
    product_id int,
    quantity int not null,
    primary key(order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

INSERT INTO products (product_name, price) VALUES
('Áo thun nam', 150000),
('Quần jean', 320000),
('Giày thể thao', 750000),
('Mũ lưỡi trai', 120000),
('Túi xách nữ', 450000),
('Đồng hồ', 1250000),
('Kính mát', 220000),
('Vớ thể thao (3 đôi)', 60000),
('Áo khoác', 680000),
('Balo laptop', 390000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 8, 1),
(2, 3, 1),
(3, 2, 1),
(4, 5, 2),
(5, 6, 1),
(6, 7, 3),
(7, 4, 2),
(8, 9, 1),
(9, 8, 4);

SELECT product_id, product_name FROM products WHERE product_id IN (SELECT DISTINCT product_id FROM order_items WHERE product_id IS NOT NULL);