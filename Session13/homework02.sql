USE homework01;

CREATE TABLE likes(
	like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default(current_timestamp()),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

DELIMITER $$

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

DELIMITER ;

INSERT INTO likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 3, '2025-01-12 16:00:00');

CREATE OR REPLACE VIEW user_statistics AS
SELECT u.user_id, u.username, SUM(p.like_count) AS total_likes
FROM users u
LEFT JOIN posts p ON p.user_id = u.user_id
GROUP BY u.user_id;

INSERT INTO likes (user_id, post_id, liked_at) VALUES (2, 4, NOW());
SELECT * FROM posts WHERE post_id = 4;
SELECT * FROM user_statistics;

DELETE FROM likes
WHERE post_id = 4;

SELECT * FROM user_statistics;
