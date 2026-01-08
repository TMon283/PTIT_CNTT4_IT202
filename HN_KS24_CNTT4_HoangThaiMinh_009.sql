CREATE DATABASE hackathon;
USE hackathon;

CREATE TABLE customers(
	customer_id VARCHAR(5) primary key,
	customer_name VARCHAR(100) not null,
	customer_email VARCHAR(100) not null unique,
	customer_phone VARCHAR(15) not null unique,
	customer_address VARCHAR(255) not null
);

CREATE TABLE products(
	product_id VARCHAR(5) primary key,
	product_name VARCHAR(50) not null,
	product_price DECIMAL(10, 2) not null,
	category VARCHAR(20) not null,
	stock_quantity INT not null
);

CREATE TABLE orders(
	order_id INT primary key auto_increment,
	customer_id VARCHAR(5) not null,
	product_id VARCHAR(5) not null,
	order_date DATE not null,
	order_quantity INT not null,
	total_amount DECIMAL(10, 2) not null,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);

CREATE TABLE payments(
	payment_id INT primary key auto_increment,
	order_id INT not null,
	payment_method VARCHAR(50) not null,
	payment_date DATE not null,
	payment_status VARCHAR(50) not null,
    foreign key (order_id) references orders(order_id)
);

INSERT INTO customers(customer_id, customer_name, customer_email, customer_phone, customer_address) VALUES
('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0987654321', 'Hanoi'),
('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0987654322', 'Ho Chi Minh'),
('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0987654323', 'Da Nang'),
('C004', 'Pham Hoang Nam', 'nam.pham@example.com', '0987654324', 'Hue'),
('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0987654325', 'Hai Phong');

INSERT INTO products(product_id, product_name, category, product_price, stock_quantity) VALUES
('P001', 'Laptop Dell', 'Electronics', 15000.00, 10),
('P002', 'iPhone 15', 'Electronics', 20000.00, 5),
('P003', 'T-Shirt', 'Clothing', 200.00, 50),
('P004', 'Running Shoes', 'Footwear', 1500.00, 20),
('P005', 'Table Lamp', 'Furniture', 500.00, 15);

INSERT INTO orders(order_id, customer_id, product_id, order_date, order_quantity, total_amount) VALUES
(1, 'C001', 'P001', '2025-06-01', 1, 15000.00),
(2, 'C002', 'P003', '2025-06-02', 2, 400.00),
(3, 'C003', 'P002', '2025-06-03', 1, 20000.00),
(4, 'C001', 'P004', '2025-06-03', 1, 1500.00),
(5, 'C005', 'P001', '2025-06-04', 2, 30000.00);

INSERT INTO payments(payment_id, order_id, payment_date, payment_method, payment_status) VALUES
(1, 1, '2025-06-01', 'Banking', 'Paid'),
(2, 2, '2025-06-02', 'Cash', 'Paid'),
(3, 3, '2025-06-03', 'Credit Card', 'Paid'),
(4, 4, '2025-06-04', 'Banking', 'Pending'),
(5, 5, '2025-06-05', 'Credit Card', 'Paid');

-- 3. Cập nhật thông tin khách hàng. Viết câu lệnh thay đổi số điện thoại của khách hàng có customer_id = 'C001' thành "0999888777"
UPDATE customers
SET customer_phone = '0999888777'
WHERE customer_id = 'C001';

-- 4. Thay đổi kho hàng với product_id = 'P003', cập nhật stock_quantity tăng thêm 50 đơn vị và tăng product_price lên 10%
UPDATE products
SET stock_quantity = stock_quantity + 50 AND product_price = product_price * 1.1
WHERE product_id = 'P003';

-- 5. Xóa tất cả các bản ghi trong bảng Payment có payment_status là "Pending" và phương thức thanh toán là "Banking"
DELETE FROM payments
WHERE payment_status = 'Pending' AND payment_method = 'Banking';

-- 6. Liệt kê danh sách sản phẩm gồm các cột: product_id, product_name, product_price thuộc danh mục 'Electronics' và có giá lớn hơn 10000
SELECT product_id, product_name, product_price FROM products 
WHERE category = 'Electronic' AND product_price > 10000.00;

-- 7. Lấy thông tin customer_name, customer_email, customer_address của những khách hàng có họ là 'Nguyen'
SELECT customer_name, customer_email, customer_address FROM customers
WHERE customer_name LIKE 'Nguyen %';

-- 8. Hiển thị danh sách tất cả các đơn hàng gồm: order_id, order_date, total_amount. Kết quả sắp xếp theo total_amount giảm dần
SELECT order_id, order_date, total_amount FROM orders
ORDER BY total_amount DESC;

-- 9. Lấy thông tin 3 bản ghi thanh toán mới nhất theo payment_date trong bảng Payment
SELECT * FROM payments
ORDER BY payment_date DESC
LIMIT 3;

-- 10. Hiển thị thông tin các sản phẩm (product_id, product_name) từ bảng Product, bỏ qua 2 bản ghi đầu tiên và lấy 3 bản ghi tiếp theo
SELECT product_id, product_name FROM products
LIMIT 3 OFFSET 2;

-- 11. Hiển thị danh sách đơn hàng gồm: order_id, customer_name , product_name và total_amount. Chỉ lấy những đơn hàng có total_amount lớn hơn 1000
SELECT o.order_id, c.customer_name , p.product_name, o.total_amount FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.product_id
WHERE total_amount > 1000;

-- 12. Liệt kê tất cả các sản phẩm trong hệ thống gồm: product_id, product_name và order_id tương ứng (nếu có). Kết quả phải bao gồm cả những sản phẩm chưa từng được đặt hàng
SELECT p.product_id, p.product_name, o.order_id
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
ORDER BY p.product_id;

-- 13. Tính tổng danh thu cho từng loại sản phẩm. Kết quả hiển thị 2 cột: category và Total_Revenue
SELECT p.category, SUM(order_quantity*total_amount) AS Total_revenue FROM orders o
JOIN products p ON p.product_id = o.product_id
GROUP BY p.category;

-- 14. Thống kê số lượng đơn hàng của mỗi khách hàng. Hiển thị customer_name và Order_Count. Chỉ hiện những khách hàng đã đặt từ 2 đơn trở lên
SELECT c.customer_name, COUNT(o.order_id) AS Order_Count FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY Order_Count DESC;

-- 15. Lấy thông tin chi tiết các đơn hàng (order_id, customer_name, rototal_amount) có giá trị đơn hàng cao hơn giá trị trung bình của tất cả các đơn hàng trong bảng Order
SELECT o.order_id, c.customer_name, o.total_amount FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.total_amount*o.order_quantity > (SELECT AVG(total_amount*order_quantity) FROM orders);

-- 16. Hiển thị customer_name và customer_phone của những khách hàng đã từng mua sản phẩm có danh mục là 'Electronics'


-- 17. Hiển thị thông tin tổng hợp gồm: order_id, customer_name, product_name, payment_method và payment_status
SELECT o.order_id, c.customer_name, p.product_name, pm.payment_method, pm.payment_status FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.product_id
JOIN payments pm ON pm.order_id = o.order_id

