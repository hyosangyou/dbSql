SQL 연산자
= : 컬럼|표현식 = 값 ==> 이항 연산자
  = 1
IN : 컬럼|표현식 IN (집합)
 deptno IN (10, 30) ==> IN(10, 30), deptno (10,30)
 
 EXISTS 연산자
 사용방법 : EXISTS (서브쿼리)
 서브쿼리의 조회결과가 한건이라도 있으면 TRUE 
 잘못된 사용방법 : WHERE deptno EXISTS (서브쿼리)
 
 메인쿼리의 값과 관계 없이 서브쿼리의 실행 결과는 항상 존재 하기 때문에
 emp 테이블의 모든 데이터가 조회 된다.
 
 아래 쿼리는 비상호 서브쿼리
 일반적으로 EXISTS 연산자는 상호연관 서브쿼리로 많이 사용
 
 EXISTS 연산자의 장점
 만족하는 행을 하나라도 발견을 하면 더 이상 탐색을 하지 않고 중단.  
 행의 존재 여부에 관심이 있을 때 사용
 ex)
 SELECT *
 FROM emp
 WHERE EXISTS (SELECT 'X'
               FROM dept);
               
매니저가 없는 직원 : KING
매니저 정보가 존재하는 직원 : 14 - KING =13 명의 직원
EXISTS 연산자를 활용하여 조회

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
IS NOT NULL 을 통해서도 동일한 결과를 만들어 낼 수 있다.
SELECT *
FROM emp
WHERE mgr IS NO NULL;

join 
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

ex )sub9 274
SELECT *
FROM product 
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid =1
              AND cycle.pid = product.pid);
             

ex ) sub 10 275
SELECT *
FROM product 
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid =1
              AND cycle.pid = product.pid);
              


집합연산
{1, 5 , 3} U {2, 3}={1, 2, 3, 5}

SQL에만 존재하는  UNION ALL (중복 데이터를 제거 하지 않는다.
{1, 5 , 3} U {2, 3}={1, 2, 3, 2, 5}

교집합
{1 , 5, 3} 교집합 {2, 3}  = {3}

차집합
{1 , 5, 3} -{2, 3}  = {1, 5}

SQL에서의 집합연산
연산자 : UNION, UNION ALL, INTERSECT, MINUS
두개의 SQL 의 실행결과를 행으로 확장 (위, 아래로 결합된다)/

UNION 연산자 : 중복제거 (수학적 개념의 집합과 동일)

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)



UNION ALL 연산자 : 중복허용

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)



INTERSECT 교집합 : 두집합간 중복되는 요소만 조회

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


MINUS 연산자 : 위쪽 집합에서 아래쪽 집합 요소를 제거

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

SQL 집합연사자의 특징
열의 이름 : 첫번 SQL의 컬럼을 따라간다;

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename , empno
FROM emp
WHERE empno IN(7698);

2.정렬을 하고싶을 경우 마지막에 적용 가능
 개별 SQL에는 ORDER BY 불가 (인라인뷰 를 사용하여 메인쿼리에서 ORDER BY 가 기술되지 않으면 가능)


SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)
--ORDER BY nm ,중간 쿼리에 정렬 불가
UNION

SELECT ename , empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm;

3. SQL의 집합 연산자는 중복을 제거한다 (수학적 집합 개념과 동일), 단 UNION ALL은 중복 허용

4. 두개의 집합에서 중복을 제거하기 위해 각각의 집합을 정렬하는 작업이 필요
  ==> 사용자에게 결과를 보내주는 반응성이 느려짐
   ==> UNION ALL 을 사용할 수 있는 상황일 경우 UNION을 사용하지 않아야 속도적인 측면에서
       유리하다.
알고리즘 (정렬 - 버블 정렬, 삽입 정렬,....
            자료 구조 : 트리구조 (이진 트리, 밸런스 트리)
                       heap, stack, queue, list)
  집합연산에서 중요한 사항 : 중복제거    
  버블 정렬
  

도시발전 지수;


SELECT *
FROM FASTFOOD;

SELECT ROWNUM rn, E.*
FROM
(SELECT L.SIDO 시도, L.SIGUNGU 시군구, (M.맥도날드+K.KFC+B.버거킹)/L.롯데리아 도시발전지수
FROM
(SELECT SIDO, SIGUNGU,GB, COUNT(*) 롯데리아
 FROM FASTFOOD B
 WHERE GB = '롯데리아'
 GROUP BY SIDO,SIGUNGU,GB) L ,(SELECT SIDO,SIGUNGU, GB, COUNT(*) KFC
                               FROM FASTFOOD
                               WHERE GB = 'KFC'
                               GROUP BY SIDO,SIGUNGU,GB) K, (SELECT SIDO,SIGUNGU, GB, COUNT(*) 버거킹
                                                             FROM FASTFOOD
                                                             WHERE GB = '버거킹'
                                                             GROUP BY SIDO,SIGUNGU,GB) B,(SELECT SIDO,SIGUNGU, GB, COUNT(*) 맥도날드
                                                                                          FROM FASTFOOD
                                                                                          WHERE GB = '맥도날드'
                                                                                          GROUP BY SIDO,SIGUNGU,GB) M
WHERE L.SIGUNGU = M.SIGUNGU 
AND L.SIGUNGU= K.SIGUNGU
AND L.SIGUNGU= B.SIGUNGU
AND L.SIDO =M.SIDO
AND L.SIDO =K.SIDO
AND L.SIDO =B.SIDO
ORDER BY 도시발전지수 DESC) E;


SELECT *
from tax
과제 1] fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 sql 작성
1.도시발전지수를 구하고
2.인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여
3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 sql 작성
순위,햄버거 SIDO,햄버거 SIGUNGU, 햄버거 도시발전지수,국세청, sido 국세청 sigungu, 국세청 연말정산 금액 1인당 신고액

과제 2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블을 4번사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선(fast food 테이블을 1번만 사용)
hint case, decode




                      
















