NVL(expr1, expr2)
expr1 == null
  return expr2
  expre != null
  return expr1

NVL(expr1, expr2(), expr3)
if expr1 != null
    return expr2
else
    return expr3
    
NULLIF(expr1, expr2)
if expr1 == expr2 
    return null
else 
    return expr1
    
EX_
sal컬럼의 값이 3000이면 null 을 리턴
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

COALESCE(expr1, expr2 ... )가변인자 : 인자의 갯수가 정해져 있지 않다. 
                                    가변인자들의 타입은 동일해야함
                                    
인자들중에 가장 먼저나오는 null이 아닌 인자 값을 리턴
if expr1 != null
    return expr1
else 
    coalesce(expr2, expr3...)
    
ex)
SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

ex4)
SELECT empno, ename, mgr, NVL(MGR, 9999) MGR_N,
NVL2(MGR, MGR, 9999) MGR_N_1, coalesce(mgr, 9999) MGR_N_2 
FROM emp;

ex5) ppt 159p
SELECT userid, usernm, reg_dt, NVL2(REG_DT, REG_DT, SYSDATE) N_REG_DT
FROM users
WHERE userid != 'brown';

condition
조건에 따라 컬럼 혹은 표현식을 다른 값으로 대체
java if, switch 같은 개념
1. case 구문
2. decode 함수

1. CASE 
CASE 
     WHEN 참/거짓을 판별할 수 있는 식  THEN 리턴할 값
     [WHEN 참/거짓을 판별할 수 있는 식  THEN 리턴할 값]
     [ELSE 리터할 값 (판별식이 참인 WHEN 절이 없을경우 실행)]
END 

emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL 에서 5% 인상된 금액을 보너스로 지급(ex: sal 100 -> 105)
해당 직원의 job이 MANAGER일 경우 SAL 에서 10% 인상된 금액을 보너스로 지급
해당 직원의 job이 PRESIDENT일 경우 SAL 에서 20% 인상된 금액을 보너스로 지급
그외 직원들은 sal만큼만 지급

SELECT empno, ename, job, sal ,
       CASE 
           WHEN job ='SALESMAN'  THEN sal *1.05
           WHEN job ='MANAGER'  THEN sal *1.1
           WHEN job ='PRESIDENT'  THEN sal *1.2
           ELSE sal * 1
       END bonus
FROM emp;

2.DECODE (expr1, serch1, return1, expr2, serch2, return2, expr3, serch3, return3 ....., [default])
  DECODE (expr1,
          serch1, return1,
          serch2, return2, 
          serch3, return3
          ....., 
          [default]);
if expr1 == search1
    return return1
else if expr2 == search2
    return return2
else if expr3 == search3
    return return3
    ...
else 
    return default;
    
    
ex)
SELECT empno, ename, job, sal,
      DECODE(job, 'SALESMAN', sal*1.05,
                  'MANAGER', sal*1.1,
                  'PRESIDENT', sal*1.20,
                  sal) bouns
FROM emp;

ex cond1) 164p
SELECT empno, ename, 
     CASE
       WHEN deptno = 10 THEN 'ACCOUNTING'
       WHEN deptno = 20 THEN 'RESEARCH'
       WHEN deptno = 30 THEN 'SALES'
       WHEN deptno = 40 THEN 'OPERATIONS'
       ELSE 'DDIT'
       END DNAME,
       DECODE(deptno, 10,'ACCOUTING', 20,'RESEARCH', 30, 'SALES', 40, 'OPERATIONS','DDIT') DNAME
FROM emp;

ex cond2) 165p
--DECODE (hiredate , MOD(TO_CHAR(SYSDATE 'YYYY') - TO_CHAR(hiredate, 'yyyy') ,2),0, '검강검진 대상자', '검강검진 비대상자') CONTACT_TO_DOCTOR
SELECT empno, ename, hiredate, 
    CASE 
    WHEN MOD (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(hiredate, 'yyyy') ,2) = 0 THEN '건강검진 대상자'
    ELSE '건강검진 비대상자'
    END CONTACT_TO_DOCTOR
 FROM emp;
 
 SELECT empno, ename ,hiredate, MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,
      DECODE( MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,0,'건강검진 대상자', '건강검진 비대상자') CONTACT_TO_DOCTOR
 FROM emp;
 
 ex cond3) 166p
 SELECT userid, usernm, alias , reg_dt,
 CASE
 WHEN MOD ( TO_CHAR(REG_DT, 'YYYY'),2 )=0 THEN '건강검진 대상자'
 ELSE '검강검진 비대상자' END CONTACTTODOCTOR
 FROM users;
 

                                    