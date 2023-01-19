-- 여기서부터..
-- 새로고침을 해줘야 보인다!! 
-- 한글 깨짐 현상 발생 시 삭제 후 재 실행 
-- 삭제시 순서지켜서 지워야 한다 -> 참조 때문에  
-- DROP TABLE cart ;
-- DROP TABLE prod;
-- DROP TABLE member;
-- DROP TABLE buyprod;
-- DROP TABLE buyer;
-- DROP TABLE lprod; 

-- member 테이블의 데이터 조회하ㅣ
-- member[['mem_id", "mem_name']] 
-- SELECT FROM 테이블명  WHERE ORDER BY ; 
-- SQL은 "" 사용 X , 같다 : == X , = (o)
-- 조히할 컬럼의 정의 
SELECT mem_id, mem_name 
-- 조회할 테이블의 정보 정의
FROM member 
-- 조건정의
-- WHERE mem_id = 'a001' 
-- 정렬(오름차순: asc, 내림차순:DESC) 
ORDER BY mem_id DESC, mem_name ASC ; 

-- SQL 컴파일 순서 (처리순서)
-- (조회- select)
-- select (조회 인지) > from(테이블) > where(and, or 포함) >
-- group by > having(and,or 포함) > 컬럼1, 컬럼2... > order by 
SELECT 컬럼1, 컬럼2,...
FROM 테이블1, 테이블 2
WHERE 일반조건들 
	AND 일반조건들 
	OR 일반조건들
	 
GROUP BY 그룹칼럼1, 그룹칼럼2
 HAVING 그룹조건들
		AND 그룹조건들
		OR 그룹조건들 
ORDER BY 정렬컬럼1, 정렬컬럼2,... ;

-- (입력) 처리순서 
-- insert(입력인자) > into 테이블 > 입력항 컬럼 확인 > values > 
-- 저장할 값 확인 
INSERT INTO 테이블 ( 입력컬럼지정, ...)
				VALUES (저장할 값, ...);
				

-- (수정) 처리순서 
-- update (수정인자) > 테이블 확인 > where(and, or 포함) 조건 확인 > 
-- set 수정할 컬럼과 값 확인 후 처리  
-- where 절이 없으면 컬럼의 특정 값을 모두 수정 
UPDATE 테이블 
	SET 수정할 컬럼명1 = 수정할 값,
	수정할 컬럼명 2 = 수정할 값 
	WHERE 수정조건들..
		AND 조건들..
		OR 조건들... ;
		

-- (삭제) 처리순서 
-- delete (삭제인자) > from 테이블 정보 확인 > 
-- where (and,or 포함) 조건 처리 > 삭제 실행 
-- where 절이 없으면 테이블의 모든 행을 삭제함  

DELETE FROM 테이블명 
WHERE 조건들 
	AND 조건들 
	OR 조건들 ; 

-- 회웜 정보 전체 조회하기 

SELECT * FROM member; 


-- 조건 조회하기 
-- ㅚ원 중 리름이 김씨인 회원들만 조회하기 
-- 정렬은 이름을 중심으로오름차순 
-- 조회 컬럼은 아이디와 이름마...
SELECT mem_id, mem_name FROM member 
-- LIKE : 문자여 검색 시 사용 
-- 	: % 는 모든 이라는 의미
--		: ex) 김% : 김으로 시작, %김 : 김으로 끝나는 것 , %김% : 김이 포함 
-- 	:_(언더라인)을 사용하면 문자 1개 의미
--		:ex) 김__ : 김으로 시작하는 3자리 
 
where  mem_name LIKE '김__'
ORDER BY mem_name ASC ;  
 
-- 두개 이상의 조건 사용하기 
-- 회원 아이디, 이름, 지역을 조회 
-- 회원 이름이 김씨 이고, 
-- 사는 지역이 대전인 회원만 조회 
-- 정렬은 지역을 기준으로 내림차순

-- substr 함수 사용 
-- substr 컬럼 명 변경 -> 별칭 붙이기 AS 
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add 
FROM member; 

-- and 에서 별칭을 사용 할 수 없다 => Selet 마지막에 실행되서 
-- order by 에선 별칭 쓸 수 있다 => slect 이후 수행되서  
SELECT mem_id, mem_name, 
			SUBSTR(mem_add1, 1, 2) AS mem_add 
FROM member 
WHERE mem_name LIKE '김%'
	AND SUBSTR(mem_add1, 1, 2) = '대전'
ORDER BY mem_add DESC;

-- 김씨이고 사는 지역이 대전 또는 서울 인 데이터 
SELECT mem_id, mem_name, 
			SUBSTR(mem_add1, 1, 2) AS mem_add 
FROM member 
WHERE mem_name LIKE '김%'
	AND (SUBSTR(mem_add1, 1, 2) = '대전' 
			OR SUBSTR(mem_add1, 1, 2) = '서울') 
ORDER BY mem_add DESC;

SELECT * FROM member;

-- 그룹만들어서 조회하기 
-- 그룹은 보통 ~~ 별로 조회하는 의미로 사용됨 
-- 그룹을 위해 사용되는 함수 
-- 	: count(), min(), max(), sum(), avg()

-- 회원 정보 중에..
-- 마일리지의 전체개수 최대 최소 합 평균을 조회해 주세요 

SELECT COUNT(mem_mileage), MIN(mem_mileage),
		MAX(mem_mileage), SUM(mem_mileage),
		round(AVG(mem_mileage),3)
