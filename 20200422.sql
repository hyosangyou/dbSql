SELECT '201912' PARAM , 
TO_CHAR(LAST_DAY(TO_DATE('201912', 'YYYYMM')), 'DD')DT,
TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD')DT1,
TO_CHAR(LAST_DAY(TO_DATE('201602', 'YYYYMM')), 'DD')DT2
FROM dual;

--선생님 방식으로 하나씩
SELECT TO_DATE(:yyyymm, 'YYYYMM').
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),
       TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD')
FROM dual;



-------------------------------------------------------------------------------------------------

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE empno ='7369';
-->결과 성명되었습니다. 라고만나온다

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
--> 분석한 실행결과 출력한다. 


--출력물--
Plan hash value: 3956160932
* 들여쓰기 되어있으면 자식 오퍼레이션
1. 위에서 아래로
  *단 자식 오퍼레이션이 있으면 자식 부터 읽는다.
 1==> 0      1번이 자식 오퍼레이션이기때문에 1부터읽는다.
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)  -- 형변환을 자동으로 하였다.
   
   
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY)
-결과물 -

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')  -- 모든행에 대하여 TO_CHAR 이 수행되었다. 잘못된 방법
   
EXPLAIN PLAN FOR 
SELECT *
FROM emp 
WHERE empno =7300 + '69';

SELECT *
FROM TABLE(dbms_xplan.display);

-- 출력물 --
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)  --> 자동으로 문자열 69 를 숫자로 형변환 하였다.
   
   
   
   
   ----------------------------------------------------------------------------------------------
   --숫자형에서 문자형으로 형변환--
   
    --활용도가 적다-
 SELECT ename, sal, TO_CHAR(sal, 'L009,999.00') TOTAL
 FROM emp;
 
 NULL과 관련된 함수
 ★ NVL           
 NVL2
 NULLIF
 COALESCE;
 
 왜 null 처리를 해야할까?
 NULL에 대한 연산결과는 NULL이다
 
 예를들어서 emp 테이블에 존재한는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
 다음과 같이 SQL을 작성.
 
 SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
 FROM emp; 
 
 NVL(expr1, expr2)
 expr1 이 NULL 이면 expr2 값을 리턴하고
 expr1 이 NULL 이 아니면 expr1 을 리턴
 
 SELECT empno, ename, sal ,comm, sal + NVL(comm, 0) sal_plus_comm
 FROM emp;
 => 결과 위의 예제와 다르게 NULL 값을 제외하고 계산하였다.
 
 REG_DT 컬럼이 NULL 일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
 SELECT userid, usernm, NVL(REG_DT, LAST_DAY(SYSDATE))
 FROM users;
 
 
 
   
   
   
   
   
   
   
   
   