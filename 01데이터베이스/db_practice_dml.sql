use titanic;
show tables;
# 데이터 조회 명령어 select 컬럼명1, 컬럼명2, * from 테이블명 
select * from p_info;

# 테이블에서 1개 컬럼만 조회할 때 select 컬럼명1 from 테이블명
select name from p_info;

# # 테이블에서 2개 컬럼만 조회할 때 select 컬럼명1, 컬럼명2 from 테이블명
select name, age from p_info;

desc p_info;

# 테이블에서 데이터를 10개만 조회하고 싶을 때 select * from 테이블명 limit 10
select * from p_info limit 10;

# 조건에 맞는 데이터 검색하기 where + 비교연산자, 논리 연산자
# 성별이 남자인 경우만 조회하고 싶을 때 
select * from p_info where sex = "male";
# 같은 줄 알았는데 아니다 -> != , <>
select * from p_info where sex != "male";
select * from p_info where sex <> "female";

# 나이가 40세 이상인 사람만 조회하고 싶을 때
select * from p_info where age > 40;
select * from p_info where age < 40;

# 나이가 40보다 작거나 같을 때
select * from p_info where age <= 40;

# 조건을 2개 이상 줄 때 논리연산자로 묶을 수 있다 -> and, or
# 성별이 남성이고 나이가 10세 미만인 경우 -> and
select * from p_info where sex = "male" and age < 10;
# 성별이 남성이거나 나이가 10세 미만인 경우 (참 또는 참) -> or
select * from p_info where sex = "male" or age < 10;

# p_info 테이블에서 20세 이상 50세 미만의 여성을 조회하시오
select * from p_info where age >= 20 and age < 50 and sex = "female";

# p_info 테이블에서 sibsp가 1이거나 parch가 1이상인 사람을 조회하시오
select * from p_info where sibsp = 1 or parch >= 1;

desc t_info;

# t_info 테이블에서 pclass가 1인 승객을 조회하시오
select * from t_info where pclass = 1;

# t_info 테이블에서 pclass가 2 또는 fare가 50 초과인 승객을 조회하시오
select * from t_info where pclass = 2 or fare > 50;

# survived 테이블에서 survived가 1인 승객을 조회하시오
select * from survived where survived = 1;

# IN, NOT IN (=or), LIKE('값%', '%값'), BETWEEN, IS NULL, IS NOT NULL

# Braund%
# %harris
# %owen%

# p_info 테이블에서 sibsp 컬럼의 값이 1, 2, 3인 행을 찾으세요

select * from p_info where sibsp in(1,2,3); #1, 2, 3인 값 조회
select * from p_info where sibsp not in (0, 1, 2, 3); #0, 1,2,3이 아닌 값 조회

# like -> 문자열 안에서 특정 단어를 포함한 행을 찾을 때 사용. % 사용
select * from p_info where name Like "Rice%"; #rice로 시작하는 것 조회
select * from p_info where name like "%Eric"; #eric으로 끝나는 것 조회
select * from p_info where name like "%oscar%"; #oscar가 들어가는 것 조회

# between a and b / a 이상 b 이하를 찾을 때 (초과와 미만은 불가)
# age 컬럼의 값이 20 이상 40 이하인 값 찾기
select * from p_info where age >= 20 and age <= 40;

select * from p_info where age between 20 and 40;

# IS NULL, IS NOT NULL 

select * from p_info where age is null; #null 값 포함 찾기
select * from p_info where age is not null; #null 값 빼고 찾기



select * from t_info where fare between 100 and 1000;

select * from t_info where Ticket like "pc%" and embarked in ( "C", "S");

select * from t_info where pclass in(1, 2);

select * from t_info where cabin like "%59%";

select * from p_info where age is not null and name like "%james%" and age >= 40 and sex = "male";

# 데이터의 순서 정렬하기 order by
# select * from 테이블명 where 컬럼명  + 조건 order by 기준 컬럼 ASC(오름차순)/DESC(내림차순)

# p_info 테이블에서 age가 null이 아니면서 이름에 miss가 포함된 40세 이하의 여성을 조회하고 나이를 기준으로 내림차순 정렬하시오

select * from p_info where age is not null and name like "%miss%" and age <= 40 and sex = "female" order by age desc;

# group by 특정 컬럼을 기준으로 그룹 연산을 할 때 ( 평균, 촤솟값, 최댓값) 
# select 기준 컬럼명, 그룹 연산 함수 from 테이블명 where 컬럼명 group by 기준컬럼;
# 그룹연산 함수 AVG() 평균, MIN() 최솟값, MAX() 최댓값, COUNT() 행 갯수

# p_info 테이블에서 나이가 null이 아닌 행의 성별별 나이 평균을 구하시오 (성별이 기준이 됨.. 성별 컬럼)
select sex, avg(age) from p_info where age is not null group by sex;

# 그룹 연산 후의 결과에서 특정 조건을 충족하는 행을 찾고 싶을 때
# t_info 테이블에서 pclass별 fare 가격 평균을 구하고 그 중 가격 평균이 50을 초과하는 결과만 조회하시오
select pclass, avg(fare) from t_info group by pclass having avg(fare) > 50;


# INNER JOIN 왼쪽과 오른쪽 (1번과 2번) 테이블에서 일치하는 자료를 합치는 것
# LEFT JOIN 왼쪽 테이블의 기준 컬럼에 있는 자료에 해당하는 값만 오른쪽으로 합치는 것

# inner join (교집합) 왼쪽, 오른쪽에 있는 테이블에서 기준 컬럼이 일치하는 것만 합치는 것
# passenger 컬럼(왼쪽)과 ticket 컬럼(오른쪽)을 inner join하세요

select * from passenger limit 3;
select * from ticket limit 3;

# select * from 테이블1명(왼쪽) inner join 테이블 2명(오른쪽) on 테이블 1명(오른쪽). 기준컬럼명 = 테이블2명(오른쪽).기준컬럼명;
select * from passenger inner join ticket on passenger.passengerid = ticket.passengerid;

# left join 왼쪽을 기준으로 
select * from passenger left join ticket on passenger.passengerid = ticket.passengerid;

# right join 오른쪽을 기준으로
select * from passenger right join ticket on passenger.passengerid = ticket.passengerid;

select * from titanic.ticket;
select * from titanic.passenger;

# 두 개의 테이블을 조인하면서 name, age, pclass, fare 컬럼들만 보고싶을 때
select name, age from passenger;

# 테이블명과 컬럼 지정
select name, age, pclass, fare from passenger inner join ticket on passenger.passengerid = ticket.passengerid;
select passenger.passengerid name, age, pclass, fare from passenger inner join ticket on passenger.passengerid = ticket.passengerid;
select ticket.passengerid name, age, pclass, fare from passenger inner join ticket on passenger.passengerid = ticket.passengerid;

# 약칭, 별칭 as 사용

select p.passengerid name, age, pclass, fare from passenger as p left join ticket as t on p.passengerid = t.passengerid;
#별칭 시 as 생략 가능
select p.passengerid name, age, pclass, fare from passenger p left join ticket t on p.passengerid = t.passengerid;

# 3개의 테이블을 1개로 합치기 (테이블1 + 테이블2) + 테이블3 

select * from passenger p inner join ticket t on p.passengerid = t.passengerid inner join survived s on p.passengerid = s.passengerid;

# 3개의 테이블을 1개로 합치기 (테이블1 + 테이블2) + 테이블3 ) + 4...


