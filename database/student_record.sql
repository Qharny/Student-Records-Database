-- Creating the database
CREATE DATABASE StudentRecords;
USE StudentRecords;

-- Creating the Students table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    first_name VARCHAR(50) NOT NULL,           -- Student's first name
    last_name VARCHAR(50) NOT NULL,            -- Student's last name
    date_of_birth DATE NOT NULL,               -- Student's date of birth
    email VARCHAR(100) UNIQUE NOT NULL,        -- Email (unique constraint)
    phone_number VARCHAR(15) NOT NULL,         -- Student's phone number
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date of registration
);

-- Creating the Courses table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    course_name VARCHAR(100) NOT NULL,        -- Course name
    course_code VARCHAR(10) UNIQUE NOT NULL,  -- Unique course code
    description TEXT                           -- Course description
);

-- Creating the Enrollments table (Many-to-Many relationship)
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    student_id INT NOT NULL,                      -- Foreign Key to Students
    course_id INT NOT NULL,                       -- Foreign Key to Courses
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Enrollment date
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    UNIQUE(student_id, course_id)                 -- Ensure a student cannot enroll in the same course twice
);

-- Creating the Professors table (1-to-Many relationship with Courses)
CREATE TABLE Professors (
    professor_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    first_name VARCHAR(50) NOT NULL,              -- Professor's first name
    last_name VARCHAR(50) NOT NULL,               -- Professor's last name
    email VARCHAR(100) UNIQUE NOT NULL,           -- Unique email
    phone_number VARCHAR(15) NOT NULL,            -- Professor's phone number
    department VARCHAR(50) NOT NULL               -- Department
);

-- Linking Professors to Courses (1-to-Many relationship)
ALTER TABLE Courses ADD professor_id INT;
ALTER TABLE Courses ADD FOREIGN KEY (professor_id) REFERENCES Professors(professor_id);

-- INSERTING SAMPLE DATA
-- Inserting sample data into Students

INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
VALUES
('John', 'Doe', '1998-04-15', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', '2000-08-22', 'jane.smith@example.com', '2345678901'),
('Michael', 'Johnson', '1997-02-05', 'michael.johnson@example.com', '3456789012');

-- Inserting sample data into Courses
INSERT INTO Courses (course_name, course_code, description)
VALUES
('Introduction to Programming', 'CS101', 'This course introduces the basics of programming using Python.'),
('Data Structures and Algorithms', 'CS102', 'In-depth study of data structures and algorithms in computer science.'),
('Database Systems', 'CS103', 'Learn about database design, normalization, and SQL operations.');

-- Inserting sample data into Professors

INSERT INTO Professors (first_name, last_name, email, phone_number, department)
VALUES
('Dr. Alice', 'Green', 'alice.green@university.com', '4567890123', 'Computer Science'),
('Dr. Bob', 'White', 'bob.white@university.com', '5678901234', 'Computer Science');

-- Assign professors to courses
UPDATE Courses
SET professor_id = 1
WHERE course_code = 'CS101';  -- Dr. Alice Green teaches CS101

UPDATE Courses
SET professor_id = 2
WHERE course_code = 'CS102';  -- Dr. Bob White teaches CS102

-- Inserting sample data into Enrollments
INSERT INTO Enrollments (student_id, course_id)
VALUES
(1, 1), -- John Doe enrolls in Introduction to Programming
(2, 1), -- Jane Smith enrolls in Introduction to Programming
(2, 2), -- Jane Smith enrolls in Data Structures and Algorithms
(3, 3); -- Michael Johnson enrolls in Database Systems
