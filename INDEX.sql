CREATE TABLE DEPT_TEST3 AS
SELECT *
FROM dept
WHERE 1=1;

CREATE TABLE EMP_TEST3 AS
SELECT *
FROM emp
WHERE 1=1;

CREATE INDEX emp_empno ON emp_test3(empno);
CREATE INDEX emp_deptno_sal ON emp_test3(deptno,sal); 
CREATE INDEX dept_deptno_loc ON dept_test3(deptno,loc); 

DROP INDEX dept_deptno;
∫∏¿Ø ¿Œµ¶Ω∫
emp_empno

1) 
EXPLAIN PLAN FOR
SELECT *
FROM emp_TEST3
WHERE empno = 7369; 


EXPLAIN PLAN FOR
SELECT *
FROM dept_TEST3
WHERE deptno = 10; 

EXPLAIN PLAN FOR
SELECT *
FROM emp_test3
where sal BETWEEN 4000 AND 6000
AND  deptno = 10;

EXPLAIN PLAN FOR
SELECT *
FROM emp_test3 E, dept_test3 D
WHERE E.deptno = D.deptno
AND  E.deptno = 10
AND  D.LOC = 'new york';

EXPLAIN PLAN FOR
SELECT *
FROM EMP_TEST3 E, DEPT_TEST3 D
WHERE E.deptno = d.deptno
AND E.DEPTNO =10
AND E.EMPNO LIKE 73||'%';

SELECT *
FROM TABLE(dbms_xplan.display);
