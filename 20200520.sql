과제풀이 
calendal 1
데이터 : 일단위 실적
화면에 나타야내야 하는 단위 : 월단위

SELECT NVL(MIN(DECODE(mm, '201901', sales)), 0) jan, NVL(MIN(DECODE(mm, '201902', sales)), 0) feb,
       NVL(MIN(DECODE(mm, '201903', sales)), 0) mar, NVL(MIN(DECODE(mm, '201904', sales)), 0) apr,
       NVL(MIN(DECODE(mm, '201905', sales)), 0) may, NVL(MIN(DECODE(mm, '201906', sales)), 0) jun
FROM
(SELECT TO_CHAR(dt, 'YYYYMM') mm , SUM(sales) sales
 FROM sales
 GROUP BY TO_CHAR(dt, 'YYYYMM'));
 
과제풀이
calendal 2
 SELECT DECODE(d, 1, iw+1, iw),
           MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
           MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
           MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri,
           MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT (TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1) + (LEVEL-1) dt, 
        TO_CHAR((TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1) + (LEVEL-1), 'D') d,
        TO_CHAR((TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1) + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= 
        ((LAST_DAY(TO_DATE('202005', 'YYYYMM')) +( 7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D')))
        - (TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1 ) + 1) )
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);


202005 ==> 해당월의 1일이 속하는 주의 일요일은 몇일인가?
202005 ==> 해당월의 마지막일자가 속하는 주의 토요일은 몇일인가?

SELECT  TO_DATE('202005', 'YYYYMM'), TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D'),
        TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1 S,
        
        LAST_DAY(TO_DATE('202005', 'YYYYMM')), TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D'),
        LAST_DAY(TO_DATE('202005', 'YYYYMM')) +( 7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D')) e,
        
        (LAST_DAY(TO_DATE('202005', 'YYYYMM')) +( 7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D')))
        - (TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1 ) + 1 days
FROM dual;

______________________________________________________________________________________________________________

ana_ex 100p

SELECT O.ENAME ENAME, O.sal SAL, O.deptno deptno, O.rn SAL_RANK
FROM
(SELECT a.*, b.lv
FROM
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno )a, (SELECT  LEVEL lv
                     FROM dual
                     CONNECT BY LEVEL <= 6) b
WHERE a.cnt >= lv
ORDER BY a.deptno, b.lv) q, (SELECT ROWNUM rn, c.*
                             FROM
                            (SELECT ename, sal, deptno 
                             FROM emp
                             ORDER BY deptno) c) o
WHERE Q.lv = o.rn

위의 복잡한 쿼리를 분석함수를 이용하여 간단히
SELECT ename, sal, deptno, RANK() OVER(PARTITION BY deptno ORDER BY sal DESC) sal_rank
FROM emp;

RANK 관련함수 : RANK, DENSE_RANK, ROW_NUMBER
RANK : 순위 구하기, 동일 값에 대해서는 동일한 순위를 부여하고 후순위는 +1
       1등이 3명이면 2등, 3등이 없고 그 후수위는 4등
DENSE_RANK : 순위구하기, 동일한 값에 대해서는 동일한 순위를 부여하고 후순위는 그대로 유지
       1등이 3명이면 그다음 후순위는 2등
ROW_NUMBER : 정렬순서대로 1부터 순차적인 값을 부여, 순위의 중복이 없다.
SELECT ename, sal, deptno,
       RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
       ROW_NUMBER() RANK() OVER (PARTITION BY deptno ORDER BY sal ) sal_row_number
FROM emp;

AN1_EX 108P
부서 별 랭크 ==> 전체 직원 대상 급여 랭크
부서별 급여합 ==> GROUP BY deptno
전체 직원의 급여합 ==> X
SELECT ename, sal, deptno,
       RANK() OVER (ORDER BY sal DESC, empno ASC) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno ASC) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal DESC, empno ASC) sal_row_number
FROM emp;


AN2_EX 109P
분석함수를 사용하지 않고 기존 지식으로만 구성한 쿼리
SELECT a.*, b.cnt
FROM
(SELECT empno, ename, deptno
 FROM emp) a,
  (SELECT deptno, COUNT(*) cnt
   FROM emp
   GROUP BY deptno) b
WHERE a.deptno = b.deptno;

분석함수 : 기존에 배운 집계함수(그룹함수) 5가지를 분석함수에서도 제공
그룹함수 - SUM, MAX, MIN, AVG, COUNT

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

ana2 EX_112P
SELECT empno, ename, sal, deptno, ROUND(AVG(SAL) OVER (PARTITION BY deptno), 2) avg_sal
FROM emp;

ana3 EX_113P
SELECT empno, ename, sal, deptno, MAX(SAL) OVER (PARTITION BY deptno) MAX_sal
FROM emp;

ana4 EX_114P
SELECT empno, ename, sal, deptno, MAX(SAL) OVER (PARTITION BY deptno) MAX_sal, MIN(SAL) OVER (PARTITION BY deptno) MIN_sal
FROM emp;

그룹내 행순서 : 
LAG  : 특정행의 이전
LEAD : 특정행의 이후

전체직원 급여 순위에서 자신보다 급여랭크가 한단계 낮은 사람의 급여 가져오기
단 급여가 같을 때는 입사일자가 빠른사람이 순위가 높은 것으로 계산
SELECT empno, ename, hiredate, sal, 
       LEAD(SAL) OVER(ORDER BY SAL desc, hiredate asc) lead_sal
FROM emp
ORDER BY sal DESC;

ana5_ex 117
SELECT empno, ename, hiredate, sal, 
       LAG(SAL) OVER(ORDER BY SAL desc, hiredate asc) lag_sal
FROM emp
ORDER BY sal DESC;


ana6_ex 118
SELECT empno, ename, hiredate, job, sal, 
       LAG(SAL) OVER(PARTITION BY job ORDER BY SAL desc, hiredate asc) lag_sal
FROM emp;

no_ana3 ex 119
SELECT o.empno, o.ename, o.sal, SUM(b.sal) c_sum
FROM
(SELECT a.*, ROWNUM rn
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a) o, (SELECT a.*, ROWNUM rn
                     FROM
                     (SELECT empno, ename, sal
                     FROM emp
                     ORDER BY sal) a) b
WHERE o.rn >= b.rn
GROUP BY o.empno, o.ename, o.sal
ORDER BY o.sal ASC ;

그룹 내 행순서 - WINDOWING

추천
SELECT empno, ename, deptno, sal, SUM(sal) OVER (ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

OR

SELECT empno, ename, deptno, sal, SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING ) c_sum
FROM emp;

물리적 행 지정
EX : ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING

SELECT empno, ename, deptno, sal, SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1  PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

ana7 ex_128p

SELECT empno, ename, deptno, sal,SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) c_sum
FROM emp;

