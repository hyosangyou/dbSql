table���� ��ȸ/���� ������ ����
==> ORDER BY �÷���, ���Ĺ��...

ORDER BY �÷����� ��ȣ�� ���İ���
==> ���� : SELECT �÷��� ������ �ٲ�ų�, �÷� �߰��� �Ǹ� ���� �ǵ���� �������� ���� ���ɼ��� ����

SELECT�� 3��° �÷��� ������� ����
SELECT *
FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
SAL*DEPTNO SAL_DEPT

SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

ex1)
DEPT ���̺��� DNAME���� ������������
SELECT *
FROM dept
ORDER BY DNAME;

DEPT ���̺��� LOC���� ������������
SELECT *
FROM dept
ORDER BY LOC DESC;

���ͷ�  
���� : ����
���� : '����'

Eemp
emp ���̺� comm ���� null �� 0���� �� �� ���� comm ������������ �����ϴµ� ���� ������ empno�� ������������ �����Ѥ���.
SELECT *
FROM emp
WHERE comm != 0
ORDER BY COMM DESC, EMPNO ASC;
null���� ������ �׻� null �̱⶧���� ��� ���ص� �ȴ�.

EMP ���̺� MGR�� ������ JOB �������������ϰ� ���� ������ EMPNO �� �������� �����Ѵ�.
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY JOB, EMPNO DESC;

EMP ���̺� DEPTNO�� 30 �̰ų� 10 �λ���� �߿� SAL�� 1500�λ���� �̸��� ������������ �����Ͽ���
SELECT *
FROM emp
WHERE (deptno = 30 
OR deptno = 10)
AND sal > 1500
ORDER BY ENAME DESC;

����¡ ó���� �ϴ� ����
1. �����Ͱ� �ʹ� �����ϱ�
  . �� ȭ�鿡 ������ ��뼺�� ��������.
  . ���ɸ鿡�� ��������.
  
����Ŭ���� ����¡ ó�� ��� ==> ROWNUM
ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEYWORD

SELECT ROWNUM, empno, ename
FROM emp;

SELECT���� *ǥ���ϰ� �޸��� ���� �ٸ� ǥ��(ex ROWNUM)�� ����Ұ�� *�տ�
� ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ� �Ѵ�.
SELECT ROWNUM, e.*
FROM emp e;

����¡ ó���� ���� �ʿ��� ����
1. ������ ������(10)
2. ������ ���� ����

1-page : 1~10
2-page : 11~20(11~14)

1. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;


2. ������ ����¡ ����
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 11 AND 20;

ROWNUM�� Ư¡ 
1. ORACLE���� ����
 . �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
2. 1������ ���������� �д°�츸 ����
 ROWNUM BETWEEN 1 AND 10 ==> 1~10
 ROWNUM BETWEEN 11 AND 20 ==> 1~10�� SKIP�ϰ� 11~20�� �������� �õ�
 
 WHERE ������ ROWNUM�� ����� ��� ���� ����
 ROWNUM = 1;
 ROWNUM BETWEEN 1 AND N; => � ���� �͵� �������.
 ROWNUM <, <= N(1~N)
 
 ROWNUM�� ORDER BY
 SELECT ROWNUM,empno, ename
 FROM emp
 ORDER BY empno;
 
 ROWNUM�� Ư¡
 1. ORDER BY ������ ����
 SELECT -> ROWNUM -> ORDER BY ����
 EX) ���׹��� �����ִ�
  SELECT ROWNUM,empno, ename
 FROM emp
 ORDER BY ename;
 
 ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW �� ����ؾ� �Ѵ�.
 ** IN-LINE : ���� ����� �ߴ�.

�����̵� ���¿��� ROWNUM�� �ο��ϴ� ������� IN-LINE VIEW �� ����� ROWNUM�� �ο��Ѵ�.
SELECT ROWNUM, a.*
FROM
 (SELECT  empno, ename 
 FROM emp
 ORDER BY ename) a;
 ()�� IN-LINE VIEW ����Ѵ�. ��ȣ�� ���缭 G�ϳ��� ���̺�� ���� ����Ѵ�.
 
 
 ���ʿ��ִ�  �� �ٱ����� ����ص� �������.
 ROWNUM�� 1���� ��ȸ�� �����ѵ� IN-LINE VIEW �� �����  1�̾ƴ� ���ڿ��� ��ȸ�� �����ϴ�.
