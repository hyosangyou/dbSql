'202005' ==> 일반적인 달력을 row, col;
부서번호별, 전체 행 별 SAL 합을 구하는

첫번째방법 
union all

2번째방법
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

JOIN 수업할 때
CROSS JOIN : 데이터 복제 할 때....

3번째 방법
SELECT DECODE(lv, 1, deptno, 2, null) deptno, sum(sal) sal
FROM emp, (SELECT  LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2) 
GROUP BY DECODE(lv, 1, deptno, 2, null)
ORDER BY 1;

__________________________________________________________________________________
계층형 쿼리
START WITH : 계층 쿼리의 시작점 기술
CONNECT BY : 계층 (행)간 연결고리를 표현

XX회사부터(최상위 노드)에서 부터 하향식으로 조직구조를 탐색한느 오라클 계층형 쿼리 작성
1. 시작점을 선택 : xx 회사

SELECT *
FROM dept_h
START WITH deptcd = 'dept0';

2. 계층간(행과 행) 연결고리 표현
   PRIOR : 내가 현재 읽고 있는 행을 표현
   아무것도 붙이지 않음 : 내가 앞으로 행을 표현
   위와 순서가다르다 
   
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
=>
SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
=>
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

 
 h_2 예제 75p
SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

상향식 
시작점 : 디자인팀
CONNECT BY 이후에 이어서 PRIOR가 오지 않아도 상관 없다
PRIOR는 현재 일고 있는 행을 지칭하는 키워드

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h-3 예제 80 p
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_4 예제 81p
SELECT LPAD(' ', (LEVEL-1)*3) || s_id s_id, value
FROM h_sum
START WITH s_id= '0'
CONNECT BY PRIOR s_id = ps_id;

SELECT *
FROM h_sum

h_5 예제 82p
SELECT LPAD(' ', (LEVEL-1)*7) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd= 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

--------------------------------------------------------------------------
Pruning branch : 가지 치기
WHERE절에 조건을 기술 했을 때 : 계층형 쿼리를 실행 후 가장 마지막에 적용된다.
CONNECT BY 절에 기술 했을 때 : 연결중에 조건이 적용
의 차이를 비교

*단 계층형 쿼리에는  FROM -> START WITH CONNECT BY -> WHERE절 순으로 처리된다.

1. WHERE절에 조건을 기술한 경우 

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd
FROM dept_h
WHERE deptnm != '정보기획부'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

결과 : 기획팀이 디자인부 하위 부서처럼 기술된다.

2. CONNECY BY 절에 조건을 기술한 경우

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '정보기획부';

결과 : 정부기획부 하위 부서들도 다 제거된다.(가지치기)!!!!!!!

__________________________________________________________________________________________

계층형 쿼리에서 사용할 수 있는 특수 함수
CONNECT_BY_ROOT(column) : 해당 컬럼의 최상위 데이터를 조회
SYS_CONNECT_BY_PATH(column, 구분자) : 해당 행을 오기까지 거쳐온 행의 column들을 표현하고 구분자를 통해 연결
                                    LTRIM(SYS_CONNECT_BY_PATH(column, 구분자), 구분자) 형태로 많이 쓰인다. 제일 왼쪽 구분자 제거
CONNECT_BY_ISLEAF 인자가 없음 : 해당 행의 연결이  더 이상 없는 마지막 노드인지(LEAF 노드)
                                LEAF 노드 : 1, NO LEAF 노드 : 0

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm),
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-'),
       CONNECT_BY_ISLEA
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;


_______________________________________________________________
h6_예제 88p
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR Seq = parent_Seq ;


h7_예제 89p 
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER BY SEQ DESC;

___________________________________________________________
ORDER SIBLINGS BY
계층형 쿼리를 정렬시 계층 구조를 유지하면서 정렬 하는 기능이 제공
___________________________________________________________

h8_예제 90p
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER SIBLINGS BY SEQ DESC;

h9_예제96p

ALTER TABLE board_test ADD (gp_no NUMBER);

UPDATE board_test SET gp_no = 4
WHERE seq IN (4, 10, 11, 5, 8, 6, 7);

UPDATE board_test SET gp_no = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gp_no = 1
WHERE seq IN (1, 9);

COMMIT;

SELECT *
FROM board_test;


SELECT gp_no, CONNECT_BY_ROOT(seq), SEQ, LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER  BY  CONNECT_BY_ROOT(seq) desc,seq asc;


___________________________________________________________________________
전체 직원중에 가장 높은 급여를 받는 사람의 급여 정보

emp 테이블을 2번 읽어서 목적은 달성 ==> 조금더 효율적인 방법이 없을까?? ==> WINDOW / ANALYSIS function
SELECT ename
FROM emp
WHERE SAL =(SELECT MAX(sal)
            FROM emp);
            
    
    
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






