USE Homework01;

CREATE OR REPLACE VIEW view_user_post AS
SELECT user_id, COUNT(post_id) AS total_user_post
FROM posts
GROUP BY user_id;

SELECT * FROM view_user_post;

CREATE OR REPLACE VIEW view_user_post AS
SELECT u.full_name, p.user_id, COUNT(p.post_id) AS total_user_post
FROM users u 
JOIN posts p ON u.user_id = p.user_id
GROUP BY p.user_id;

SELECT * FROM view_user_post;