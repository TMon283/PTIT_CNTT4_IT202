USE homework01;

CREATE TABLE friendships(
	follower_id int primary key auto_increment,
    status ENUM('pending', 'accepted') default 'accepted'
);

DELIMITER $$

CREATE TRIGGER increase_follower_count
AFTER INSERT ON friendships
FOR EACH ROW
BEGIN
    UPDATE users
    SET follower_count = follower_count + 1
    WHERE user_id = NEW.follower_id;
END$$

CREATE TRIGGER decrease_follower_count
AFTER DELETE ON friendships
FOR EACH ROW
BEGIN
    UPDATE users
    SET follower_count = GREATEST(follower_count - 1, 0)
    WHERE user_id = OLD.follower_id;
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE follow_user(IN follower INT, IN status ENUM('pending','accepted'))
BEGIN
    IF EXISTS (SELECT 1 FROM friendships WHERE follower_id = follower) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Đã theo dõi';
    END IF;

    INSERT INTO friendships (follower_id, status)
    VALUES (follower, status);
END$$

DELIMITER ;

CREATE OR REPLACE VIEW user_profile AS
SELECT u.user_id, u.username, u.email,
       u.post_count, u.follower_count
FROM users u;

CALL follow_user(1, 'accepted');
CALL follow_user(2, 'accepted');

SELECT * FROM users;

DELETE FROM friendships WHERE follower_id = 1;

SELECT * FROM users;

SELECT * FROM user_profile;
