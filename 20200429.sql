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

SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m, emp e
WHERE m.empno = e.mgr; 
