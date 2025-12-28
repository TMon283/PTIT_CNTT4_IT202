CREATE DATABASE Homework02;
USE Homework02;

CREATE TABLE Student (
	student_id int primary key,
    student_name varchar(100) NOT NULL
);

CREATE TABLE Course (
	course_id int primary key,
    course_name varchar(100) NOT NULL,
    credit int check(credit>0)
);