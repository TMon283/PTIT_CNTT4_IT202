CREATE DATABASE Homework03;
USE Homework03;

CREATE TABLE Student (
	student_id int primary key,
    student_name varchar(100) NOT NULL
);

CREATE TABLE Course (
	course_id int primary key,
    course_name varchar(100) NOT NULL,
    credit int check(credit>0)
);

CREATE TABLE Enrollment (
	student_id int,
	course_id int,
    registration_date Date NOT NULL,
    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);