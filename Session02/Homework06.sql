CREATE DATABASE Homework06;
USE Homework06;

CREATE TABLE Class (
    class_id int primary key,
    class_name varchar(100) NOT NULL UNIQUE
);

CREATE TABLE Student (
    student_id int primary key,
    student_name varchar(100) NOT NULL,
    class_id int,
    CONSTRAINT fk_student_class foreign key (class_id) references Class(class_id)
);

CREATE TABLE Teacher (
    teacher_id int primary key,
    teacher_name varchar(100) NOT NULL,
    email varchar(100) NOT NULL UNIQUE
);

CREATE TABLE Course (
    course_id int primary key,
    course_name varchar(100) NOT NULL UNIQUE,
    credit int check(credit > 0),
    teacher_id int,
    CONSTRAINT fk_course_teacher foreign key (teacher_id) references Teacher(teacher_id)
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
