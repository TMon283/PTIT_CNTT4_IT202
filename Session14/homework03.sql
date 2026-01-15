USE homework01;

CREATE TABLE followers(
	follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id)
);

ALTER TABLE posts ADD COLUMN following_count int default 0;
ALTER TABLE posts ADD COLUMN followers_count int default 0;

DELIMITER $$
CREATE PROCEDURE sp_follow_user (
  IN p_follower_id int,
  IN p_followed_id int
)
BEGIN
  DECLARE v_exists_follower int default 0;
  DECLARE v_exists_followed int default 0;
  DECLARE v_already int default 0;

  -- Nếu có lỗi SQL bất ngờ thì rollback và báo lỗi chung
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lỗi, thực hiện rollback';
  END;

  START TRANSACTION;

  -- 1. Kiểm tra follower tồn tại và khóa hàng
  SELECT COUNT(*) INTO v_exists_follower
  FROM users
  WHERE user_id = p_follower_id
  FOR UPDATE;

  IF v_exists_follower = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Follower không tồn tại';
  END IF;

  -- 2. Kiểm tra followed tồn tại và khóa hàng
  SELECT COUNT(*) INTO v_exists_followed
  FROM users
  WHERE user_id = p_followed_id
  FOR UPDATE;

  IF v_exists_followed = 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Người theo dõi không tồn tại';
  END IF;

  -- 3. Không cho tự follow
  IF p_follower_id = p_followed_id THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không thể tự theo dõi';
  END IF;

  -- 4. Kiểm tra chưa follow trước đó
  SELECT COUNT(*) INTO v_already
  FROM followers
  WHERE follower_id = p_follower_id AND followed_id = p_followed_id
  FOR UPDATE;

  IF v_already > 0 THEN
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Đã theo dõi';
  END IF;

  -- 5. Thực hiện follow và cập nhật counters
  INSERT INTO followers (follower_id, followed_id)
  VALUES (p_follower_id, p_followed_id);

  UPDATE users
  SET following_count = following_count + 1
  WHERE user_id = p_follower_id;

  UPDATE users
  SET followers_count = followers_count + 1
  WHERE user_id = p_followed_id;

  COMMIT;
END$$
DELIMITER ;

-- Thành công
CALL sp_follow_user(1, 2);
SELECT * FROM followers WHERE follower_id = 1 AND followed_id = 2;
SELECT user_id, following_count, followers_count FROM users WHERE user_id IN (1,2);

-- Thử follow lần hai (thất bại)
CALL sp_follow_user(1, 2); 

-- Thử tự follow (thất bại)
CALL sp_follow_user(3, 3);

-- Thử với user không tồn tại (thất bại)
CALL sp_follow_user(99, 2); 
CALL sp_follow_user(1, 99); 
