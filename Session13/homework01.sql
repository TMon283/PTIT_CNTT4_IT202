CREATE DATABASE homework01;
USE homework01;

CREATE TABLE users(
	user_id int primary key auto_increment,
    username varchar(50) unique not null,
	email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

CREATE TABLE posts(
	post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id) on delete cascade
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

DELIMITER $$

CREATE TRIGGER increase_post_count
AFTER INSERT ON posts
FOR EACH ROW
BEGIN
    UPDATE users
    SET post_count = post_count + 1
    WHERE user_id = NEW.user_id;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER decrease_post_count
AFTER DELETE ON posts
FOR EACH ROW
BEGIN
    UPDATE users
    SET post_count = post_count - 1
    WHERE user_id = OLD.user_id;
END$$

DELIMITER ;

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

SELECT * FROM users;

DELETE FROM posts 
WHERE post_id = 2;

SELECT * FROM users;
