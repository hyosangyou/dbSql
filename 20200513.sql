CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1=1;

CREATE TABLE EMP_TEST2 AS
SELECT *
FROM emp
WHERE 1=1;



ex 1)
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE  INDEX idx_dept_test2_02 ON dept_test2(dname);
CREATE  INDEX idx_dept_test2_03 ON dept_test2(deptno, dname);

ex 2)
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

ex 3)

CREATE INDEX idx_emp_test_02 ON emp_test2(ename);
CREATE INDEX idx_emp_test_03 ON emp_test2(empno, deptno);
CREATE INDEX idx_emp_test_04 ON emp_test2(deptno, sal);


DROP INDEX idx_emp_test_06;

보유 인덱스
idx_emp_test_02
idx_emp_test_03
idx_emp_test_04

//1
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;

//2
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE ename = 'smith';


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

-----------------------------------------------------------------------
수업시간에 배운 조인  
== > 논리적인 조인 형태를 이야기 함, 기술적인 이야기가 아님
inner join : 조인에 성공하는 데이터만 조회하는 조인 기법 
outer join : 조인에 실패해도 기준이되는 테이블의 컬럼정보는 조회하는 조인 기법
cross join : 묻지마 조인(카티션 프러덕트), 조인 조건을 기술하지 않아서 연결 가능한 모든 경우의 수로 조인되는 기법
self join  : 같은 테이블 끼리 조인 하는 형태

개발자가 DBMS에 SQL을 실행 요청 하면 DBMS는 SQL을 분석해서
어떻게 두 테이블 연결할 지를 결정, 3가지 방식의 조인 방식(물리적 조인 방식, 기술적인 이야기)
1. Nested Loop Join
  이중루프와유사
  - 선행
  - 후행
2. Sort Merge Join 
 - 조인되는 테이블을 각자 정렬
 - 정렬이 되어 있으므로 조인조건에 해당하는 데이터를 찾기가 유리
 - 조인 조건에 해당하는 데이터를 연결 (MERGE)
 - 정렬이 끝나야 연결이 가능하므로 응답이 느림
 - 많이 사용되지는 않음 = > HASH JOIN 대체
 - H
 
3. Hash Join

OLTP (OnLine Transaction Processing) : 실시간 처리  ==> 응답이 빨라야 하는 시스템 (일반적인 웹 서비스)
OLAP (OnLine Analysis Processing) : 일괄처리 ==> 전체 처리속도가 중요 한 경우 (은행 이자 계산, 새벽 한번에 계산)

