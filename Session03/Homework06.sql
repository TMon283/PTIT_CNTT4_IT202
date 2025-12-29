CREATE DATABASE btth;
USE btth;

CREATE TABLE Student (
    student_id int primary key,
    student_name varchar(100) NOT NULL
);

CREATE TABLE Course (
    course_id int primary key,
    course_name varchar(100) NOT NULL UNIQUE,
    credit int check(credit > 0)
);

CREATE TABLE Enrollment (
    student_id int,
    course_id int,
    enrollment_date DATE NOT NULL,
    primary key (student_id, course_id),
    CONSTRAINT fk_enroll_student foreign key (student_id) references Student(student_id),
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) references Course(course_id)
);

CREATE TABLE Score (
    student_id int,
    course_id int,
    course_grade float check(course_grade>=0 AND course_grade<=10) NOT NULL,
    final_exam_grade float check(final_exam_grade>=0 AND final_exam_grade<=10) NOT NULL,
    primary key (student_id, course_id),
	foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);

INSERT INTO Student(student_id, student_name) VALUES
(001, 'Hoàng Thái Minh'),
(002, 'Nguyễn Doanh Tuấn'),
(003, 'Lê Trung Chiến');

INSERT INTO Course(course_id, course_name, credit) VALUES
(001, 'Reactjs', 4),
(002, 'Java', 6);

INSERT INTO Enrollment(student_id, course_id, enrollment_date) VALUES
(001, 001, '2025-11-03'),
(003, 002, '2025-12-15');

INSERT INTO Score(student_id, course_id, course_grade, final_exam_grade) VALUES
(001, 001, 9.8, 9.5),
(003, 002, 8.2, 8);

UPDATE Score
SET course_grade = 9.5, final_exam_grade = 9.2
WHERE student_id = 001 and course_id = 001;

DELETE FROM Score
WHERE student_id = 003 and course_id = 002;

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM Score;



