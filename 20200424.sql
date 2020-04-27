----------------- �����ð� -------------------
SELECT NVL(empno,0), ename, NVL(sal,0), NVL(comm,0)
FROM emp;

NULL ó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)

CONDITION : CASE, DECODE 

�����ȹ : �����ȹ�� ���� ���� ����;

--------------------------------------------

������

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL ���� 5% �λ�� �ݾ��� ���ʽ��� ����(ex: sal 100 -> 105)
�ش� ������ job�� MANAGER�̸鼭 deptno �� 10�̸� SAL ���� 30% �λ�� �ݾ��� ���ʽ��� ����
�� ���� �μ��� ���ϴ� MANAGER��  ��� SAL ���� 10% �λ�� �ݾ��� ���ʽ��� ����    
�ش� ������ job�� PRESIDENT�� ��� SAL ���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿� �������� sal��ŭ�� ����

SELECT empno, ename,deptno, job, sal,
      DECODE(job, 'SALESMAN', sal*1.05,
                  'MANAGER', DECODE(deptno, 10 , sal*1.3,sal*1.1),
                  'PRESIDENT', sal*1.20,
                  sal) bouns
FROM emp;
===================================================================================
���� A ={10, 15, 18, 23, 24, 25, 29, 30, 35, 37}
�Ҽ� : { 23, 29, 37 }   :  COUNT -3, MAX - 37, MIN -23, AVG - 29.66, SUM-89
��Ҽ� :  { 10, 15, 18, 24, 25, 30, 35};

GROUP FUNCTION
�������� ����Ʈ�� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�.
EX : �μ��� �޿� ���
  EMP ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�.
  �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�.
  
  GROUP BY ����� ���ǻ��� : SELECT ����� �� �ִ� �÷��� ���ѵ�
  
  SELECT �׷��� ���� �÷�, �׷��Լ�
  FROM ���̺�
  GROUP BY �׷�� ���� �÷�
  [ORDER BY];
  
��  GROUP BY ���ǻ��� : GROUP BY �� ��� �Ǿ��������� �÷��� SELECT ���� ���� ���� ����. ��
  
  �μ����� ���� ���� �޿� ��;
  SELECT deptno,
     MAX(sal),
     MIN(sal),
     ROUND(AVG(sal),2),
     SUM(sal),
     COUNT(sal),
     COUNT(*)
  FROM emp
  GROUP BY deptno;
  
  .�׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������ 
   ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
   ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����
   
   emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
      
    SELECT MAX(sal),-----��ü ������ ���� ���� �޿� ��
     MIN(sal),-----��ü ������ ���� ���� �޿� ��
     ROUND(AVG(sal),2),-----��ü ������ �޿� ���
     SUM(sal),-----��ü ���� �޿� ��
     COUNT(sal), --��ü ���� �޿� �Ǽ�(sal �÷��� ���� null�̾ƴ� row�Ǽ�)
     COUNT(*),------�μ��� ���� ��
     COUNT(mgr) ---mgr zjffjadl null�ƴ� �ǽ�
  FROM emp;
  
 -----����------- 
  GROUP BY ���� ����� �÷��� 
  SELECT ���� ������ ������ ??
  
  GROUP BY ���� ������� ���� �÷��� 
  SELECT ���� ������ ??
  
  �׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�(�����ƴ�)
  
    SELECT deptno, 'TEST',1,
     MAX(sal),-----�μ����� ���� ���� �޿� ��
     MIN(sal),-----�μ����� ���� ���� �޿� ��
     ROUND(AVG(sal),2),-----�μ��� �޿� ���
     SUM(sal),-----�μ��� �޿� ��
     COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�̾ƴ� row�Ǽ�)
     COUNT(*)------�μ��� ���� ��
  FROM emp
  GROUP BY deptno;
  
  
  GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�
  30�� �μ����� NULL���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�.
  SELECT deptno, sum(comm)
  FROM emp
  GROUP BY deptno;
  
  10�� �μ��� SUM(COMM) �÷��� NULL �� �ƴ϶�  0�� �������� NULL ó��
  .Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����
  
  NVL(SUM(comm), 0) :comm�÷��� sum �׷��Լ��� �����ϰ� ���� ����� NVL�� ���� (1ȸȣ��)
  SUM(NVL(comm, 0)) : ��� comm�÷��� nvl �Լ��� ������(�ش�׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����
  
SELECT deptno, sum(comm),
NVL(SUM(COMM),0)
  FROM emp
  GROUP BY deptno;
  
  single row �Լ��� where ���� ����� �� ������
  multi row �Լ��� (group �Լ�)�� where ���� ����� �� ����
  GROUP BY �� ���� HAVING ���� ������ ���

 SINGLE ROW �Լ��� WHERE ������ ��� ����
 SELECT *
 FROM emp
 WHERE LOWER(ename) = 'smith';
 
 �μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
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
 --�����Ѱ�
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
 ex grp7) 186p---���� 
SELECT count(count(*))  c
FROM emp
GROUP BY deptno;


 
 

  














