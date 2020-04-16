
모든 정보를 prod 테이블에서 조회;

SELECT *       -- 모든컬럼의 정보를 조회
FROM prod;     -- prod 테이블에서 데이터를 조회


특정 컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2 ...
prod_id, prod_name 컬럼만  prod 테이블에서 조회;

SELECT prod_id, prod_name 
FROM prod;

--select 1
lprod 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세여
SELECT *
FROM lprod;

buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리를 작성하세요.
SELECT buyer_id, buyer_name
FROM buyer;

cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요
SELECT *
FROM cart;

member 테이블에서 mem_id, mem_pass, mem_name 컬러만 조회하는 쿼리를 작성하세요.
SELECT  mem_id, mem_pass, mem_name
FROM member;

SQL 연산 : JAVA와 다르게 대입 X, 일반적 사칙연산 
INT b = 2;  = 대인 연산자, == 비교 연산자;

SQL 데이터 타입 : 문자,  숫자, 날짜(date);

USERS 테이블이 (4/14 만들어 놓음) 존재
USERS 테이블의 모든 데이트럴 조회;


날짜 타입에 대한 연산 : 날짜는 +, - 연산가능
 date type + 정수 : date에서 정수 날짜 만큼 미래 날짜로 이동
 date type - 정수 : date에서 정수 날짜 만큼 과거 날짜로 이동
 
SELECT userid, reg_dt, reg_dt + 5 after_5days, reg_dt - 5
FROM users;

컬럼 별칭 : 기존 컬럼명을 변경하고 싶을 때
syntax : 기존 컬럼명 [as]  별칭 명칭
as는 생략가능하다 
별칭 명칭에 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다.
또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도
더블 쿼테이션을 사용한다.

SELECT userid as id, userid id2, userid 아이디
FROM users;

--select2

prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오
(단 prod_id -> id, prod_name -> name 으로 컬럼 별칭을 지정)

SELECT prod_id id, prod_name name 
FROM prod;

lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 lprod_gu -> gu, lprod_nm -> nm 으로 컬럼 별칭을 지정)

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리를 작성하시오
(단 buyer_id -> 바이어아이디 , byer_name ->이름 으로 컬럼 별칭을 지정)

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

문자열 연산(결합연산) : || (문자열 결합은 + 연산자가 아니다)
자바에서는 ""  SQL에서는 ''
SELECT userid || 'test' , reg_dt + 5  , 'test', 15
FROM users;

경 이름 축
SELECT '경 ' || userid || ' 축'
FROM users;


문자열 결합 : uesrid 와 usernm을 합친다.
SELECT userid, usernm, userid || usernm 
FROM users;

SELECT userid || usernm AS id_name,
      CONCAT(userid, usernm) AS  concat_id_name
FROM users;

sel_co1
user_tables : oracle 에서 관리하는 테이블 정보를 담고 있는 테이블(View) ==> data dictionary    

문자열 결합 문자열 결합 문자열
SELECT ' SELECT * FROM ' || table_name || ';' QUERY
FROM user_tables;

테이블의 구성 칼럼을 확인 
1. tool(sql developer)을 통해 확인
   테이블 - 확인하고자 하는 테이블
2. SELECT * 
   FROM 테이블    
   일단 전체 조회 --> 모든 컬럼이 표시
   
3. DESC 테이블명

DESC emp;

4. data dictionary

SELECT * 
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술 : SELECT 
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(TRUE)일 때 결과를 조회

sql의 비교 연산 : =

SELECT *
FROM users
WHERE userid= 'cony';

SELECT *
FROM users
WHERE userid = userid;
where절에 항상 컬럼명이 올필요는 없다. 참일 경우  데이터가 출력

emp 테이블의 컬럼과 데이터 타입을 확인 
DESC emp;

SELECT *
FROM emp;

emp 테이블에서 직원이 속한 부서번호가 30번과 같거나 큰 부서에 속한 직원을 조회;
SELECT ename
FROM emp
WHERE deptno >= 30;

!= 다를떄
users 테이블에서 사용자 아이디가(userid)가 brown이 아닌 사용자를 조회
SELECT *
FROM users
WHERE userid != 'brown';

SQL 리터럴
숫자 : 20, 30.5  직접 숫자를 기입
문자 : 'hello world' 작은따음표 안에 기입
날짜 : TO_DATE('날짜문자열', '날짜 문자열의 형식')

1982년 1월 1일 이후에 입사한 직원만 조회
직원의 입사일자 : hiredate 컬럼

SELECT *
FROM emp
where hiredate <= TO_DATE('1982/01/01', 'YYYY/MM/DD');


 
/*
EMP 테이블 속성 정보
EMPNO : 사원번호
ENAME : 사원이름
JOB   : 직책
MGR   : 담당 관리자
HIREDATE : 입사일자
SAL : 급여
COMM : 성과금
DEPTINO : 부서번호
*/








