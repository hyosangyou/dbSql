�����ð� ����
�Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ

WHERE���� ��밡���� ������
WHERE deptno = 10
==>

�μ���ȣ�� 10Ȥ�� 30���� ���
WHERE deptno IN(10,30)
WHERE deptno =10 OR deptno =30;

----------------------------------------------------------
������ ������
�������� ��ȸ�ϴ� ���������� ��� = �����ڸ� ���Ұ�
WHERE deptno IN(�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)

ex)
SMITH - 20, ALLEN�� 30�� �μ��� ����
SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ

���� ��������, �÷��� �ϳ��� ==> ������������ ��밡���� ������ IN(���̾�, �߿�), (ANY, ALL, �󵵰� ����)
IN : ���������� ������� ������ ���� ���� �� TRUE
    WHERE �÷�|ǥ���� IN (��������)

ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
   WHERE �÷�|ǥ���� ������ ANY (��������)
   
ALL : ���������� ��� ���� �����ڸ� �����Ҷ� TRUE 
   WHERE �÷�|ǥ���� ������ ALL (��������)   
   
SMITH�� ALLEN�� ���� �μ����� �ٹ��ϴ� ��� ������ ��ȸ

1. ���������� ������� ���� ��� : �ΰ��� ������ ����
1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ����
EX)
SELECT deptno
FROM emp
WHERE ename IN('SMITH','ALLEN');

1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
EX)
SELECT *
FROM emp
WHERE deptno IN (20,30);

==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
EX)
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN('SMITH','ALLEN'));
                 
ex sub3 -255p)
SELECT *
FROM emp    
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
                
ANY, ALL EX)
SMITH(800)�� WARD(1250) �λ���� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
==> SAL < 1250
SELECT *
FROM emp 
WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
SMITH(800)�� WARD(1250) �λ���� �޿� ���� ���� �޿��� �޴� ���� ��ȸ
==> SAL > 1250
SELECT *
FROM emp 
WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
IN �������� ����
�ҼӺμ� 20, Ȥ�� 30 �� ���
WHERE deptno IN(20, 30)


�ҼӺμ� 20,30 �� ������ �ʴ� ���
WHERE deptno NOT IN(20, 30)
NOT IN �����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�
==> NULL ������ ����  ��� �Ұ�


�Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�??
���1
NULL ���� ���� ���� ����
SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);
���2
NULLó�� �Լ��� ���� ������ ������ ���� �ʴ� ������ ġȯ
SELECT *
FROM emp
WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);
                    
���� �÷��� �����ϴ� ���������� ���� ���� ==> ���� �÷��� �����ϴ� ��������
PAIRWISE ���� (������) ==> ���ÿ� ����

SELECT mgr, deptno
FROM emp 
WHERE empno IN (7499, 7782); WHERE empno = 7499;

7499, 7782����� ������ (�����μ�, ���� �Ŵ���) �� ��� ���� ���� ��ȸ
�Ŵ����� 7698 �̸鼭 �ҼӺμ��� 30�ΰ��
�Ŵ����� 7839 �̸鼭 �ҼӺμ��� 10�ΰ��

2��

MGR �÷��� deptno �÷��� �������� ����. (mg)
SELECT *
FROM emp
WHERE mgr IN(7698, 7839)
  AND deptno IN(10,30);
 
PAIRWISE ���� (���� �÷����� ����� �Ѱ� �۴�)  
SELECT *
FROM emp 
WHERE (mgr, deptno) IN(SELECT mgr, deptno
                       FROM emp
                       WHERE empno IN(7499,7782));
                       
------------------------�߰����� -------------------------

�������� ���� - ��� ��ġ
SELECT ���� ��ġ - ��Į�� ���� ����
FROM ���� ��ġ - �ζ��� ��
WHERE ���� ��ġ -��������

�������� ���� - ��ȯ�ϴ� ��, �÷��� ��
���� ��
     ���� �÷�(��Į�� ���� ����)
     ���� �÷�
���� ��
     ���� �÷�(���� ���� ����) 
     ���� �÷�
     
��Į�� �������� 
SELECT ���� ǥ���Ǵ� ��������
������ ���� �÷��� �����ϴ� ���������� ��� ����
���� ������ �ϳ��� �÷� ó�� �ν�;

SELECT 'X',(SELECT SYSDATE FROM dual)
FROM dual;

��Į�� ���� ������ �ϳ��� ��,  �ϳ��� �÷��� ��ȯ �ؾ��Ѵ�.
���� �ϳ����� �÷��� 2������ ����
SELECT 'X', (SELECT empno, ename FROM emp WHERE ename ='SMITH')
FROM dual;

������ �ϳ��� �÷��� �����ϴ� ��Į�� �������� ==> ����
SELECT 'X', (SELECT empno FROM emp)
FROM dual;

emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ���� ==> ����
Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
SELECT dname
FROM dept
WHERE deptno = 10;

�� ������ ��Į�� ���������� ����
SELECT empno, ename, emp.deptno, (SELECT dname FROM dept WHERE deptno = emp.deptno) dname
FROM emp;

join���� ����
SELECT empno, ename, dept.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
��ȣ���� ��������(corelated sub query)
   - ���� ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�.
   
���ȣ ���� ��������(non corelated sub query)
   - main ������ ���̺��� ���� ��ȸ �� ���� �ְ�
     sub ������ ���̺��� ���� ��ȸ �� ���� �ִ�.
     ==> ����Ŭ�� �Ǵ� ���� �� ���ɻ� ������ �������� ���� ������ ����

��� ������ �޿���� ���� ���� �޿��� �޴� ������ ��ȸ�ϴ� ������ �ۼ� �ϼ��� (���� ���� �̿�)
SELECT *
FROM emp
WHERE sal > (SELECT avg(sal)
             FROM emp);
�����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�?
 ���ȣ ���� ���� �����̴�.
 
 ������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
 ��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���
 
 Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
 SELECT AVG(SAL)
 FROM emp
 WHERE deptno = 10;
 
SELECT *
FROM emp e
WHERE SAL >( SELECT AVG(SAL)
             FROM emp
             WHERE deptno = e.deptno);
             
 ---------------------------------------------------------------------
 ������ ����
 INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
 
 emp���̺� ��ϵ� �������� 10, 20, 30�� �μ����� �Ҽ��� �Ǿ�����
 ���� �Ҽӵ��� ���� �μ� : 40, 99
 
 ex sub4 ) 268
 SELECT *
 FROM dept
 WHERE deptno NOT IN(SELECT deptno FROM emp); 
 
 ���������� �̿��Ͽ� IN �����ڸ� ���� ��ġ�Ѵ� ���� �ִ��� ������ ��
 ���� ������ �־ ������� (����)
 
 ex sub5 )269
 SELECT *
 FROM PRODUCT 
 WHERE  PID NOT IN (  SELECT PID
                      FROM CYCLE
                      WHERE CID =1);
                      
ex sub6) 270p
SELECT *
FROM CYCLE
WHERE CID = 1
AND PID IN (SELECT PID FROM CYCLE WHERE CID =2);

ex sub7) 271p
-join version-
select CID,T.CNM, P.PID, P.PNM, T.DAY, T.CNT
FROM
(SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer , cycle 
WHERE customer.cid = cycle.cid
AND customer.CID = 1
AND PID IN (SELECT PID FROM CYCLE WHERE CID =2))T, PRODUCT P
WHERE T.PID = P.PID;

-scala version-
SELECT cid,(SELECT cnm FROM customer WHERE cid = cycle.cid) cnm,
        pid,(SELECT pnm FROM product WHERE pid = cycle.pid) pnm, day, cnt
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid =2);



