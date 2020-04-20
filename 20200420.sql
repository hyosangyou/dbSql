table에는 조회/저장 순서가 없다
==> ORDER BY 컬럼명, 정렬방식...

ORDER BY 컬럼순서 번호로 정렬가능
==> 단점 : SELECT 컬럼의 순서가 바뀌거나, 컬럼 추가가 되면 원래 의도대로 동작하지 않을 가능성이 있음

SELECT의 3번째 컬럼을 기분으로 정렬
SELECT *
FROM emp
ORDER BY 3;

별칭으로 정렬
컬럼에다가 연산을 통해 새로운 컬럼을 만드는 경우
SAL*DEPTNO SAL_DEPT

SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

ex1)
DEPT 테이블에서 DNAME으로 내림차순정렬
SELECT *
FROM dept
ORDER BY DNAME;

DEPT 테이블에서 LOC으로 내림차순정렬
SELECT *
FROM dept
ORDER BY LOC DESC;

리터럴  
숫자 : 숫자
문자 : '문자'

Eemp
emp 테이블에 comm 에는 null 과 0값이 올 수 없고 comm 내림차순으로 정렬하는데 값이 같으면 empno를 오름차순으로 정렬한ㄷㅏ.
SELECT *
FROM emp
WHERE comm != 0
ORDER BY COMM DESC, EMPNO ASC;
null값의 연산은 항상 null 이기때문에 명시 안해도 된다.

EMP 테이블에 MGR이 있으며 JOB 내림차순정렬하고 값이 같으면 EMPNO 를 내림차순 정렬한다.
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY JOB, EMPNO DESC;

EMP 테이블에 DEPTNO가 30 이거나 10 인사람들 중에 SAL이 1500인사람의 이름을 내림차순으로 정렬하여라
SELECT *
FROM emp
WHERE (deptno = 30 
OR deptno = 10)
AND sal > 1500
ORDER BY ENAME DESC;

페이징 처리를 하는 이유
1. 데이터가 너무 많으니까
  . 한 화면에 담으면 사용성이 떨어진다.
  . 성능면에서 느려진다.
  
오라클에서 페이징 처리 방법 ==> ROWNUM
ROWNUM : SELECT 순서대로 1번부터 차례대로 번호를 부여해주는 특수 KEYWORD

SELECT ROWNUM, empno, ename
FROM emp;

SELECT절에 *표기하고 콤마를 통해 다른 표현(ex ROWNUM)을 기술할경우 *앞에
어떤 테이블에 대한건지 테이블 명칭/별칭을 기술해야 한다.
SELECT ROWNUM, e.*
FROM emp e;

페이징 처리를 위해 필요한 사항
1. 페이지 사이즈(10)
2. 데이터 정렬 기준

1-page : 1~10
2-page : 11~20(11~14)

1. 페이지 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


2. 페이지 페이징 쿼리
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM의 특징 
1. ORACLE에만 존재
 . 다른 DBMS의 경우 페이징 처리를 위한 별도의 키워드가 제공 (LIMIT)
2. 1번부터 순차적으로 읽는경우만 가능
 ROWNUM BETWEEN 1 AND 10 ==> 1~10
 ROWNUM BETWEEN 11 AND 20 ==> 1~10을 SKIP하고 11~20을 읽으려고 시도
 
 WHERE 절에서 ROWNUM을 사용할 경우 다음 형태
 ROWNUM = 1;
 ROWNUM BETWEEN 1 AND N; => 어떤 수가 와도 상관없다.
 ROWNUM <, <= N(1~N)
 
 ROWNUM과 ORDER BY
 SELECT ROWNUM,empno, ename
 FROM emp
 ORDER BY empno;
 
 ROWNUM의 특징
 1. ORDER BY 이전에 실행
 SELECT -> ROWNUM -> ORDER BY 순서
 EX) 뒤죽박죽 석여있다
  SELECT ROWNUM,empno, ename
 FROM emp
 ORDER BY ename;
 
 ROWNUM의 실행순서에 의해 정렬이 된상태로 ROWNUM을 부여하려면 IN-LINE VIEW 를 사용해야 한다.
 ** IN-LINE : 직접 기술을 했다.

