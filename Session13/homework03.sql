USE homework01;

DELIMITER $$

CREATE TRIGGER prevent_self_like
BEFORE INSERT ON likes
FOR EACH ROW
BEGIN
    IF NEW.user_id = (SELECT user_id FROM posts WHERE post_id = NEW.post_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User cannot like their own post';
    END IF;
END$$

CREATE TRIGGER increase_like_count
AFTER INSERT ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = like_count + 1
    WHERE post_id = NEW.post_id;
END$$

CREATE TRIGGER decrease_like_count
AFTER DELETE ON likes
FOR EACH ROW
BEGIN
    UPDATE posts
    SET like_count = GREATEST(like_count - 1, 0)
    WHERE post_id = OLD.post_id;
END$$

CREATE TRIGGER adjust_like_count
AFTER UPDATE ON likes
FOR EACH ROW
BEGIN
    IF OLD.post_id <> NEW.post_id THEN
        UPDATE posts
        SET like_count = GREATEST(like_count - 1, 0)
        WHERE post_id = OLD.post_id;

        UPDATE posts
        SET like_count = like_count + 1
        WHERE post_id = NEW.post_id;
    END IF;
END$$

DELIMITER ;

SELECT post_id, like_count FROM posts;
SELECT * FROM user_statistics;

