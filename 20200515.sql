ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY 를 실행

아래 쿼리의 서브그룹
1. GROUP BY  job, deptno;
2. GROUP BY  job
3. GROUP BY      ==> 전체

ROLLUP사용시 생성되는 서브그룹의 수는 : ROLLUP에 기술한 컬럼수 +1;

-------------------복습---------------------------------

GROUP_AD2]

SELECT NVL(job, '총계'), deptno,
       GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP  (job, deptno);

P25
SELECT DECODE(GROUPING(JOB),1,'총계',job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

P26
SELECT DECODE(GROUPING(JOB),1,'총',job) job, DECODE(GROUPING(deptno), 1,DECODE(GROUPING(JOB), 1, '계','소계'),deptno) deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT CASE WHEN GROUPING(JOB) = 1 THEN '총' ELSE job END job,
       CASE WHEN GROUPING(DEPTNO) = 1 THEN '총계' 
            WHEN GROUPING(DEPTNO) = 1 AND GROUPING(JOB) =1  THEN '계'
            ELSE TO_CHAR(deptno)END deptno,SUM(SAL)
FROM emp
GROUP BY ROLLUP (job,deptno);

p27 ROLLUP 절에 기술 되는 컬럼의 순서는 조회 결과에 영향을 미친다
(****서브 그룹을 기술된 커럶의 오른쪽 부터 제거해 나가면서 생성)
SELECT deptno, job, SUM(SAL)
FROM emp
GROUP BY ROLLUP(DEPTNO,JOB);

P28
SELECT b.DNAME, a.JOB, a.SAL
FROM 
(SELECT deptno, job, SUM(SAL) SAL
FROM emp
GROUP BY ROLLUP(DEPTNO,JOB)) a, DEPT b
WHERE a.deptno = b.deptno(+);


SELECT dept.dname , emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

p29

SELECT NVL(dept.dname, '총계')DNAME , emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

=====================================================================
2. Grouping sets
ROLLUP의 단점 : 관심없는 서브그룹도 생성 해야한다. ROLLUP절에 기술한 컬럼을 오른쪽에서
               지워나가기 떄문에 만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비.
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
   ROLLUP과는 다르게 방향성이 없다.
사용법 : GROUP BY GROUPING SETS (coll, coll2)
의미
GROUP BY coll
UNION ALL
GROUP BY coll2

GROUP BY GROUPING SETS (coll, coll2)
GROUP BY GROUPING SETS (coll2, coll)
두개가 같다  => 방향성 X


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

그룹기준을  
1. job ,deptno   //서브퀄럼의 기준이 여러개이면 괄호로 묵는다
2. mgr 

GROUP BY GROUPING SETS( (job,deptno),mgr )

ex)
SELECT job, deptno, mgr, SUM(SAL)
FROM emp
GROUP BY GROUPING SETS( (job,deptno),mgr );

================================================================
REPORT GROUP FUNCTION == > 확장된 GROUP BY
REPORT GROUP FUNCTION 을 사용을 안하면
여러개의 SQL 작성, UNION ALL 을 통해서 하나의 결과로 합치는 과정
==> 좀 더 편하게 하는게 REPORT GROUP FUNCTION
================================================================

3. CUBE
사용법 : GROUP BY CUBE (col1, col2...)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다) , 활용도가 낮다
cube 는 모든 경우의 수를 unoin 하기 떄문에  기하급수적으로 늘어난다.

GROUP BY CUBE (job, deptno);
1      2
job,   deptno
job,   x
x  ,   deptno
x  ,   x
    
    SELECT job, deptno, sum(sal)
    FROM emp
    GROUP BY CUBE (job, deptno);
    

=========================================================
여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**발생 가능한 조합을 계산
1       2         3 
job     deptno    mgr ==> GROUP BY job, deptno, mgr
job     x         mgr ==> GROUP BY job, mgr
job     deptno    x ==> GROUP BY job, dept
job     x         x ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal + NVL(COMM,0))SAL
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);

1      2            3
job   job, deptno   mgr   ==> GROUP BY job, deptno, mgr
job   job           mgr   ==> GROUP BY job, mgr
job   x             mgr   ==> GROUP BY job, mgr
job   job, deptno   x     ==> GROUP BY job, deptno
job   job           x     ==> GROUP BY job
job   x             x     ==> GROUP BY job

안중요하다

===========================================================

상호연관 서브쿼리 업데이트
1. emp 테이블을 이용하여 emp_test 테이블 생성
    ==> 기존에 생성된 EMP_TEST 테이블 삭제 먼저 진행
    DROP TABLE emp_test;
    
    CREATE TABLE emp_test AS 
    SELECT *
    FROM emp;
    
2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)
  DESC dept;
   ALTER TABLE emp_test ADD(dname VARCHAR2(14));
   DESC emp_test;

3. subquery를 이용하여 emp_test 테이블에 추가된  dname 컬럼을  업데이트 해주는 쿼리를 작성
emp_test의 dname 컬럼의 값을 dept 테이블의 dname 컬럼을 update
emp_test 테이블의 deptno 값을 확인해서 dept 테이블의 deptno 값이랑 일치하는 dname 컬럼값을 가져와 update

emp_test 테이블의  dname 컬럼을 dept 테이블 이용해서 dname값 조회하여 업데이트
update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음

모든직원을 대상으로 DNAME 컬럼을 dept 테이블에서 조회하여 업데이트
UPDATE emp_test SET dname = (SELECT dname 
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

44p ex
1.테이블 생성
CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. 테이블에 컬럼추가
ALTER TABLE dept_test ADD (empcnt NUMBER);
DESC dept_test;

3.subquery 를 이용하여 dept_test테이블의 empcnt 컬럼에 해당 부서원 수를 update하는 쿼리를 작성하세요
UPDATE dept_test SET empcnt = ( SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno
                               );
                                
                                select *
                                from dept_test;
                                
                                select deptno, count(*)
                                from emp
                                group by deptno;


SELECT 결과 전체를 대상으로 그룹함수를 적용한경우
대상되는 행이 없더라도  0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1 = 2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을경우 조회되는 행이 없다.
SELECT COUNT(*)
FROM emp
WHERE 1 = 2;
GROUP BY 

                               

