CREATE DATABASE Homework04;
USE Homework04;

CREATE TABLE Student(
	student_id int primary key,
    full_name varchar(100) not null,
    date_of_birth date,
    email varchar(100) unique
);

CREATE TABLE Subject(
	subject_id int primary key,
	subject_name varchar(100) not null,
	credit int check (credit > 0)
);

CREATE TABLE Enrollment(
	student_id int,
    subject_id int,
    enroll_date date not null,
    PRIMARY KEY (student_id, subject_id),
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) references Student(student_id),
    CONSTRAINT fk_enroll_subject FOREIGN KEY (subject_id) references Subject(subject_id)
);

INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES 
	(1, 'Thai Minh', '2006-03-28', 'lemonboy2k6@gmail.com'),
    (2, 'Doanh Tuan', '2006-04-12', 'dtug06@gmail.com'),
    (3, 'Trung Chien', '2006-01-15', 'trungchien@gmail.com');
    
INSERT INTO Subject(subject_id, subject_name, credit) VALUES
	(001, 'Reactjs', 4),
	(002, 'Frontend cơ bản', 3),
	(003, 'Java', 6);

INSERT INTO Enrollment(student_id, subject_id, enroll_date) VALUES
(1, 001, '2025-11-03'),
(2, 002, '2025-12-15'),
(1, 002, '2025-12-03'),
(1, 003, '2026-01-03'),
(2, 001, '2025-11-05');

SELECT * FROM Enrollment;

SELECT student_id, subject_id, enroll_date FROM Enrollment WHERE student_id = 1;