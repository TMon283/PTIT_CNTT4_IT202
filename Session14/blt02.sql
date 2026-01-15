CREATE DATABASE blt02;
USE blt02;

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    stock INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_name, price, stock) VALUES
('Laptop Dell', 1500.00, 10),
('iPhone 13', 1200.00, 8),
('Samsung TV', 800.00, 5),
('AirPods Pro', 250.00, 20),
('MacBook Air', 1300.00, 7);

DELIMITER $$

CREATE PROCEDURE check_stock (
    IN p_product_id int,
    IN p_quantity int
)
BEGIN
	DECLARE current_stock int;
    START TRANSACTION;

    SELECT stock INTO current_stock
    FROM products
    WHERE product_id = p_product_id
    FOR UPDATE;

    IF current_stock < p_quantity THEN
		ROLLBACK;
    ELSE
		INSERT INTO orders (product_id, quantity) VALUES 
        (p_product_id, p_quantity);
        UPDATE products
        SET stock = stock - p_quantity
        WHERE product_id = p_product_id;
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

CALL place_order(1, 5);
SELECT * FROM products;
SELECT * FROM orders;
