USE Homework04;

CREATE TABLE Score (
    student_id int,
    subject_id int,
    mid_score float check(mid_score>=0 AND mid_score<=10) NOT NULL,
    final_score float check(final_score>=0 AND final_score<=10) NOT NULL,
    primary key (student_id, subject_id),
	foreign key (student_id) references Student(student_id),
    foreign key (subject_id) references Subject(subject_id)
);

INSERT INTO Score(student_id, subject_id, mid_score, final_score) VALUES
(1, 001, 9.8, 9.5),
(2, 002, 8.2, 8);

UPDATE Score
SET final_score = 8.5
WHERE student_id = 2 and subject_id = 002;

SELECT * FROM Score;
SELECT * FROM Score WHERE final_score >= 8;