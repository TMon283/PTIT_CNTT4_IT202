USE homework01;

CREATE TABLE likes(
	like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id),
    unique key unique_like(post_id, user_id)
);

ALTER TABLE posts ADD COLUMN likes_count int default 0;

DELIMITER $$
CREATE PROCEDURE add_like(
	IN p_post_id int, 
	IN p_user_id int
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi, thực hiện rollback';
  END;

  START TRANSACTION;

  INSERT INTO likes (post_id, user_id) VALUES (p_post_id, p_user_id);

  UPDATE posts SET likes_count = likes_count + 1 WHERE post_id = p_post_id;

  COMMIT;
END$$
DELIMITER ;

CALL add_like(1, 1);
SELECT * FROM likes;

CALL add_like(1, 1);
SELECT * FROM likes;


