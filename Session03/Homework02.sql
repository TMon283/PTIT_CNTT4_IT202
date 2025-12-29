USE Homework01;

UPDATE Student
SET email = 'letrungchien@gmail.com'
WHERE student_id = 3;

UPDATE Student
SET date_of_birth = '2006-04-12'
WHERE student_id = 2;

DELETE FROM Student
WHERE student_id = 5;

SELECT * FROM Student;