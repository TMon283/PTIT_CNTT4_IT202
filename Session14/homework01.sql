-- Tạo database và dùng
CREATE DATABASE IF NOT EXISTS homework01;
USE homework01;

-- Bảng users
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    posts_count INT DEFAULT 0
);

-- Bảng posts
CREATE TABLE IF NOT EXISTS posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Thêm 1 user mẫu để test trường hợp thành công
INSERT INTO users (username) VALUES ('Nguyễn Văn Chung');

DELIMITER $$

CREATE PROCEDURE create_post (
    IN p_user_id int,
    IN p_content text
)
BEGIN
    DECLARE v_exists int default 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION

    START TRANSACTION;

    SELECT COUNT(*) INTO v_exists
    FROM users
    WHERE user_id = p_user_id
    FOR UPDATE;

    IF v_exists = 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Người dùng không tồn tại';
    ELSE
        INSERT INTO posts (user_id, content)
        VALUES (p_user_id, p_content);

        UPDATE users
        SET posts_count = posts_count + 1
        WHERE user_id = p_user_id;

        COMMIT;
    END IF;
END$$

DELIMITER ;

CALL create_post(1, 'Bài viết đầu tiên của tôi (test commit)');
CALL create_post(1, 'Bài viết thử nghiệm 2 của user 1.');
CALL create_post(1, 'Bài viết thử nghiệm 3 của user 1.');
CALL create_post(1, 'Bài viết thử nghiệm 4 của user 1.');
CALL create_post(1, 'Bài viết thử nghiệm 5 của user 1.');
CALL create_post(1, 'Bài viết thử nghiệm 6 của user 1.');

SELECT * FROM posts WHERE user_id = 1;
SELECT user_id, username, posts_count FROM users WHERE user_id = 1;

CALL create_post(99, 'Bài viết lỗi vì user_id không tồn tại');

SELECT * FROM posts WHERE user_id = 99;

SELECT * FROM users;