USE social_network_pro;

DELIMITER $$

CREATE PROCEDURE calculate_post_like(IN p_post_id INT, OUT total_likes INT)
BEGIN
    SELECT COUNT(*) INTO total_likes
    FROM likes
    WHERE post_id = p_post_id;
END $$

DELIMITER ;

SET likes_count = 0;

CALL calculate_post_like(101, likes_count);

SELECT likes_count AS total_likes;

DROP PROCEDURE calculate_post_like;