________________________________________________________________________________
WINDOWING
ROWS : 물리적 ROW를 지칭
RANGE : 논리적인 ROW를 지칭
        같은 값을 같은 범위로 인식
DEFAULT :
SELECT empno, ename, deptno, sal,
       SUM(sal) OVER (ORDER BY sal ROWS UNBOUNDED PRECEDING) rows_sum,
       SUM(sal) OVER (ORDER BY sal RANGE  UNBOUNDED PRECEDING) range_sum,
       SUM(sal) OVER (ORDER BY sal) c_sum
FROM emp;

_________________________________________________________________________________

계층 누적합
SELECT LPAD(' ', (LEVEL-1)*4) || org_cd org_cd, total
FROM
(SELECT org_cd, parent_org_cd, lv, sum(total) total
FROM
(SELECT a.*, SUM(no_emp_c) OVER (PARTITION BY gp ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total 
FROM
(SELECT a.*, ROWNUM rn, lv + ROWNUM gp,
     COUNT(*) OVER (PARTITION BY org_cd) cnt,
     no_emp/COUNT(*) OVER (PARTITION BY org_cd) no_emp_c
FROM
(SELECT org_cd, parent_org_cd, no_emp,
       CONNECT_BY_ISLEAF leaf, LEVEL lv
FROM no_emp
START WITH org_cd ='XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd) a
START WITH leaf = 1
CONNECT BY PRIOR parent_org_cd = org_cd) a) a
GROUP BY org_cd, parent_org_cd, lv) a
start WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;
