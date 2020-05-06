OUTER JOIN
테이블 연결 조건이 실패해도, 기준으로 삼은 테이블의 컬럼은 조회가 되도록 하는 조인 방식
<===>
INNER JOIN(우리가 지금까지 배운 방식)

LEFT OUTER JOIN  : 기준이 되는 테이블이 JOIN 키워드 왼쪽에 위치
RIGHT OUTER JOIN : 기준이 되는 테이블이 JOIN 키워드 오른쪽에 위치
FULL OUTER JOIN  : LEFT OUTER JOIN + RIGHT OUTER JOIN -(중복되는 데이터가 한건만 남도록 처리)

emp테이블의 컬럼중 mgr 컬럼을 통해 해당 직원의 관리자 정보를 찾아갈 수 있다.
하지만 KING 직원의 경우 상급자가 없기 때문에 일반적인 inner 조인 처리시 
조인에 실패하기 때문에 KING을 제외한 13건의 데이터만 조회가 됨.

INNER 조인 복습
상급자 사번, 상급자 이름, 직원 사번, 직원 이름
조인이 성공해야만 데이터가 조회된다,
==> KING의 상급자 정보(MGR)는 null 이기 때문에 조인에 실패하고 king 의 정보는 나오지 않는다(13건)  
---ORACLE---
SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m, emp e
WHERE m.empno = e.mgr; 

---ANSI----
SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m JOIN emp e ON(m.empno = e.mgr);

위의 쿼리를 outer 조인으로 변경
(KING 직원이 조인에 실패해도 본인 정보에 대해서는 나오도록, 하지만 상급자 정보는 없기 때문에 나오지 않는다)

 ANSI-SQL : OUTER
    SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);
    
    SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);
    
    ---두 쿼리는 동일한 쿼리이다. null 을 표현하기위해  왼쪽과 오른쪽각각에 기준을 주어 표현한다.
    
 ORACLE-SQL : OUTER
 oracle join
 1. FROM 절에 조인할 테이블 기술(콤마로 구분)
 2. WHERE 절에 조인 조건을 기술
 3. 조인 컬럼(연결고리)중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여준다.
 ==> 마스터 테이블 반대편쪽 테이블의 컬럼
 
 


--------------------------------------------------
OUTER 조인의 조건 기술 위치에 따른 결과 변화

직원의 상급자 이름, 아이디를 포함해서 조회
단, 직원의 소속부서가 10번에 속하는 직원들만 한정해서

조건을 ON절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

조건을 WHERE절에 기술했을 때
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno )
WHERE  e.deptno = 10;

OUTER 조인을 하고 싶은 것이라면 조건을 ON절에 기술하는게 맞다.

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e , emp m 
WHERE e.mgr = m.empno(+)AND e.deptno = 10;

-------------------------------------------------------------------
CROSS JOIN
조인 조건을 기술하지 않은 경우 모든 가능한 행의 조합으로 결과가 조회된다.
- 테이블간 적용한는 경우보다 데이토복제시 사용

15x3 = 45행 모든 행을 출력한다.
ex)
SELECT *
FROM product, cycle ,customer
WHERE PRODUCT.PID = CYCLE.PID;

emp 14 *dept 4 = 56행

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE(조인 테이블만 기술하고 where 절에 조건을 기술하지 않는다.)
SELECT *
FROM emp,dept;

cross join 실습 245p
SELECT *
FROM customer, product;

SELECT *
FROM customer CROSS JOIN product;

----------------------------------------------

서브쿼리
WHERE : 조건을 만족하는 행만 조회되도록 제한
SELECT *
FROM emp
WHERE 1 = 1 
OR    1 != 1;

서브 <==> 메인
서브쿼리는 다른 쿼리 안에서 작성된 쿼리
서브쿼리 가능한 위치
1. SELECT 
    SCALAR SUB QUERY
    제약조건
    * 스칼라 서브쿼리는 조회되는 행이 1행이고, 컬럼이 한개의 컬럼이어야 한다.
    EX) DUAL테이블

2. FROM
    INLINE - VIEW
    SELECT 쿼리를 괄호로 묶은 것

3. WHERE
    SUB QUERY
    WHERE 절에 사용된 쿼리
    
SMITH가 속한 부서에 속한 직원들은 누가 있을까?

1. SMITH가 속한 부서가 몇번이지??
2. 1번에서 알아낸 부서번호에 속한는 직원의 조회


==> 독립적인 2개의 쿼리를 각각 실행
두번째 쿼리는 첫번쨰 쿼리의 결과에 따라 값을 다르게 가져야한다.
(SMITH(20) ==> WARD(30) ==> 두번쨰 쿼리 작성시 10번에서 30번으로 조건을 변경
==> 유비보수측 불합리

첫번째 쿼리
SELECT DEPTNO
FROM emp
WHERE ENAME ='SMITH';

두번째 쿼리
SELECT *
FROM emp
WHERE deptno = 20;

서브쿼리를 통한 쿼리통합
SELECT *
FROM emp
WHERE deptno = ( SELECT DEPTNO
                 FROM emp
                WHERE ENAME =:ename);


EX SUB1 252P
SELECT COUNT(*)
FROM EMP
WHERE SAL >
(SELECT ROUND(AVG(sal), 2)
FROM emp);

EX 2 SUB2 253P
SELECT *
FROM EMP
WHERE SAL >
(SELECT ROUND(AVG(sal), 2)
FROM emp);


---예제---------

EX) OUTERJOIN 235P

SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
-- ORACLE SQL 에서 (+)는 모든 조건에 붙여줘야한다.

SELECT  buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

EX OUTERJOIN 2  236P

SELECT  TO_DATE('2005/01/25', 'YYYY/MM/DD'), b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

EX OUTERJOIN 3 237P

SELECT  TO_DATE('2005/01/25', 'YYYY/MM/DD'), b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty,0) BUY_QTY
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

EX OUTERJOIN  4 238P

SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT
FROM cycle c,product p
WHERE c.PID(+) = P.PID 
AND C.CID(+) = 1;

SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT
FROM product p LEFT OUTER JOIN cycle c ON(c.PID = P.PID AND  C.CID = 1);

EX OUTERJOIN 5 239P
SELECT C.PID, C.PNM, C.CID, CUSTOMER.CNM CNM,C.DAY,C.CNT 
FROM
(SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT FROM cycle c,product p WHERE c.PID(+) = P.PID AND C.CID(+) = 1) C,CUSTOMER
WHERE C.CID = CUSTOMER.CID
ORDER BY PID DESC ,DAY DESC;






 
    


