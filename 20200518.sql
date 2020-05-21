sub_a2]  46p
DROP table dept_test;
CREATE TABLE dept_test

1. 
CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. 
INSERT INTO dept_test VALUES(99, 'it1', 'daejeon'); 
INSERT INTO dept_test VALUES(98, 'it2', 'daejeon');

3. emp���̺��� �������� ������ ���� �μ� ���� �����ϴ� ������ ���������� �̿��Ͽ� �ۼ��ϼ���
DELETE dept_test
WHERE deptno NOT IN ( SELECT emp.DEPTNO
                      FROM emp ,dept_test
                      WHERE emp.deptno = dept_test.deptno);
                  
                  OR
                  
DELETE dept_test
WHERE NOT EXISTS ( SELECT 'X'
                   FROM emp
                   WHERE emp.deptno = dept_test.deptno);
                   
                   ROLLBACL;
SUB_a3 47P
UPDATE emp_test e SET sal = sal +200
WHERE SAL <(SELECT AVG(SAL)
            FROM emp_test o
            WHERE e.deptno = o.deptno
            GROUP BY deptno);
            
            SELECT *
            FROM emp_test;
            
            SELECT AVG(SAL)
            FROM emp
            GROUP BY deptno
______________________________________________________________________z
���Ŀ��� �ƴ����� ,�˻� - ������ ���ֳ����� ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ ���� �������� (EXISTS)
           ==> ���� ���� ���� ���� ==> ���� ���� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����

13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
              FROM emp);
              
SELECT *
FROM emp
WHERE mgr IN (7369, 7499, 7521....);

�μ��� �޿� ����� ��ü �޿� ��պ��� ū �μ��� �μ���ȣ, �μ��� �޿���� ���ϱ�
�μ��� ��� �޿�(�Ҽ��� ��° �ڸ����� ��� �����)
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT  ROUND(AVG(sal), 2)
FROM emp;

�Ϲ����� �������� ����
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT  ROUND(AVG(sal), 2)
                            FROM emp);
 
                 OR

WITH���� �̿��� ����
WITH emp_avg_sal AS(
    SELECT  ROUND(AVG(sal), 2)
    FROM emp
    )
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                            FROM emp_avg_sal);

WITH �� : SQL���� �ݺ������� ������  QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ� 
          SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸� 
          Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD 
          ��, �ϳ��� SQL ���� �ݺ����� SQL ���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������
          �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ,
          
          ____________________________________________________________________________

�������� 
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE)�� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT dual.*,LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸� 10000�ǿ� ���� DISK I/O �� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;

1. �츮���� �־��� ���ڿ� ��� : 202005
   �־��� ����� �ϼ��� ���Ͽ� �ϼ���ŭ ���� ���� ==>31 

���� 1   
SELECT TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')
FROM dual;  
���� 2
SELECT TO_DATE('202005', 'YYYYMM'), LEVEL
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')
���� 3
SELECT TO_DATE('202005', 'YYYYMM'), LEVEL,
       TO_DATE('202005', 'YYYYMM')+(LEVEL-1) dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')

�޷� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����
�Ʒ��� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ� 
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����.
SELECT TO_DATE('202005', 'YYYYMM')+(LEVEL-1) dt,
       DECODE(TO_CHAR(TO_DATE('202005', 'YYYYMM')+(LEVEL-1), 'D'), '1', TO_DATE('202005', 'YYYYMM')+(LEVEL-1)) SUNDAY
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')

�ζ��κ並 ����Ͽ� ����
�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005', 'YYYYMM') + (LEVEL - 1) ==> dt
dt �� �������̸� dt, dt�� ȭ�����̸� dt.... 7���� �÷��߿� �� �ϳ��� �÷����� dt���� ǥ���ȴ�.

�޷� �����
 
SELECT  MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
        MIN(DECODE(d, 4, dt)) wen, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM')+(LEVEL-1) dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+(LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM')+(LEVEL-1), 'iw') iw
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'))
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);


�޷� ����� �ǽ� 1 p23
�޷¸���� ���� ������ .sql�� �Ϻ� ���� �����͸� �̿��Ͽ� 1~6���� ���� ���� �����͸� ������ ���� ���ϼ���.

SELECT *
FROM sales;

SELECT NVL(SUM(DECODE(m, 1, sales)), 0) jan, NVL(SUM(DECODE(m, 2, sales)), 0) feb, NVL(SUM(DECODE(m, 3, sales)), 0) mar,
       NVL(SUM(DECODE(m, 4, sales)), 0) apr, NVL(SUM(DECODE(m, 5, sales)), 0) may, NVL(SUM(DECODE(m, 6, sales)), 0) jun
FROM
(SELECT dt, sales, TO_CHAR(dt, 'mm') m
FROM sales);




                          

