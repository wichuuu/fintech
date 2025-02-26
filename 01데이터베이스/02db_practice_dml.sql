#데이터베이스, 테이블 만들기
create database sampleDB;
drop database sampledb;

#데이터베이스 조회하기
show databases;

use sampledb;

#테이블 만들기
# create table 테이블명_(컬럼명1 (데이터타입), 컬럼명2(데이터타입)....);
create table customers (id int, name varchar(100), sex varchar(20), 
phone varchar(20), address varchar(255));

#테이블 삭제하기
drop table customers;

#market_db 만들기
create database market_db;

use market_db;

#market_db hongong1 테이블 만들기 toy_id(int), toy_name(char(4)), age(int)
create table hongong1 (toy_id int, toy_name char(4), age int);
show tables;
desc hongong1;

# 생성한 테이블에 데이터 입력하기 insert into 테이블명 (컬럼명1, 컬럼명2, 컬럼명3) values (1, '우디', 25);

insert into hongong1 (toy_id, toy_name, age) values (1, '우디', 25);

select * from hongong1; #테이블 확인

# id : 2, name : 버즈

insert into hongong1 (toy_id, toy_name) values (2, '버즈');

insert into hongong1 (toy_name, age, toy_id) values ('제시', 20, 3);

select * from hongong1;

# 컬럼명 생략 가능
insert into hongong1 values (5, '포테이토', 40);


# primary key와 auto increment 기능(제약조건) 추가한 테이블 만들기
create table hongong2 (
	toy_id int auto_increment primary key, 
    toy_name char(4),
    age int);
    


desc hongong2;

# auto increment가 지정된 테이블에 데이터 넣기
insert into hongong2 values (null, '보핍', 25);

select * from hongong2;

insert into hongong2 values (null, '슬링키', 22);
insert into hongong2 values (null, '렉스', 21);

# 테이블 수정하기 alter
# 컬럼 추가 alter table 테이블명 add column 컬럼명, 자료형, 속성(not null, UNIQUE)
# hongong2 테이블에 country 컬럼 추가하기
alter table hongong2 add column country varchar(100);

# 기존 테이블에 있는 자료 update 하기 where 활용!!
# update 테이블명 set 컬럼명 = 업데이트할 값 where // toy_id=1;

update hongong2 set country = '미국' where toy_id = 1;

select * from hongong2;

# 테이블의 내용은 모두 지우고 테이블의 구조는 남기고 싶을 때 truncate 활용
# truncate table hongong2;

select * from hongong1;

# 테이블의 데이터 삭제 delete from 테이블명 where 조건
#delete from hongong1 where toy_id = 

desc hongong1;

# idx 컬럼 추가 primary key로 지정 auto increment 

alter table hongong1 add column idx int auto_increment primary key;

#delete from hongong1 where idx = 5

insert into hongong1 values (7, '렉스', 30, null);

#create, insert, update, delete, (crud)


use market_db;


    

create table members (
		id int auto_increment primary key,
        member_id varchar(100),
        name varchar(100),
        address varchar(255)
);
use market_db;
drop table members;

create table members (
		id int auto_increment primary key,
        member_id varchar(100),
        name varchar(100),
        address varchar(255)
);

select * from members;

#insert into members values (1, 'tess', '나훈아', );


create table products (
	prod_name varchar(100),
    price int,
    date_of_prod varchar(100),
    manuf varchar(100),
    balance int);
    
insert into members values (null, "tess", "나훈아", "경기 부천시 중동");

select * from members;

insert into members values (null, "tess", "나훈아", "경기 부천시 중동");

insert into members values (null, "iyou", "아이유", "인천 남구 주안동");
insert into members values (null, "jyp", "박진영", "경기 고양시 장항동");

insert into products values ("바나나", 1500, "2024-07-01", "델몬트", 17);

select * from products;

insert into products values ("카스", 2500, "2023-12-12", "OB", 3), 
("삼각김밥", 1000, "2025-02-26", "CJ", 22);

# products 테이블에 prod_id 컬럼을 추가하고 
# auto_increment, primary key를 추가하세요.
alter table products add column prod_id int auto_increment primary key;

insert into members values (null, 'akmu', '악동뮤지션', null);
select * from members;

insert into members (id, member_id, name) values (null, 'akmu2', '악동뮤지션2');

# rollback 연습
create database mywork;
use mywork;
create table emp_test 
(emp_no int not null,
emp_name varchar(30) not null,
hire_date date null,
salary int null,
primary key (emp_no));

desc emp_test;

insert into emp_test
(emp_no, emp_name, hire_date, salary)
values 
(1005, '퀴리', '2021-03-01', 4000), 
(1006, '호킹', '2021-03-05', 5000),
(1007, '패러데이', '2021-04-01', 2200),
(1008, '맥스웰', '2021-04-04', 3300),
(1009, '플랑크', '2021-04-05', 4400);

select * from emp_test;

# update 연습
# 호킹의 salary를 10000으로 변경
# 패러데이의 hire_date를 2023-07-11로 변경
# 플랑크가 있는 데이터를 삭제

update emp_test set salary = 10000 where emp_no = 1006;
update emp_test set hire_date = "2023-07-11" where emp_no = 1007;
delete from emp_test where emp_no = 1009;

# 오토 커밋 옵션 활성화 확인 
select @@autocommit; # 결과가 1이면 오토커밋 활성화 0이면 비활성화
# set autocommit = 1 # 오토커밋 활성화

create table emp_tran1 as select * from emp_test;
desc emp_test;

alter table emp_tran1 add constraint primary key(emp_no);
desc emp_tran1;

drop table emp_tran1;
show tables;
rollback;