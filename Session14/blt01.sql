CREATE DATABASE blt01;
USE btl01;

CREATE TABLE accounts (
    account_id int primary key auto_increment,
    account_name varchar(100) not null,
    balance decimal(10,0) not null default 0
);

INSERT INTO accounts (account_name, balance) VALUES
('Nguyễn Văn An', 1000.00),
('Trần Thị Bảy', 500.00);

DELIMITER $$

CREATE PROCEDURE transfer_money (
    IN from_account int,
    IN to_account int,
    IN amount decimal(10,2)
)
BEGIN
    DECLARE current_balance decimal(10,2);

    START TRANSACTION;

    SELECT balance INTO current_balance
    FROM accounts
    WHERE account_id = from_account
    FOR UPDATE;

    IF current_balance >= amount THEN
        UPDATE accounts
        SET balance = balance - amount
        WHERE account_id = from_account;

        UPDATE accounts
        SET balance = balance + amount
        WHERE account_id = to_account;

        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END$$

DELIMITER ;

CALL transfer_money(1, 2, 200.00);
SELECT * FROM accounts;