정렬이된 상태에서 ROWNUM을 부여하는 방법으로 IN-LINE VIEW 를 만들어 ROWNUM을 부여한다.
SELECT ROWNUM, a.*
FROM
 (SELECT  empno, ename 
 FROM emp
 ORDER BY ename) a;
 ()를 IN-LINE VIEW 라고한다. 괄호로 감사서 G하나의 테이블로 만들어서 사용한다.
 
 
 안쪽에있는  약어를 바깥에서 사용해도 상관없다.
 ROWNUM은 1부터 조회가 가능한데 IN-LINE VIEW 로 만들어  1이아닌 숫자에서 조회가 가능하다.
EX)
 SELECT a.*
 FROM
     (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename 
         FROM emp
         ORDER BY ename) a) a
 WHERE rn BETWEEN 11 AND 20;
 
- N번쨰 page구하는법-
 WHERE rn BETWEEN 1 AND 10; 1 PAGE
 WHERE rn BETWEEN 11 AND 20; 2 PAGE
 WHERE rn BETWEEN 21 AND 30; 3 PAGE
 .
 .
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n;  n PAGE

SQL에서 변수를 선언할때는 :변수명 를 사용한다.
EX)
 SELECT a.*
 FROM
     (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename 
         FROM emp
         ORDER BY ename) a) a
WHERE rn BETWEEN 1+ (:page -1)* :pageSize AND :page * :pageSize;


----------복습--------------- 
SELECT  empno, ename 
FROM emp
ORDER BY ename

1.실행순서가 정해져있어 ROWNUM을 진행하고 정렬하기때문에 ROWNUM을 빼고 IN-LINE VIEW를 만들었다
IN-LINE VIEW 로 작성한 쿼리
SELECT *
FROM
(SELECT  empno, ename 
FROM emp
ORDER BY ename);

view로 작성한 쿼리 -view라는 객체로 빼서 작성 --위와 밑에 결과는 같다. 
SELECT *
FROM emp_ord_by_ename;

emp 테이블에 데이터를 추가하면
in-line view, view 를 사용한 쿼리의 결과는 어떻게 영향을 받을까???
--똑같다.

쿼리 작성시 문제점 찾아가기
JAVA : 디버깅
SQL : 디버깅 툴이 없어

페이징 처리 ==> 1.정렬, 2.ROWNUM
정렬, ROWNUM을 하나의 쿼리에서 실행할 경우 ROWNUM이후 정렬을 하여 숫자가 섞이는 현상 발생 ==>해결방안 : INLINE-VIEW
정렬에 대한 INLINE-VIEW
ROWNUM에 대한 INLINE-VIEW

//SELECT 에 *사용할때 뭐에대한 * 인지 작성해줘야한다. a.*라고 지정안해주면 ROWNUM사용불가
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a;

//ROWNUM 은 1부터시작해야 하기때문에 생략후 작동이 불가하다 WHERE BETWEEN 11 AND 20 = > X
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a;
WHERE BETWEEN 11 AND 20;     --> 실행 불가하다.

//ROWNUM 이 1부터아닌 다른수부터 조회 가능하게 하기위해 한번더 INLINE-VIEW 로만든다. 변수명을 설정할때 안에 사용한 변수명 그대로 사용가능하다.
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 20;

ex) 
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

** 신규 문제
PROD 테이블을  PROD_LGU (내림차순), PROD_COST(오름차순)으로 정렬하여 페이징 처리 쿼리를 작성 하세요
단 페이지 사이즈는 5
바인드 변수 사용할 것 
순서 : 정렬 -> ROWNUM ->rn 사용하기위해 where절 추가하기위해 다시한번 INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn,a.*
FROM
(SELECT  *
FROM PROD
ORDER BY PROD_LGU DESC , PROD_COST ASC)a)
WHERE rn BETWEEN 1+ (:page -1)* :pageSize AND :page * :pageSize;





--------선행학습 -------
INLINE-VIEW와 비교를 위해 VIEW를 직접 생성(선행학습,  나중에 나온다)
VIEW - 쿼리 (view 테이블 -x)

DML - Data Manipulation Language  : SELECT , INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME

 --emp_ord_by_ename이라는 오라클 객체를 만들거나 존재하는 VIEW를 바꾸기위한 명령어
 -- 생성하기 위해서는 system 에들어가서 생성 권리를 줘야한다.
 -- 생성 명령어 : GRANT CREATE VIEW TO you;
CREATE OR REPLACE VIEW  emp_ord_by_ename AS 
   SELECT empno, ename
   FROM emp
   ORDER BY ename;
   
   
   


 
 
 

  


