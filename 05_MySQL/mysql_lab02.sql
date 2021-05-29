select DISTINCT(Continent)
from country
order by continent

# 'KOR'
select Name, Population
from city
where CountryCode = 'KOR' AND population >= 1000000
order by population DESC

select name, countrycode, population
from city
where population between 8000000 and 10000000
order by population DESC

select code, CONCAT(name, "(", indepyear, ")")as nameindep, continent, population
from country
where indepyear between 1940 and 1950
order by indepyear asc

select countrycode, language, percentage
from countrylanguage
where percentage >= 95 AND language IN ("Korean", "English", "Spanish")
order by percentage DESC

select code, name, continent, GovernmentForm, population  
from country
where code like 'A%'
and GovernmentForm like '%Republic%'

# groupby: city 테이블에서 나라별 도시의 갯수를 출력
select countrycode, count(countrycode) as count
from city
group by Countrycode

# countrylanguage 테이블에서 전체 언어의 갯수를 출력
select count(DISTINCT(Language))
from countrylanguage

# 대륙별 인구수와 GNP의 최대값을 출력
select continent, max(population), max(GNP)
from country
group by continent

# 대륙별 전체인구를 구하고 5억 이상인 대륙만 출력
# Having : group by 가 실행되고 난 결과에 조건을 추가
select continent, sum(population) as data
from country
group by continent
having data > 500000000
