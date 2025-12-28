USE Homework03;

DROP TABLE Teacher;

CREATE TABLE Teacher (
	teacher_id int primary key,
    teacher_name varchar(100) NOT NULL,
    email varchar(100) NOT NULL UNIQUE
);

ALTER TABLE Course ADD teacher_id int;
ALTER TABLE Course ADD CONSTRAINT teacher_id foreign key(teacher_id) references Teacher(teacher_id);

