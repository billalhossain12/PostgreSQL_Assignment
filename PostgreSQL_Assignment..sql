-- Active: 1729093672332@@127.0.0.1@5432@university_db

-- Create student table
CREATE TABLE students (
    student_id SERIAL PRIMARY key,
    student_name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    email varchar(50) NOT NULL UNIQUE,
    frontend_mark INTEGER NOT NULL,
    backend_mark INTEGER NOT NULL,
    status VARCHAR(20)
)


-- Create course table 
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    credits INTEGER NOT NULL
)

-- Create Enrollment table 
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
)


-- Insert students 
INSERT INTO students(student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@gmail.com', 41, 40, NULL),
('Sofia', 22, 'sofia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@example.com', 43, 39, NULL);


-- Inerst courses
INSERT INTO courses(course_name, credits) 
VALUES 
('Next.js', 3),
('React.js', 4),
('Database.js', 3),
('Prisma.js', 3);

-- Insert enrollments
INSERT INTO enrollment(student_id, course_id)
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);


-- Query 1: Insert a new student record
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES 
('Billal Hossain', 28, 'billal.hossain@gmail.com', 55, 58, NULL);


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'
SELECT student_name from students 
INNER JOIN enrollment USING(student_id) INNER JOIN courses USING (course_id) WHERE course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students set status='Awarded' where student_id = (SELECT student_id FROM students ORDER BY (frontend_mark+backend_mark) DESC LIMIT 1);

-- Query 4: Delete all courses that have no students enrolled.
DELETE from courses where course_id  NOT IN (SELECT DISTINCT course_id FROM enrollment);

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students LIMIT 2 OFFSET 3-1;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(*) as students_enrolled from courses JOIN enrollment USING (course_id) GROUP BY course_name;

-- Query 7: Calculate and display the average age of all students.
SELECT round(avg(age)::NUMERIC, 2) from students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
select * from students where email LIKE '%example.com%';


