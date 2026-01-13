USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE CalculateUserActivityScore(
    IN p_user_id INT,
    OUT activity_score INT,
    OUT activity_level VARCHAR(50)
)
BEGIN
    DECLARE v_posts INT DEFAULT 0;
    DECLARE v_comments INT DEFAULT 0;
    DECLARE v_likes_received INT DEFAULT 0;

    SELECT COUNT(*) INTO v_posts
    FROM posts
    WHERE user_id = p_user_id;

    SELECT COUNT(*) INTO v_comments
    FROM comments
    WHERE user_id = p_user_id;

    SELECT COUNT(*) INTO v_likes_received
    FROM likes l
    JOIN posts p ON l.post_id = p.post_id
    WHERE p.user_id = p_user_id;

    SET activity_score = v_posts * 10 + v_comments * 5 + v_likes_received * 3;

    CASE
        WHEN activity_score > 500 THEN
            SET activity_level = 'Rất tích cực';
        WHEN activity_score BETWEEN 200 AND 500 THEN
            SET activity_level = 'Tích cực';
        ELSE
            SET activity_level = 'Bình thường';
    END CASE;
END $$

DELIMITER ;

SET @score = 0;
SET @level = '';
CALL CalculateUserActivityScore(3, @score, @level);
SELECT @score AS activity_score, @level AS activity_level;
DROP PROCEDURE IF EXISTS CalculateUserActivityScore;
