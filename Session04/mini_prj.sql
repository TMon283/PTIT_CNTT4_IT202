CREATE DATABASE Session04;
USE Session04;

-- Phần I
CREATE TABLE Student (
	student_id int primary key auto_increment,
    student_name varchar(100) not null,
    date_of_birth date not null,
    email varchar(100) unique not null
);

CREATE TABLE Teacher (
	teacher_id int primary key auto_increment,
    teacher_name varchar(100) not null,
    email varchar(100) unique not null
);

CREATE TABLE Course (
	course_id int primary key auto_increment,
    course_name varchar(100) not null,
    describle varchar(255),
    number_of_lesson int check (number_of_lesson > 5),
    teacher_id int,
    foreign key (teacher_id) references Teacher(teacher_id)
);

CREATE TABLE Enrollment (
	student_id int,
    course_id int,
    registration_date date default(current_date()),
    primary key (student_id, course_id),
    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);

CREATE TABLE Score (
	student_id int,
    course_id int,
    mid_score float check(mid_score>=0 and mid_score<=10) not null,
    final_score float check(final_score>=0 and final_score<=10) not null,
    primary key (student_id, course_id),
    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);

-- Phần II
INSERT INTO Student (student_id, student_name, date_of_birth, email) VALUES
(1, 'Nguyễn Văn A', '2005-03-06', 'nguyenvana@gmail.com'),
(2, 'Trần Văn B', '2006-02-05', 'tranvanb@gmail.com'),
(3, 'Vũ Thị C', '2006-11-24', 'vithic@gmail.com'),
(4, 'Phạm Minh D', '2006-04-07', 'phamminhd@gmail.com'),
(5, 'Hoàng Văn H', '2005-09-19', 'hoangvanh@gmail.com');

INSERT INTO Teacher (teacher_id, teacher_name, email) VALUES
(1, 'Teacher A', 'teachera@gmail.com'),
(2, 'Teacher B', 'teacherb@gmail.com'),
(3, 'Teacher C', 'teacherc@gmail.com'),
(4, 'Teacher D', 'teacherd@gmail.com'),
(5, 'Teacher E', 'teachere@gmail.com');

INSERT INTO Course (course_id, course_name, describle, number_of_lesson, teacher_id) VALUES
(1, 'Lap trinh C', 'Lap trinh C co ban', 30, 1),
(2, 'Lap trinh C++', 'Lap trinh C++ co ban', 40, 3),
(3, 'OOP', 'Lap trinh huong doi tuong', 30, 2),
(4, 'Frontend', 'Lap trinh frontend', 45, 4),
(5, 'ReactJs', 'Frontend with ReactJs', 50, 4);

INSERT INTO Enrollment (student_id, course_id, registration_date) VALUES 
(1, 1, '2025-09-01'),
(1, 2, '2025-09-02'),
(2, 1, '2025-09-01'),
(3, 3, '2025-09-03'),
(4, 4, '2025-09-04');

INSERT INTO Score (student_id, course_id, mid_score, final_score) VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.0, 7.0),
(2, 1, 8.5, 9.0),
(3, 3, 5.5, 6.5),
(4, 4, 9.0, 9.5);

-- Phần III
UPDATE Student
SET email = 'lemonboy2k6@gmail.com'
WHERE student_id = 1 AND NOT EXISTS (SELECT 1 FROM Student WHERE email = 'lemonboy2k6@gmail.com');

UPDATE Course
SET describle = 'Lap trinh C++'
WHERE course_id = 2;

UPDATE Score
SET final_score = 8
WHERE student_id = 1 and course_id = 2;

-- Phần IV
DELETE FROM Enrollment
WHERE student_id = 4 and course_id = 4;

DELETE FROM Score
WHERE student_id = 3 and course_id = 3;

-- Phần V
SELECT * FROM Student;
SELECT * FROM Teacher;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Score;