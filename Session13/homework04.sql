USE homework01;

CREATE TABLE post_history(
	history_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id) on delete cascade
);

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Alice first post', NOW()),
(2, 'Bob first post', NOW());

DELIMITER $$

CREATE TRIGGER log_post_update
BEFORE UPDATE ON posts
FOR EACH ROW
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_history (post_id, old_content, new_content, changed_at, changed_by_user_id)
        VALUES (OLD.post_id, OLD.content, NEW.content, NOW(), OLD.user_id);
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER log_post_delete
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    INSERT INTO post_history (post_id, old_content, new_content, changed_at, changed_by_user_id)
    VALUES (OLD.post_id, OLD.content, NULL, NOW(), OLD.user_id);
END$$

DELIMITER ;

UPDATE posts
SET content = 'Alice updated her first post'
WHERE post_id = 1;

SELECT * FROM post_history;