FROM member ; 


-- 회원 정보 중에..
-- 지역별로 
-- 마일리지의 전체개수 최대 최소 합 평균을 조회해 주세요

-- <그룹 규칙>
-- 그룹함수와 일반칼럼(또는 일반함수) 를 동시에 사용헤서 
-- 조회하는 경우 
-- 무조건 일반 칼럼(또는 일반함수)는 Group by 절 뒤에 
-- 제시해야 한다 
-- SUBSTR : 일반함수 -> 무조건 group by 절에 써야 한다 
-- round : 일반 함수 => AVG (그룹함수와)함께 사용 되서 괜찮다 

SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
GROUP BY SUBSTR(mem_add1, 1, 2); 


-- 마일리지의 평균이 2500이상인 값에 대해서만 조회 
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
GROUP BY SUBSTR(mem_add1, 1, 2) 
HAVING AVG(mem_mileage) >= 2500; 

-- 마일리지의 평균이 2500이상이고 
-- 마일리지의 최소값이 100 이상인 값에 대해서만 조회
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
GROUP BY SUBSTR(mem_add1, 1, 2) 
HAVING (AVG(mem_mileage) >= 2500) 
		AND (MIN(mem_mileage) >= 3) ; 


-- 지역이 서울또는 대전 또는 부산 지역에 거주하느 회원
-- 마일리지의 평균이 2500이상이고 
-- 마일리지의 최소값이 100 이상인 값에 대해서만 조회
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
 WHERE (SUBSTR(mem_add1, 1, 2) = '대전') 
 	OR (SUBSTR(mem_add1, 1, 2) = '서울') 
 	OR (SUBSTR(mem_add1, 1, 2) = '부산')
GROUP BY SUBSTR(mem_add1, 1, 2) 
HAVING (AVG(mem_mileage) >= 2500) 
		AND (MIN(mem_mileage) >= 3) ; 

-- in 사용하기 
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
WHERE SUBSTR(mem_add1,1,2) IN ('서울', '대전','부산')
GROUP BY SUBSTR(mem_add1, 1, 2) 
HAVING (AVG(mem_mileage) >= 2500) 
		AND (MIN(mem_mileage) >= 3) ; 

-- not in 사용하기 		
SELECT SUBSTR(mem_add1, 1, 2) AS mem_add,
		COUNT(mem_mileage) AS mileage_count , MIN(mem_mileage) AS mileage_min,
		MAX(mem_mileage) AS mileage_max, SUM(mem_mileage) AS mileage_sum,
		round(AVG(mem_mileage),3) AS mileage_avg
FROM member
WHERE SUBSTR(mem_add1,1,2) not IN ('서울', '대전','부산')
GROUP BY SUBSTR(mem_add1, 1, 2) 
HAVING (AVG(mem_mileage) >= 2500) 
		AND (MIN(mem_mileage) >= 3) ; 


-- 회원중에 주문(장바구니)을 한번도 하지않은 회원 찾기 
-- 서브쿼리 (subquery) 사용 
SELECT *
FROM member 
WHERE mem_id NOT IN (
		SELECT cart_member
		FROM cart);
		
SELECT COUNT(*) FROM member; 

-- 주문내역이 있는 회원만 조회해주세요 
-- 중복된 행 제거하기 : Distinct
-- (Join)으로 처리
-- Inner Join (일반 조인) 방식 (같은 것만)  
SELECT Distinct mem_id, mem_name , cart_member
FROM member, cart
-- 관계 조건식 (PK = FK) 
WHERE mem_id = cart_member ;


-- ( ANSI표준방식 - 국제표준 )
SELECT Distinct mem_id, mem_name, cart_member
FROM member INNER JOIN cart 
		ON(mem_id = cart_member) ;


-- 통계처리하기 
-- 회원전체에 대해서 주문수량의 합을 조회
-- (join - 일반방식) -> 주문 수량이 없는 경우 조회 X
SELECT mem_id, SUM(cart_qty) AS sum_qty 
FROM member, cart 
WHERE mem_id = cart_member
GROUP BY mem_id ; 

-- 주문수량이 없는 경우도 조회
-- left outer join  
-- 업는 경우 null 로 나옴 
SELECT mem_id, SUM(cart_qty) AS sum_qty 
FROM member LEFT OUTER JOIN cart 
	ON(mem_id = cart_member)
GROUP BY mem_id ; 


-- null을 0으로 채워서 나오게 하기 
SELECT mem_id, IFNULL( SUM(cart_qty), 0) AS sum_qty 
FROM member LEFT OUTER JOIN cart 
	ON(mem_id = cart_member)
GROUP BY mem_id ; 

-- join에 4가지 방식이 존재 (3개만 소개)

-- Inner join 
-- 	: PK = FK 조건 만족
--		: 같은 것에 대해서만 조히 할 때 사용  

-- Outer join : left outer join, Right outer join, Full ouyer Join
--		: PK = FK 관계조건 만족
--		: 테이블의 우치에 따라 전체 중에 있으면 있는데로, 없으면 NULL  
--		: 일반적으로 LEFT OUTER JOIN 을 사용함 
--		: FULL OUTER JOIN은 오라클 DB에서만 사용되지만, 사용되지 않음 

-- Cross Join  
-- 	: 관계조건 없음 
-- 	: 제시한 테이블의 모든행을 교차 조히 한다 
-- 	: 사용되지 않음



