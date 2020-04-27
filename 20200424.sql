----------------- 지난시간 -------------------
SELECT NVL(empno,0), ename, NVL(sal,0), NVL(comm,0)
FROM emp;

NULL 처리 하는 방법 (4가지 중에 본인 편한걸로 하나 이상은 기억)

CONDITION : CASE, DECODE 

실행계획 : 실행계획이 뭔지 보는 순서;

--------------------------------------------

응용편

emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL 에서 5% 인상된 금액을 보너스로 지급(ex: sal 100 -> 105)
해당 직원의 job이 MANAGER이면서 deptno 가 10이면 SAL 에서 30% 인상된 금액을 보너스로 지급
그 외의 부서에 속하는 MANAGER인  경우 SAL 에서 10% 인상된 금액을 보너스로 지급    
해당 직원의 job이 PRESIDENT일 경우 SAL 에서 20% 인상된 금액을 보너스로 지급
그외 직원들은 sal만큼만 지급

SELECT empno, ename,deptno, job, sal,
      DECODE(job, 'SALESMAN', sal*1.05,
                  'MANAGER', DECODE(deptno, 10 , sal*1.3,sal*1.1),
                  'PRESIDENT', sal*1.20,
                  sal) bouns
FROM emp;
===================================================================================
집합 A ={10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
소수 : { 23, 29, 37 }   :  COUNT -3, MAX - 37, MIN -23, AVG - 29.66, SUM-89
비소수 :  { 10, 15, 18, 24, 25, 30, 35};

GROUP FUNCTION
여러행의 데이트를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다.
EX : 부서별 급여 평균
  EMP 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30)에 속해 있다.
  부서별 급여 평균은 3개의 행으로 결과가 반환된다.
  
  GROUP BY 적용시 주의사항 : SELECT 기술할 수 있는 컬럼이 제한됨
  
  SELECT 그룹핑 기준 컬럼, 그룹함수
  FROM 테이블
  GROUP BY 그룹명 기준 컬럼
  [ORDER BY];
  
★  GROUP BY 주의사항 : GROUP BY 에 명시 되어있지않은 컬럼이 SELECT 문에 나올 수가 없다. ★
  
  부서별로 가장 높은 급여 값;
  SELECT deptno,
     MAX(sal),
     MIN(sal),
     ROUND(AVG(sal),2),
     SUM(sal),
     COUNT(sal),
     COUNT(*)
  FROM emp
  GROUP BY deptno;
  
  .그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만 
   가장 높은 급여를 받는 사람의 이름을 알 수는 없다.
   ==> 추후 WINDOW/분석 FUNCTION을 통해 해결 가능
   
   emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정 하는 방법
      
    SELECT MAX(sal),-----전체 직원중 가장 높은 급여 값
     MIN(sal),-----전체 직원중 가장 낮은 급여 값
     ROUND(AVG(sal),2),-----전체 직원의 급여 평균
     SUM(sal),-----전체 직원 급여 합
     COUNT(sal), --전체 직원 급여 건수(sal 컬럼의 값이 null이아닌 row의수)
     COUNT(*),------부서별 행의 수
     COUNT(mgr) ---mgr zjffjadl null아닌 건스
  FROM emp;
  
 -----정리------- 
  GROUP BY 저에 기술된 컬럼이 
  SELECT 절에 나오지 않으면 ??
  
  GROUP BY 저에 기술되지 않은 컬럼이 
  SELECT 절에 나오면 ??
  
  그룹화와 관련 없는 문자열, 상수 등은 SELECT 절에 표현 될 수 있다(에러아님)
  
    SELECT deptno, 'TEST',1,
     MAX(sal),-----부서별로 가장 높은 급여 값
     MIN(sal),-----부서별로 가장 낮은 급여 값
     ROUND(AVG(sal),2),-----부서별 급여 평균
     SUM(sal),-----부서별 급여 합
     COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이아닌 row의수)
     COUNT(*)------부서별 행의 수
  FROM emp
  GROUP BY deptno;
  
  
  GROUP 함수 연산시 NULL 값은 제외가 된다
  30번 부서에는 NULL값을 갖는 행이 있지만 SUM(COMM)의 값이 정상적으로 계산된 걸 확인 할 수 있다.
  SELECT deptno, sum(comm)
  FROM emp
  GROUP BY deptno;
  
  10번 부서의 SUM(COMM) 컬럼이 NULL 이 아니라  0이 나오도록 NULL 처리
  .특별한 사유가 아니면 그룹함수 계산결과에 NULL 처리를 하는 것이 성능상 유리
  
  NVL(SUM(comm), 0) :comm컬럼에 sum 그룹함수를 적용하고 최종 결과에 NVL을 적용 (1회호출)
  SUM(NVL(comm, 0)) : 모든 comm컬럼에 nvl 함수를 적용후(해당그룹의 ROW수 만큼 호출) SUM 그룹함수 적용
  
