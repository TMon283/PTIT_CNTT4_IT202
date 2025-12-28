CREATE DATABASE Homework01;
USE Homework01;

CREATE TABLE Class (
    class_id int primary key,       
    class_name varchar(100) not null, 
    school_year int not null          
);

CREATE TABLE Student (
    student_id int primary key,      
    full_name varchar(100) not null,  
    birth_date date not null,         
    class_id int,                   
    foreign key (class_id) references Class(class_id)          
);

