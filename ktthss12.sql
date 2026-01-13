CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);

-- Phần A
-- Câu 1
CREATE OR REPLACE VIEW view_student_basic AS
SELECT s.StudentID, s.FullName, d.DeptName 
FROM Student s
JOIN Department d ON d.DeptID = s.DeptID;

SELECT * FROM view_student_basic; 

-- Câu 2
CREATE INDEX idx_regular_index ON Student(FullName);
SELECT * FROM Student;

-- Câu 3
DELIMITER $$

CREATE PROCEDURE GetStudentsIT(
)
BEGIN
    SELECT s.StudentID, s.FullName, d.DeptName 
	FROM Student s
	JOIN Department d ON d.DeptID = s.DeptID
    WHERE d.DeptName = 'Information Technology';
END $$

DELIMITER ;

CALL GetStudentsIT();
DROP PROCEDURE IF EXISTS GetStudentsIT;

-- Phần B
-- Câu 4
CREATE OR REPLACE VIEW view_student_count_by_dept AS
SELECT d.DeptName, COUNT(s.DeptID)
FROM Department d
JOIN Student s ON s.DeptID = d.DeptID
GROUP BY d.DeptName;

SELECT * FROM view_student_count_by_dept;

-- Câu 5
DELIMITER $$

DROP PROCEDURE IF EXISTS GetTopScoreStudent $$

CREATE PROCEDURE GetTopScoreStudent(
    IN p_CourseID CHAR(6)
)
BEGIN
    DECLARE v_max_score DECIMAL(10,2);

    SELECT MAX(Score) INTO v_max_score
    FROM Enrollment
    WHERE CourseID = p_CourseID;

    IF v_max_score IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No scores found for the given course';
    END IF;

    SELECT s.StudentID, s.FullName, e.Score
    FROM Enrollment e
    JOIN Student s ON e.StudentID = s.StudentID
    WHERE e.CourseID = p_CourseID
      AND e.Score = v_max_score
    ORDER BY s.FullName;
END $$
DELIMITER ;

CALL GetTopScoreStudent('C00001');





	