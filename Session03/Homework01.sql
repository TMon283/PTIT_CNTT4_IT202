CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE Student(
	student_id int primary key,
    full_name varchar(100) not null,
    date_of_birth date,
    email varchar(100) unique
);

INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES 
	(1, 'Thai Minh', '2006-03-28', 'lemonboy2k6@gmail.com'),
    (2, 'Doanh Tuan', '2006-04-12', 'dtug06@gmail.com'),
    (3, 'Trung Chien', '2006-01-15', 'trungchien@gmail.com');
    
SELECT * FROM Student;
SELECT student_id, full_name FROM Student;