SELECT deptno, sum(comm),
NVL(SUM(COMM),0)
  FROM emp
  GROUP BY deptno;
  
  single row 함수는 where 절에 기술할 수 있지만
  multi row 함수는 (group 함수)는 where 절에 기술할 수 없고
  GROUP BY 절 이후 HAVING 절에 별도로 기술

 SINGLE ROW 함수는 WHERE 절에서 사용 가능
 SELECT *
 FROM emp
 WHERE LOWER(ename) = 'smith';
 
 부서별 급여 합이 5000이 넘는 부서만 조회
 SELECT deptno, SUM(sal)
 FROM emp
 WHERE SUM(sal)>5000
 GROUP BY deptno;
 
SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 ex grp1) 180p
 SELECT MAX(SAL),MIN(SAL),ROUND(AVG(sal),2),SUM(sal), COUNT(sal), COUNT(mgr), COUNT(*)
 FROM emp;
 
 ex grp2) 181p
 SELECT deptno, MAX(SAL) MAX_SAL, MIN(SAL) MIN_SAL, ROUND(AVG(sal),2) AVG_SAL, SUM(sal) SUM_SAL,COUNT(sal) COUNT_SAL, COUNT(mgr) COUNT_MGR, COUNT(*) COUNT_ALL
 FROM emp
 GROUP BY deptno;
 
 ex grp3) 182p
 --내가한거
  SELECT  
  CASE WHEN deptno = 10 THEN 'ACCOUNTING'
       WHEN deptno = 20 THEN 'RESEARCH'
       WHEN deptno = 30 THEN 'SALES'
       END DNAME
       ,MAX(SAL) MAX_SAL, MIN(SAL) MIN_SAL, ROUND(AVG(sal),2) AVG_SAL, SUM(sal) SUM_SAL,COUNT(sal) COUNT_SAL, COUNT(mgr) COUNT_MGR, COUNT(*) COUNT_ALL
 FROM emp
 GROUP BY deptno
 ORDER BY MAX_SAL DESC;
 
 ex grp4) 183p
 SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyymm,
 COUNT( TO_CHAR(hiredate, 'yyyymm')) cnt
 FROM emp
 GROUP BY  TO_CHAR(hiredate, 'yyyymm')
 ORDER BY  TO_CHAR(hiredate, 'yyyymm');
 
 ex grp5) 184p
 SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy,
 COUNT( TO_CHAR(hiredate, 'yyyy')) cnt
 FROM emp
 GROUP BY  TO_CHAR(hiredate, 'yyyy')
 ORDER BY  TO_CHAR(hiredate, 'yyyy');
 
 ex grp6) 185p
 SELECT COUNT(*) CNT
 FROM dept
 
 SELECT *
 FROM emp;
 ex grp7) 186p---과제 
SELECT count(count(*))  c
FROM emp
GROUP BY deptno;


 
 

  














