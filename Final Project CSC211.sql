use websited_joshua;


-- UAT Database --
drop table if exists majors; -- done
drop table if exists instructors; -- done
drop table if exists staff; -- done
drop table if exists clubs; -- done
drop table if exists students; -- done
drop table if exists classrooms; -- done
drop table if exists classes; -- done
drop table if exists grades; -- done
drop table if exists enrollments; -- done
drop table if exists student_jobs; -- done




-- Creating each of the 10 tables --   (3nf will be a rough task)
create table majors(
major_id int auto_increment primary key,
major_name varchar(100),
credit_requirement int
);

create table classes(
class_id int auto_increment primary key,
class_name varchar(100),
maximum_class_size int,
minimum_class_size int
);

create table classrooms(
classroom_id int auto_increment primary key,
classroom_number int,
computers int 
);

create table staff(
staff_id int auto_increment primary key,
staff_name varchar(75),
job varchar(50)
);

create table instructors(
instructor_id int auto_increment primary key,
instructor_name varchar(75),
class_id int,
classroom_id int,
foreign key(class_id) references classes(class_id),
foreign key(classroom_id) references classrooms(classroom_id)
);

create table grades(
grade_id int auto_increment primary key,
grade_letter Varchar(1)
);

create table clubs(
club_id int auto_increment primary key,
club_name varchar(100),
sponsor_id int,
foreign key(sponsor_id) references staff(staff_id)
);

create table student_jobs(
job_id int auto_increment primary key,
job_name varchar(75),
payPH decimal(5,2)
);

create table students(
student_id int auto_increment primary key,
student_name varchar(50),
club_id int,
job_id int,
foreign key (club_id) references clubs(club_id),
foreign key (job_id) references student_jobs (job_id)
);

create table enrollments(
enrollment_id int auto_increment primary key,
student_id int,
major_id int,
class_id int, 
grade_id int,
foreign key (student_id) references students (student_id),
foreign key (major_id) references majors (major_id),
foreign key (class_id) references classes (class_id),
foreign key (grade_id) references grades (grade_id)
);



-- Time to insert into each table! (This will take awhile) --
insert into majors (major_name, credit_requirement) values
('Computer Science', 120),
('Data Science', 110),
('Robotic Engineering', 115),
('Game Programming', 120),
('Game Design', 115),
('Psychology', 114);

insert into classes (class_name, maximum_class_size, minimum_class_size) values
('Introduction to Programming', 30, 10),
('Introduction to Databases', 30, 10),
('Technology and Ethics', 30, 15),
('Introduction to Game Design', 35, 10),
('C++ Programming I', 30, 10);

insert into classrooms (classroom_number, computers) values
(107, 30),
(108, 35),
(109, 30),
(110, 15),
(111, 20);

insert into staff (staff_name, job) values
('Karla Aragon-Joyce', 'President'),
('Valerie Cimarossa', 'Chancellor'),
('David Bolman', 'Provost Academic Officer'),
('Brandi Beals', 'Vice President'),
('Allyson Videtic', 'Dean of Faculty');

insert into instructors(instructor_name, class_id, classroom_id) values
('Habib Rawad', 2, 1),
('Derrick Clark', 5, 1),
('Rae Crusoe', 1, 1),
('Teagan Findler', 3, 4),
('Dr. Hue Henry', 4, 2);

insert into grades(grade_letter) values
('F'),
('D'),
('C'),
('B'),
('A');

insert into clubs(club_name, sponsor_id) values
('IDGA', 2),
('Chess Club', 4),
('Coding Monkeys', 3),
('Craft Club', 1),
('TCG Club', 5);

insert into student_jobs (job_name, payPH) values
('Bindery Worker', 16.00),
('Cafe Worker', 17.00),
('Cleaner', 15.00),
('Tutor', 20.00),
('RA', 16.00);

insert into students(student_name, club_id, job_id) values
('Joshua Christopherson', 2, null),
('Tobi Miquire', null , 3),
('Josiah Tomson', 2, 5),
('Camden Beaker', 1, null),
('Zander Hills', 3, 1);

insert into enrollments(student_id, major_id, class_id, grade_id) values
(1,1,2,3),
(2,3,2,4),
(3,4,4,2),
(4,2,5,1),
(5,3,4,5);


-- Select from all --
Select * from majors;
Select * from instructors;
Select * from staff;
Select * from clubs;
Select * from students;
Select * from classrooms;
Select * from classes;
Select * from grades;
Select * from enrollments;
Select * from student_jobs;

-- Views--
drop view if exists student_teachers;
drop view if exists student_grades;
drop view if exists student_wages;
drop view if exists student_GPA;

create view student_teachers as
select
s.student_name,
c.class_name,
i.instructor_name
from students s
join enrollments e on e.student_id = s.student_id
join classes c on e.class_id = c.class_id
join instructors i on i.class_id = c.class_id;
Select * from student_teachers;

create view student_grades as
select
s.student_name,
c.class_name,
g.grade_letter
from students s
join enrollments e on e.student_id = s.student_id
join classes c on e.class_id = c.class_id
join grades g on e.grade_id = g.grade_id;
select * from student_grades;


-- Time to do some functions!!!!! -- :(


-- Function to calculate wages of student jobs --
drop function if exists weekly_wage;
drop function if exists GPA;

delimiter // 

create function weekly_wage(id_job int, worked_hours int)
returns decimal (8,2)
deterministic
begin
	declare hourly_pay decimal(5,2);
    
    select payPH into hourly_pay
    from student_jobs 
    where job_id= id_job;
    
    return hourly_pay * worked_hours;
    end //

-- Function to calculate GPA of students via grades --
create function GPA(letter varchar(1))
returns decimal(3,2)
deterministic
begin
	return case letter
    when 'A' then 4.0
    when 'B' then 3.0
    when 'C' then 2.0
    when 'D' then 1.0
    else 0.0
    end;
    end //
delimiter ;
-- The view for the functions--

    create view student_wages as
select
s.student_name,
j.job_name,
weekly_wage(s.job_id, 20) as weekly_pay
from students s
join student_jobs j on s.job_id = j.job_id;
select * from student_wages;

	create view student_GPA as
select 
s.student_name,
g.grade_letter,
GPA(g.grade_letter) as gpa_value
from students s
join enrollments e on s.student_id = e.student_id
join grades g on e.grade_id = g.grade_id;
Select * from student_GPA;

-- Stored Procedure -- 
drop procedure if exists student_schedule;
drop procedure if exists assign_grade;

-- Student Schedule Procedure --
delimiter //

create procedure student_schedule(in studentID int)
begin
	select 
    s.student_name,
    c.class_name,
    i.instructor_name
    from students s
    join enrollments e on s.student_id = e.student_id
    join classes c on e.class_id = c.class_id
    join instructors i on c.class_id = i.class_id
    where s.student_id = studentID;
    end //
    
    -- Assigning Grade Procedure --
    create procedure assign_grade(
		in studentID int,
        in classID int,
        in gradeID int)
begin
	update enrollments 
    set grade_id = gradeID
    where student_id = studentID
    and class_id = classID;
    end //
    
delimiter ;

-- Call the procedures --
call student_schedule(1);
call assign_grade(1,2,4);
    
select * from student_grades;








