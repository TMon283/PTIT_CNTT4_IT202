USE Homework01;

ALTER TABLE Products ADD sold_quantity int;

UPDATE Products SET sold_quantity = 10 WHERE product_id = 1;
UPDATE Products SET sold_quantity = 30 WHERE product_id = 2;
UPDATE Products SET sold_quantity = 20 WHERE product_id = 3;
UPDATE Products SET sold_quantity = 25 WHERE product_id = 4;
UPDATE Products SET sold_quantity = 20 WHERE product_id = 5;

INSERT INTO Products(product_id, product_name, price, stock, product_status, sold_quantity) VALUES
(6, 'Điện thoại A1', 4990000.00, 150),
(7, 'Tai nghe Bluetooth X', 750000.00, 320),
(8, 'Laptop Lite 14"', 12990000.00, 45),
(9, 'Chuột không dây M2', 250000.00, 480),
(10, 'Bàn phím cơ K7', 1200000.00, 210),
(11, 'Màn hình 24 inch', 3990000.00, 85),
(12, 'Sạc dự phòng 10000mAh', 350000.00, 600),
(13, 'Loa Bluetooth B5', 890000.00, 140),
(14, 'Ổ cứng SSD 512GB', 1590000.00, 95),
(15, 'USB 64GB', 180000.00, 420),
(16, 'Camera hành trình', 2190000.00, 60),
(17, 'Máy in đa năng', 3290000.00, 30),
(18, 'Balo laptop 15"', 450000.00, 270),
(19, 'Webcam Full HD', 680000.00, 110),
(20, 'Router WiFi AC1200', 990000.00, 130),
(21, 'Ổ cắm thông minh', 220000.00, 340),
(22, 'Microphone thu âm', 1450000.00, 55),
(23, 'Đèn bàn LED', 210000.00, 260),
(24, 'Tai nghe gaming Pro', 2590000.00, 75),
(25, 'Bộ vệ sinh laptop', 90000.00, 510);

SELECT product_id, product_name, price, sold_quantity FROM products ORDER BY sold_quantity DESC LIMIT 10;

SELECT product_id, product_name, price, sold_quantity FROM products ORDER BY sold_quantity DESC LIMIT 5 OFFSET 10;

SELECT product_id, product_name, price, sold_quantity FROM products WHERE price < 2000000 ORDER BY sold_quantity DESC;

