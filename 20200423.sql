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
sal�÷��� ���� 3000�̸� null �� ����
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

COALESCE(expr1, expr2 ... )�������� : ������ ������ ������ ���� �ʴ�. 
                                    �������ڵ��� Ÿ���� �����ؾ���
                                    
���ڵ��߿� ���� ���������� null�� �ƴ� ���� ���� ����
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
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch ���� ����
1. case ����
2. decode �Լ�

1. CASE 
CASE 
     WHEN ��/������ �Ǻ��� �� �ִ� ��  THEN ������ ��
     [WHEN ��/������ �Ǻ��� �� �ִ� ��  THEN ������ ��]
     [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ������� ����)]
END 

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL ���� 5% �λ�� �ݾ��� ���ʽ��� ����(ex: sal 100 -> 105)
�ش� ������ job�� MANAGER�� ��� SAL ���� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL ���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal��ŭ�� ����

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
--DECODE (hiredate , MOD(TO_CHAR(SYSDATE 'YYYY') - TO_CHAR(hiredate, 'yyyy') ,2),0, '�˰����� �����', '�˰����� ������') CONTACT_TO_DOCTOR
SELECT empno, ename, hiredate, 
    CASE 
    WHEN MOD (TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(hiredate, 'yyyy') ,2) = 0 THEN '�ǰ����� �����'
    ELSE '�ǰ����� ������'
    END CONTACT_TO_DOCTOR
 FROM emp;
 
 SELECT empno, ename ,hiredate, MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,
      DECODE( MOD(TO_CHAR(hiredate, 'YYYY'), 2) ,0,'�ǰ����� �����', '�ǰ����� ������') CONTACT_TO_DOCTOR
 FROM emp;
 
 ex cond3) 166p
 SELECT userid, usernm, alias , reg_dt,
 CASE
 WHEN MOD ( TO_CHAR(REG_DT, 'YYYY'),2 )=0 THEN '�ǰ����� �����'
 ELSE '�˰����� ������' END CONTACTTODOCTOR
 FROM users;
 

                                    