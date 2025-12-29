CREATE DATABASE Homework03;
USE Homework03;

CREATE TABLE Subject(
	subject_id int primary key,
	subject_name varchar(100) not null,
	credit int check (credit > 0)
);

INSERT INTO Subject(subject_id, subject_name, credit) VALUES
(001, 'Reactjs', 4),
(002, 'Frontend cơ bản', 3),
(003, 'Java', 6);

UPDATE Subject
SET credit = 8
WHERE subject_id = 003;

UPDATE Subject
SET subject_name = 'CSDL'
WHERE subject_id = 002;

SELECT * FROM Subject;