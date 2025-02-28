use school_db;

insert into department values (1, '수학');
insert into department values (2, '국문학');
insert into department values (3, '정보통신공학');
insert into department values (4, '모바일공학');

insert into student values (1, '가길동', 177, 1);
insert into student values (2, '나길동', 177, 1);
insert into student values (3, '다길동', 177, 1);
insert into student values (4, '라길동', 177, 1);
insert into student values (5, '마길동', 177, 1);
insert into student values (6, '바길동', 177, 1);
insert into student values (7, '사길동', 177, 1);
insert into student values (8, '아길동', 177, 1);

insert into professor values (1, '가교수', 1);
insert into professor values (2, '나교수', 2);
insert into professor values (3, '다교수', 3);
insert into professor values (4, '빌게이츠', 4);
insert into professor values (5, '스티브잡스', 3);

insert into course values (1, '교양영어', 1, '2016/9/2', '2016/11/30');
insert into course values (2, '데이터베이스 입문', 3, '2016/8/20', '2016/10/30');
insert into course values (3, '회로이론', 2, '2016/10/20', '2016/12/30');
insert into course values (4, '공업수학', 4, '2016/11/2', '2017/1/28');
insert into course values (5, '객체지향프로그래밍', 3, '2016/11/1', '2017/1/30');
show create table course;

insert into student_course values (1, 1);
insert into student_course values (2, 1);
insert into student_course values (3, 2);
insert into student_course values (4, 3);
insert into student_course values (5, 4);
insert into student_course values (6, 5);
insert into student_course values (7, 5);

select * from student;
select * from department;
select * from course;

# 1. 학생번호, 학생명, 키높이, 학과번호, 학과명 정보를 출력하세요.

select student_id, student_name, height, d.department_id, department_name from student s left join 
department d on s.department_id = d.department_id; #학생 기준으로 출력

# 2. '가교수' 교수의 교수아이디를 구하시오
select professor_id from professor where professor_name = '가교수';

# 3. 학과 이름별 교수의 수를 출력하시오 group by, count()
select * from professor;
select * from department;
select department_name, count(professor_id) 
from professor p left join department d 
on p.department_id = d.department_id group by department_name;

# '정보통신공학'과의 학생정보를 출력하세요
select student_id, student_name, height, s.department_id, department_name from student s left join department d 
on s.department_id = d.department_id where department_name = "정보통신공학";

# '정보통신공학'과의 교수명을 출력하세요.
select * from professor;
select * from department;

select professor_id, professor_name, p.department_id, department_name 
from professor p left join department d 
on p.department_id = d.department_id where department_name = "정보통신공학";

# 6. 학생 중 성이 '아'인 학생이 속한 학과명과 학생명을 출력하세요.
select department_name, student_name from student s left join department d 
on s.department_id = d.department_id where student_name like "아%";

# 7. 키가 180~190 사이에 속하는 학생 수를 출력하세요.
select count(student_id) from student where height between 180 and 190;

# 8. 학과 이름별 키의 최고값, 평균값을 출력하세요.
# group by, max(height), avg(height)
select department_name, max(height), round(avg(height)) from student s left join department d 
on s.department_id = d.department_id group by department_name;

# 9. '다길동' 학생과 같은 학과에 속한 학생의 이름을 출력하세요.
select * from student where student_name = '다길동';
select student_name from student where department_id = 1;

# 서브쿼리 1개의 sql 문장 안에 select 문이 2개 이상
select student_name from student where department_id = (select department_id from student where where student_name = '다길동');


# 10. 2016년 11월 시작하는 과목을 수강하는 학생의 이름과 수강과목을 출력하세요.
select * from student;
select * from course;
select * from student_course;

select student_name, course_name from student s left join student_course sc 
on s.student_id = sc.student_id
left join course c on sc.course_id = c.course_id 
where start_date like "2016-11%";

# 11 '데이터베이스 입문' 과목을 수강신청한 학생의 이름은?
select student_name, course_name from student s left join student_course sc 
on s.student_id = sc.student_id
left join course c on sc.course_id = c.course_id 
where course_name = '데이터베이스 입문';

# 12 '빌게이츠' 교수의 과목을 수강신청한 학생 수는?
select * from professor p left join course c 
on p.professor_id = c.professor_id
where professor_name = '빌게이츠'; #coursr_id = 4

select course_id from professor p left join course c 
on p.professor_id = c.professor_id
where professor_name = '빌게이츠'; 

select count(*) from student s left join student_course sc
on s.student_id = sc.student_id 
where course_id = 4;

# 서브쿼리 활용
select count(*) from student s left join student_course sc
on s.student_id = sc.student_id 
where course_id = (select course_id from professor p left join course c 
on p.professor_id = c.professor_id
where professor_name = '빌게이츠');