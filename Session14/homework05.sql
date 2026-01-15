USE homework01;

CREATE TABLE delete_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    deleted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted_by INT NOT NULL
);

DELIMITER $$

CREATE PROCEDURE sp_delete_post(
    IN p_post_id INT,
    IN p_user_id INT
)
BEGIN
    DECLARE v_owner_id INT;
    DECLARE v_error INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET v_error = 1;
    END;

    START TRANSACTION;

    -- Kiểm tra bài viết tồn tại và quyền sở hữu
    SELECT user_id
    INTO v_owner_id
    FROM posts
    WHERE post_id = p_post_id;

    IF v_owner_id IS NULL OR v_owner_id <> p_user_id THEN
        SET v_error = 1;
    END IF;

    -- Nếu không lỗi mới tiếp tục xóa
    IF v_error = 0 THEN

        DELETE FROM likes
        WHERE post_id = p_post_id;

        DELETE FROM comments
        WHERE post_id = p_post_id;

        DELETE FROM posts
        WHERE post_id = p_post_id;

        UPDATE users
        SET posts_count = posts_count - 1
        WHERE user_id = p_user_id;

        INSERT INTO delete_log (post_id, deleted_by)
        VALUES (p_post_id, p_user_id);

    END IF;

    -- Quyết định commit hay rollback
    IF v_error = 1 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Xóa bài viết thất bại (không tồn tại hoặc không có quyền)';
    ELSE
        COMMIT;
    END IF;

END $$

DELIMITER ;

CALL sp_delete_post(3, 1);