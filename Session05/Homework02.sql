CREATE DATABASE Homework02;
USE Homework02;

CREATE TABLE Customers(
	customer_id int primary key,
    full_name varchar(255) not null,
    email varchar(255) unique not null,
    city varchar(255) not null,
    customer_status enum('active', 'inactive')
);

INSERT INTO Customers(customer_id, full_name, email, city, customer_status) VALUES
(1, 'Hoàng Thái Minh', 'lemonboy2k6@gmail.com', 'Hà Nội', 'active'),
(2, 'Nguyễn Doanh Tuấn', 'dtug06@gmail.com', 'Phú Thọ', 'active'),
(3, 'Lê Trung Chiến', 'trungchien195@gmail.com', 'Thanh Hóa', 'active'),
(4, 'Hoàng Văn A', 'hoangvana@gmail.com', 'TP.HCM', 'inactive'),
(5, 'Nguyễn Thị B', 'nguyenthib@gmail.com', 'TP.HCM', 'active');

SELECT * FROM Customers;

SELECT * FROM Customers WHERE city = 'TP.HCM';

SELECT * FROM Customers WHERE city = 'Hà Nội' AND customer_status = 'active';

SELECT * FROM Customers ORDER BY full_name ASC;