EX)
 SELECT a.*
 FROM
     (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename 
         FROM emp
         ORDER BY ename) a) a
 WHERE rn BETWEEN 11 AND 20;
 
- N���� page���ϴ¹�-
 WHERE rn BETWEEN 1 AND 10; 1 PAGE
 WHERE rn BETWEEN 11 AND 20; 2 PAGE
 WHERE rn BETWEEN 21 AND 30; 3 PAGE
 .
 .
WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n;  n PAGE

SQL���� ������ �����Ҷ��� :������ �� ����Ѵ�.
EX)
 SELECT a.*
 FROM
     (SELECT ROWNUM rn, a.*
     FROM
        (SELECT  empno, ename 
         FROM emp
         ORDER BY ename) a) a
WHERE rn BETWEEN 1+ (:page -1)* :pageSize AND :page * :pageSize;


----------����--------------- 
SELECT  empno, ename 
FROM emp
ORDER BY ename

1.��������� �������־� ROWNUM�� �����ϰ� �����ϱ⶧���� ROWNUM�� ���� IN-LINE VIEW�� �������
IN-LINE VIEW �� �ۼ��� ����
SELECT *
FROM
(SELECT  empno, ename 
FROM emp
ORDER BY ename);

view�� �ۼ��� ���� -view��� ��ü�� ���� �ۼ� --���� �ؿ� ����� ����. 
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view �� ����� ������ ����� ��� ������ ������???
--�Ȱ���.

���� �ۼ��� ������ ã�ư���
JAVA : �����
SQL : ����� ���� ����

����¡ ó�� ==> 1.����, 2.ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �Ͽ� ���ڰ� ���̴� ���� �߻� ==>�ذ��� : INLINE-VIEW
���Ŀ� ���� INLINE-VIEW
ROWNUM�� ���� INLINE-VIEW

//SELECT �� *����Ҷ� �������� * ���� �ۼ�������Ѵ�. a.*��� ���������ָ� ROWNUM���Ұ�
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a;

//ROWNUM �� 1���ͽ����ؾ� �ϱ⶧���� ������ �۵��� �Ұ��ϴ� WHERE BETWEEN 11 AND 20 = > X
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a;
WHERE BETWEEN 11 AND 20;     --> ���� �Ұ��ϴ�.

//ROWNUM �� 1���;ƴ� �ٸ������� ��ȸ �����ϰ� �ϱ����� �ѹ��� INLINE-VIEW �θ����. �������� �����Ҷ� �ȿ� ����� ������ �״�� ��밡���ϴ�.
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 20;

ex) 
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

** �ű� ����
PROD ���̺���  PROD_LGU (��������), PROD_COST(��������)���� �����Ͽ� ����¡ ó�� ������ �ۼ� �ϼ���
�� ������ ������� 5
���ε� ���� ����� �� 
���� : ���� -> ROWNUM ->rn ����ϱ����� where�� �߰��ϱ����� �ٽ��ѹ� INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn,a.*
FROM
(SELECT  *
FROM PROD
ORDER BY PROD_LGU DESC , PROD_COST ASC)a)
WHERE rn BETWEEN 1+ (:page -1)* :pageSize AND :page * :pageSize;





--------�����н� -------
INLINE-VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�,  ���߿� ���´�)
VIEW - ���� (view ���̺� -x)

DML - Data Manipulation Language  : SELECT , INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME

 --emp_ord_by_ename�̶�� ����Ŭ ��ü�� ����ų� �����ϴ� VIEW�� �ٲٱ����� ��ɾ�
 -- �����ϱ� ���ؼ��� system ������ ���� �Ǹ��� ����Ѵ�.
 -- ���� ��ɾ� : GRANT CREATE VIEW TO you;
CREATE OR REPLACE VIEW  emp_ord_by_ename AS 
   SELECT empno, ename
   FROM emp
   ORDER BY ename;
   
   
   


 
 
 

  


