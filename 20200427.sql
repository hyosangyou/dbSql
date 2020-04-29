 +ex grp7) 186p---���� 
 dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�系�� �����ϴ� ��� �μ�����
 emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==> 10, 20 ,30 ==> 3��

SELECT COUNT(*) cnt
FROM 
   (SELECT deptno /*deptno �÷��� 1������, row��  3���� ���̺� */
    FROM emp
    GROUP by deptno); 
    --IN-LINEVIEW �� ���Ͽ� ���̺�ȭ �Ѵ�.

    
    ---------------------------�����ð�---------------------------------------------
    --��� --
    DBMS : DataBase Management System
    ==> db
    RDBMS : Relational DataBase Management System
    ==> ������ �����ͺ��̽� ���� �ý���
    
    JOIN : �ٸ����̺��� �����͸� ���������� ���̺�� �����Ͽ� ����Ѵ�.
    RDBMS�� �ߺ��� �ּ�ȭ�Ѵ�.
    
    JOIN ������ ����
    ANSI - ǥ��
    �������� ����(ORACLE) 
    
    JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
    SELECT �Ҽ� �ִ� �÷��� ������ ��������. (����Ȯ��)
    
    ���տ��� ==> ����Ȯ�� (���� ��������.)
    
    -----------------------------------------------------------------------------------
    NATURAL JOIN 
       . �����Ϸ��� �� ���̺��� ����� �÷��� �̸� �������
       . emp, dept ���̺��� deptno��� ������ ����� �÷��� ����
       . �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������
       ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����.
       
    EX)
    ���� �Ϸ����ϴ� �÷��� ���� ������� ����  
   SELECT *
   FROM emp NATURAL JOIN dept; 
   ------------------------------------------------------------------------------------
   
   ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
   ����Ŭ  ���� ����
   1. ������ ���̺� ����� FROM ���� ����Ͽ� �����ڴ� �ݷ�(,)
   2. ����� ������ WHERE ���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = dept.deptno)
   
   SELECT *
   FROM emp, dept
   WHERE emp.deptno = dept.deptno;
   
   deptno�� 10���� �����鸸 dept ���̺�� ���� �Ͽ� ��ȸ
   
      SELECT *
   FROM emp, dept
   WHERE emp.deptno = dept.deptno     --- ������ �÷����� ���̺���ġ�� ���������Ѵ�
    AND emp.deptno = 10;        ---- ���������� WHERE���� ���
    
  --------------------------------ANSI-SQL ���빮��------------------------------------------- 
   
  ANSO-SQL : JOIN with USING  ���� ���� ����
  .JOIN �Ϸ��� ���̺� �̸��� ���� �÷��� 2���̻��� ��
  .�����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���
  
  SELECT * 
  FROM emp JOIN dept USING (deptno);
  
  ANSI- SQL : JOIN with ON
  .���� �Ϸ��� �� ���̺� �÷����� �ٸ� ��
  .ON���� ����� ������ ���
  
  SELECT *
  FROM emp JOIN dept ON (emp.deptno = dept.deptno);
  
  ORACLE �������� �� SQL �ۼ�
  SELECT *
  FROM emp,dept
  WHERE emp .deptno = dept.deptno;
  
  ------------------------------------------------------------------------
  JOIN�� ������ ����
  SELF JOIN : �����Ϸ��� ���̺��� ���� ������ 
  EMP ���̺��� ������ ������ ������ ���³��� ������ ������ mgr �÷���  �ش� ������ ������ ����� ����.
  �ش� ������ �������� �̸��� �˰���� ��   -����x
  
  ANSI-SQL�� SQL ���� : 
  �����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
         ����� �÷�: ����.MGR = ������.EMPNO
         ==> ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
            ==>NATURAL JOIN, JOIN WITH USING�� ����� �Ұ����� ����
              ==> JOIN with ON
 ex) -- ���̺� join�ҋ� ������ ���̺��� ��� �����̺� ��Ī���־� ǥ���� �� �ִ�.
  SELECT *
  FROM emp  e JOIN emp a ON(e.mgr = a.empno); 
  
  NONEUQI JOIN : ����� ������ = �� �ƴҋ�;


SELECT *
FROM emp;

SELECT *
FROM salgrade;

SELECT emp.empno, emp.ename, emp.sal, salgrade .grade
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal)  ;

==> �� EX) ORACLE ���� �������� ����
SELECT emp.empno, emp.ename, emp.sal, salgrade .grade
FROM emp,salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

-----------------------�ǽ� ---------------------------------------

ex 1 p202
--ORACLE ���--
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp,dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno;

--AN-SI ���--
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp JOIN dept ON(emp.deptno =dept.deptno)
ORDER BY deptno;

ex2 p203
--ORACLE--
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN(10,30); 

--AN-SI ��� --
SELECT emp.EMPNO, emp.ENAME, emp.DEPTNO, dept.DNAME
FROM emp JOIN dept ON(emp.deptno  =dept.deptno AND emp.deptno IN (10,30));

ex3 p204
--ORACLE ���--
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.sal>2500
ORDER BY DEPTNO;

--AN-SI ��� --
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp JOIN dept ON(emp.deptno  =dept.deptno AND emp.sal >2500)
ORDER BY DEPTNO;

ex4 p205
--ORACLE ���--
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.sal>2500 
AND empno>7600
ORDER BY DEPTNO;

--AN-SI ��� --
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp JOIN dept ON(emp.deptno  =dept.deptno AND emp.sal >2500 AND empno>7600)
ORDER BY DEPTNO;    

ex5 p206
--ORACLE ���--
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp,dept
WHERE emp.deptno = dept.deptno
AND emp.sal>2500
AND EMPNO >7600
AND dname ='RESEARCH'
ORDER BY DEPTNO;

--AN-SI ��� --
SELECT emp.EMPNO, emp.ENAME,sal, emp.DEPTNO, dept.DNAME
FROM emp JOIN dept ON(emp.deptno = dept.deptno AND emp.sal >2500 AND EMPNO>7600 AND dname = 'RESEARCH')
ORDER BY DEPTNO;

ex1 ) 207p
SELECT LPROD.LPROD_GU, LPROD.LPROD_NM, PROD.PROD_ID, PROD.PROD_NAME
FROM prod,lprod
WHERE prod.PROD_LGU = LPROD.LPROD_GU;





    
    
    