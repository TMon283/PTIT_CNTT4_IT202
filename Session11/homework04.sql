USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE create_post_with_validation(
    IN p_user_id INT,
    IN p_content TEXT,
    OUT result_message VARCHAR(255)
)
BEGIN
    IF CHAR_LENGTH(p_content) < 5 THEN
        SET result_message = 'Nội dung quá ngắn';
    ELSE
        INSERT INTO posts (user_id, content, created_at)
        VALUES (p_user_id, p_content, NOW());
        
        SET result_message = 'Thêm bài viết thành công';
    END IF;
END $$

DELIMITER ;

SET @comment1 = '';
CALL create_post_with_validation(3, 'Hi', @comment1);
SELECT @comment1 AS result_message; 

SET @comment2 = '';
CALL create_post_with_validation(3, 'Đây là bài viết thử nghiệm', @comment2);
SELECT @comment2 AS result_message;  

SELECT post_id, user_id, content, created_at
FROM posts
WHERE user_id = 3
ORDER BY created_at DESC
LIMIT 10;

DROP PROCEDURE IF EXISTS create_post_with_validation;

