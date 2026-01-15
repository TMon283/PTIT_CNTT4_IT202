USE homework01;

CREATE TABLE comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
	created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

ALTER TABLE posts ADD COLUMN comments_count int default 0;

DELIMITER $$
CREATE PROCEDURE sp_post_comment(
  IN p_post_id INT,
  IN p_user_id INT,
  IN p_content TEXT
)
BEGIN
  DECLARE v_update_failed TINYINT DEFAULT 0;

  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK TO after_insert;
    SET v_update_failed = 1;
  END;

  START TRANSACTION;

  INSERT INTO comments (post_id, user_id, content)
  VALUES (p_post_id, p_user_id, p_content);

  SAVEPOINT after_insert;

  UPDATE posts
  SET comments_count = comments_count + 1
  WHERE post_id = p_post_id;
  COMMIT;
END$$
DELIMITER ;

-- Thành công
CALL sp_post_comment(2, 1, 'Bình luận hợp lệ');
SELECT * FROM comments WHERE post_id = 2;
SELECT comments_count FROM posts WHERE post_id = 2;
-- Lỗi
CALL sp_post_comment(-1, 1, 'Bình luận thử rollback to savepoint');
SELECT * FROM comments;
SELECT * FROM posts WHERE post_id = -1; -- không tồn tại


