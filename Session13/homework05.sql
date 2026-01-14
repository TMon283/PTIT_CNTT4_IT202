USE homework01;

DELIMITER $$

CREATE TRIGGER validate_user_insert
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Email nhập không hợp lệ';
    END IF;

    IF NEW.username REGEXP '^[A-Za-z0-9_]+$' = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Username nhập không hợp lệ';
    END IF;
END$$

DELIMITER ;

-- Hợp lệ
CALL add_user('alice_01', 'alice@example.com', NOW());
-- Không hợp lệ
CALL add_user('alice@01', 'aliceexample.com', NOW());

SELECT * FROM users;

