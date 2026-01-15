USE homework01;

CREATE TABLE friend_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,
    status ENUM('pending','accepted','rejected') DEFAULT 'pending'
);

CREATE TABLE friends (
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    PRIMARY KEY (user_id, friend_id)
);
ALTER TABLE users
ADD COLUMN friends_count INT DEFAULT 0;

DELIMITER $$

CREATE PROCEDURE sp_accept_friend_request(
    IN p_request_id INT,
    IN p_to_user_id INT
)
BEGIN
    DECLARE v_from_user_id INT;
    DECLARE v_status VARCHAR(20);
    DECLARE v_error INT DEFAULT 0;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET v_error = 1;
    END;

    -- Mức cô lập giao dịch
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    START TRANSACTION;

    -- Lấy thông tin friend request
    SELECT from_user_id, status
    INTO v_from_user_id, v_status
    FROM friend_requests
    WHERE request_id = p_request_id
      AND to_user_id = p_to_user_id
    FOR UPDATE;

    -- Kiểm tra điều kiện hợp lệ
    IF v_from_user_id IS NULL OR v_status <> 'pending' THEN
        SET v_error = 1;
    END IF;

    -- Nếu chưa lỗi thì xử lý kết bạn
    IF v_error = 0 THEN

        -- Kiểm tra đã là bạn chưa
        IF EXISTS (
            SELECT 1 FROM friends
            WHERE user_id = p_to_user_id
              AND friend_id = v_from_user_id
        ) THEN
            SET v_error = 1;
        END IF;

        -- Thêm quan hệ bạn bè 2 chiều
        INSERT INTO friends (user_id, friend_id)
        VALUES (p_to_user_id, v_from_user_id);

        INSERT INTO friends (user_id, friend_id)
        VALUES (v_from_user_id, p_to_user_id);

        -- Cập nhật friends_count
        UPDATE users
        SET friends_count = friends_count + 1
        WHERE user_id IN (p_to_user_id, v_from_user_id);

        -- Cập nhật trạng thái request
        UPDATE friend_requests
        SET status = 'accepted'
        WHERE request_id = p_request_id;

    END IF;

    -- Kết thúc transaction
    IF v_error = 1 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chấp nhận lời mời kết bạn thất bại';
    ELSE
        COMMIT;
    END IF;

END $$

DELIMITER ;

CALL sp_accept_friend_request(1, 2);