CREATE DATABASE Homework05;
USE Homework05;

CREATE TABLE Score (
	student_id int,
    course_id int,
    course_grade float check(course_grade>=0 AND course_grade<=10) NOT NULL,
    final_exam_grade float check(final_exam_grade>=0 AND final_exam_grade<=10) NOT NULL,
    primary key (student_id, course_id),
	foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);