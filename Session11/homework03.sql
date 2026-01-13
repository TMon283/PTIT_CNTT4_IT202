USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE calculate_bonus_points(
    IN p_user_id INT,
    INOUT p_bonus_points INT
)
BEGIN
    DECLARE v_post_count INT DEFAULT 0;

    SELECT COUNT(*) INTO v_post_count
    FROM posts
    WHERE user_id = p_user_id;

    IF v_post_count >= 20 THEN
        SET p_bonus_points = p_bonus_points + 100;
    ELSEIF v_post_count >= 10 THEN
        SET p_bonus_points = p_bonus_points + 50;
    END IF;
END $$

DELIMITER ;

SET points = 100;

CALL calculate_bonus_points(5, points);

SELECT points AS updated_bonus_points;

DROP PROCEDURE CalculateBonusPoints;

