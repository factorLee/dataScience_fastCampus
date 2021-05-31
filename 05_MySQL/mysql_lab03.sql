# 소수점 올림, 반올림, 버림 함수
select ceil(12.345)
select round(12.345, 2)
select truncate(12.345, 2)

# 
select Code, round((GNP/ population) * 1000, 2)
from country

# 조건문
# IF : IF(조건, 참, 거짓)
# 도시의 인구가 100만 이상 big city, 100만 미만 small city
# coloum : city_scale
select name, population
, IF(population >= 1000000, "big city", "small city") as city_scale
from city

# IFNULL : IFNULL(참, 거짓)
# country 테이블에서 독립년도(IndepYear)가 없으면 0으로 출력
select Name, IFNULL(IndepYear, 0) as IndepYear
from country

# CASE
# CASE 
	# WHEN(조건1) THEN(출력1)
	# WHEN(조건2) THEN(출력2)
# END AS (컬럼명)

# 나라별 10억 이상, 1억 이상, 1억 이하 조건을 출력
select Name, population,
CASE
	WHEN	 population > 100000000 THEN "10억 이상"
	WHEN population > 10000000 THEN "1억 이상"
	ELSE "below 100 milion"
END AS result
from country

# DATE_FORMAT : 날짜 데이터의 포멧을 변경해주는 함수
# https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html
# sakila
use sakila 

# payment 에서 월별 총 매출 출력
select DATE_FORMAT(payment_date,"%Y-%m") as monthly, sum(amount), count(amount)
from payment
group by monthly


# JOIN : pandas에서 merge()
CREATE TABLE user (
user_id int(11) unsigned NOT NULL AUTO_INCREMENT, name varchar(30) DEFAULT NULL,
PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE addr (
id int(11) unsigned NOT NULL AUTO_INCREMENT, addr varchar(30) DEFAULT NULL,
user_id int(11) DEFAULT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO user(name) VALUES ("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id) VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5), ("seoul", 6);

# inner join
select addr.addr, addr.user_id, user.name
from addr
join user
on addr.user_id = user.user_id

# world 도시이름, 국가 이름을 출력
select city.countrycode, city.name, country.name
from city
join country
on city.countryCode = country.code

# left 조인 
select id, addr.addr, addr.user_id
, IFNULL(user.name, "-")
from addr
left join user
on addr.user_id = user.user_id
 
# right 조인 
select addr.id, addr.addr, user.user_id, user.name
from addr
right join user
on addr.user_id = user.user_id

# union : select 문의 결과를 합쳐서 출력
# 자동으로 중복제거
select name
from user
union
select addr
from addr

# 중복 허용
select name
from user
union all
select addr
from addr

# outer join
select user.name, addr.addr, addr.user_id
from user
left join addr
on user.user_id = addr.user_id
union
select user.name, addr.addr, addr.user_id
from user
right join addr
on user.user_id = addr.user_id

# sub-query : 쿼리문 안에 쿼리가 있는 문법
# select, from, where

# 전체 나라수, 전체, 도시수, 전체 언어수를 출력 : select에 사용
select
(select count(*)
from country) as total_country,
(select count(*)
from city) as total_city,
(select count(distinct(language))
from countrylanguage) as total_language

# 800만 이상이 되는 도시의 국가코드, 도시이름, 국가이름, 도시인구수를 출력 : from에 사용
select *
from 
	(select countrycode, name, population
	from city
	where population >= 8000000) as city
join
	(select code, name
	from country) as country
on city.countrycode = country.code

# 800만 이상 도시의 국가코드, 국가이름, 대통령이름 출력 : where절에 사용
select code, name, headofstate
from country
WHERE code in (
	select distinct(countrycode)
	from city
	where population >= 8000000
)


# index : 데이터를 검색할때 빠르게 찾을 수 있도록 해주는 기능
use employes

explain
select count(*)
from salaries
where to_date > "2000-01-01"

# 인덱스 생성
create index tdate
on salaries(to_date)

# 인덱스 삭제
drop index tdate
on salaries

# view : 특정 쿼리문에 대한 결과를 저장하는 개념
use world

create view code_name as 
select code, name
from country

select *
from city
join code_name
on city.countrycode = code_name.code













