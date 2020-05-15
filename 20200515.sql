ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY �� ����

�Ʒ� ������ ����׷�
1. GROUP BY  job, deptno;
2. GROUP BY  job
3. GROUP BY      ==> ��ü

ROLLUP���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� +1;

-------------------����---------------------------------

GROUP_AD2]

SELECT NVL(job, '�Ѱ�'), deptno,
       GROUPING(job), GROUPING(deptno), SUM(sal)
FROM emp
GROUP BY ROLLUP  (job, deptno);

P25
SELECT DECODE(GROUPING(JOB),1,'�Ѱ�',job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

P26
SELECT DECODE(GROUPING(JOB),1,'��',job) job, DECODE(GROUPING(deptno), 1,DECODE(GROUPING(JOB), 1, '��','�Ұ�'),deptno) deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job,deptno);

SELECT CASE WHEN GROUPING(JOB) = 1 THEN '��' ELSE job END job,
       CASE WHEN GROUPING(DEPTNO) = 1 THEN '�Ѱ�' 
            WHEN GROUPING(DEPTNO) = 1 AND GROUPING(JOB) =1  THEN '��'
            ELSE TO_CHAR(deptno)END deptno,SUM(SAL)
FROM emp
GROUP BY ROLLUP (job,deptno);

p27 ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
(****���� �׷��� ����� Ŀ���� ������ ���� ������ �����鼭 ����)
SELECT deptno, job, SUM(SAL)
FROM emp
GROUP BY ROLLUP(DEPTNO,JOB);

P28
SELECT b.DNAME, a.JOB, a.SAL
FROM 
(SELECT deptno, job, SUM(SAL) SAL
FROM emp
GROUP BY ROLLUP(DEPTNO,JOB)) a, DEPT b
WHERE a.deptno = b.deptno(+);


SELECT dept.dname , emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

p29

SELECT NVL(dept.dname, '�Ѱ�')DNAME , emp.job, SUM(emp.sal)
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, emp.job);

=====================================================================
2. Grouping sets
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�. ROLLUP���� ����� �÷��� �����ʿ���
               ���������� ������ ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
   ROLLUP���� �ٸ��� ���⼺�� ����.
���� : GROUP BY GROUPING SETS (coll, coll2)
�ǹ�
GROUP BY coll
UNION ALL
GROUP BY coll2

GROUP BY GROUPING SETS (coll, coll2)
GROUP BY GROUPING SETS (coll2, coll)
�ΰ��� ����  => ���⼺ X


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������  
1. job ,deptno   //���������� ������ �������̸� ��ȣ�� ���´�
2. mgr 

GROUP BY GROUPING SETS( (job,deptno),mgr )

ex)
SELECT job, deptno, mgr, SUM(SAL)
FROM emp
GROUP BY GROUPING SETS( (job,deptno),mgr );

================================================================
REPORT GROUP FUNCTION == > Ȯ��� GROUP BY
REPORT GROUP FUNCTION �� ����� ���ϸ�
�������� SQL �ۼ�, UNION ALL �� ���ؼ� �ϳ��� ����� ��ġ�� ����
==> �� �� ���ϰ� �ϴ°� REPORT GROUP FUNCTION
================================================================

3. CUBE
���� : GROUP BY CUBE (col1, col2...)
����� �÷��� ������ ��� ���� (������ ��Ų��) , Ȱ�뵵�� ����
cube �� ��� ����� ���� unoin �ϱ� ������  ���ϱ޼������� �þ��.

GROUP BY CUBE (job, deptno);
1      2
job,   deptno
job,   x
x  ,   deptno
x  ,   x
    
    SELECT job, deptno, sum(sal)
    FROM emp
    GROUP BY CUBE (job, deptno);
    

=========================================================
�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2         3 
job     deptno    mgr ==> GROUP BY job, deptno, mgr
job     x         mgr ==> GROUP BY job, mgr
job     deptno    x ==> GROUP BY job, dept
job     x         x ==> GROUP BY job

SELECT job, deptno, mgr, SUM(sal + NVL(COMM,0))SAL
FROM emp
GROUP BY job, rollup(job, deptno), cube(mgr);

1      2            3
job   job, deptno   mgr   ==> GROUP BY job, deptno, mgr
job   job           mgr   ==> GROUP BY job, mgr
job   x             mgr   ==> GROUP BY job, mgr
job   job, deptno   x     ==> GROUP BY job, deptno
job   job           x     ==> GROUP BY job
job   x             x     ==> GROUP BY job

���߿��ϴ�

===========================================================

��ȣ���� �������� ������Ʈ
1. emp ���̺��� �̿��Ͽ� emp_test ���̺� ����
    ==> ������ ������ EMP_TEST ���̺� ���� ���� ����
    DROP TABLE emp_test;
    
    CREATE TABLE emp_test AS 
    SELECT *
    FROM emp;
    
2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
  DESC dept;
   ALTER TABLE emp_test ADD(dname VARCHAR2(14));
   DESC emp_test;

3. subquery�� �̿��Ͽ� emp_test ���̺� �߰���  dname �÷���  ������Ʈ ���ִ� ������ �ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷��� update
emp_test ���̺��� deptno ���� Ȯ���ؼ� dept ���̺��� deptno ���̶� ��ġ�ϴ� dname �÷����� ������ update

emp_test ���̺���  dname �÷��� dept ���̺� �̿��ؼ� dname�� ��ȸ�Ͽ� ������Ʈ
update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����

��������� ������� DNAME �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test SET dname = (SELECT dname 
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);

44p ex
1.���̺� ����
CREATE TABLE dept_test AS
SELECT *
FROM dept;

2. ���̺� �÷��߰�
ALTER TABLE dept_test ADD (empcnt NUMBER);
DESC dept_test;

3.subquery �� �̿��Ͽ� dept_test���̺��� empcnt �÷��� �ش� �μ��� ���� update�ϴ� ������ �ۼ��ϼ���
UPDATE dept_test SET empcnt = ( SELECT COUNT(*)
                                FROM emp
                                WHERE dept_test.deptno = emp.deptno
                               );
                                
                                select *
                                from dept_test;
                                
                                select deptno, count(*)
                                from emp
                                group by deptno;


SELECT ��� ��ü�� ������� �׷��Լ��� �����Ѱ��
���Ǵ� ���� ������  0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1 = 2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ������� ��ȸ�Ǵ� ���� ����.
SELECT COUNT(*)
FROM emp
WHERE 1 = 2;
GROUP BY 

                               

