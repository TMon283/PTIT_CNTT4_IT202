CREATE DATABASE trigger_practice;
USE trigger_practice;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at DATETIME
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    created_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    action VARCHAR(20),
    action_time DATETIME,
    description TEXT
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    stock INT
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    sale_time DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Bài 1
DELIMITER $$

CREATE TRIGGER validate_insert_customer
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF NEW.created_at IS NULL THEN
        SET NEW.created_at = NOW();
    END IF;
END$$

DELIMITER ;

-- Bài 2
DELIMITER $$

CREATE TRIGGER log_insert_customer
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
	INSERT INTO audit_log(table_name, action, action_time, description) VALUES
    ('customer','INSERT',NOW(),concat('Thêm khách hàng mới:', NEW.name));
END$$

DELIMITER ;
-- Bài 3


-- Bài 4
-- Bài 5
-- Bài 6
-- Bài 7
-- Bài 8
-- Bài 9
-- Bài 10