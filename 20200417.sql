SELECT ���� ���� : 
    ��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : �����ð��� �ٸ��� ����..
    ���ڿ� ����
       ���ͷ� : ǥ����
             ���� ���ͷ� : ���ڷ� ǥ��
             ���� ���ͷ� :  java : "���ڿ�"/ sql : 'sql'
                  SELECT 'SELECT * FROM ' || table_name
             ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
            ��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                 TO_DATE('20200417', 'yyyymmdd')
    
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����

SELECT *
FROM users 
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ���� 2000���� �۰ų� ���� ������ ��ȸ =>BETWEEN AND
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal>= 1000
AND sal<=2000;


ex ) 
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'YYYY/MM/DD') AND TO_DATE('1983/01/01', 'YYYY/MM/DD');

IN ������
�÷�|Ư���� IN(��1, ��2 ...)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
=> deptno�� 10 �̰ų� 30���� ����
deptno = 10 or deptno = 30



SELECT *
FROM emp
WHERE deptno =10
    OR deptno =30;
    
ex3)
SELECT userid ���̵� ,usernm �̸� , alias ���� 
FROM users
WHERE userid IN ('brown', 'cony', 'sally');


���ڿ� ��Ī ���� : LIKE ���� / JAVA :.startsWith(prefix), .endsWith(suffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����) 
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE



�÷� |Ư���� LIKE ���� ���ڿ�;

'cony' : cony�� ���ڿ� 
'co%'  : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� ���ִ� ���ڿ�  ex) ���ΰ� : 'cony', 'con', 'co'
'%co%' : co�� �����ϴ� ���ڿ� ex) ���ΰ� : 'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �ü� �ִ� ���ڿ�

EX)���� �̸� (ename)�� �빮�� S�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%'; 

EX 4
SELECT MEM_ID, MEM_NAME
FROM member
WHERE mem_name LIKE '��%';

EX5 
SELECT MEM_ID, MEM_NAME
FROM MEMBER
WHERE MEM_NAME LIKE '%��%';

NULL ��
SQL���� NULL ���� ���� ��� �Ϲ����� �񱳿�����(=)�� ��� �� �ϰ� IS �����ڸ� ���

EX) MGR�÷� ���� ���� ��� ������ ��ȸ
 SELECT *
 FROM emp
 WHERE mgr IS null;
 
 ���� �ִ� ��Ȳ���� � �� : =, !=, <>
 NULL : IS NULL , IS NOT NULL
 
 EMP���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
 EX)
 SELECT *
 FROM emp
 WHERE mgr IS NOT null;
 
 EX)
 SELECT *
 FROM emp
 WHERE COMM IS NOT NULL;
 
EX)
 SELECT * 
 FROM emp
 WHERE mgr  IN(7698, 7839);
 ==> WHERE  mgr = 7698 OR mgr =7839
 
 EX)
 SELECT * 
 FROM emp
 WHERE mgr NOT IN(7698, 7839);  
  ==> WHERE  (mgr != 7698 AND mgr !=7839)
 
 
 EX) 
 SELECT *
 FROM emp
 WHERE job =('SALESMAN') AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD'); 
 
 EX)
 SELECT *
 FROM emp
 WHERE DEPTNO !=(10) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
 
 EX)
 SELECT *
 FROM emp
 WHERE DEPTNO NOT IN (10) AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
 
 EX)10
SELECT *
 FROM emp
 WHERE DEPTNO IN (20,30)
   AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
   
EX)11
SELECT *
FROM emp
WHERE job =('SALESMAN')
OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

EX)12
SELECT *
FROM emp
WHERE job =('SALESMAN')
OR EMPNO LIKE ('78%') ;

EX)13
SELECT *        
FROM emp
WHERE job =('SALESMAN')
OR EMPNO >= 7800
AND EMPNO <7900;

EX)14
SELECT *
FROM emp
WHERE job =('SALESMAN')
OR (EMPNO >= 7800 AND EMPNO <7900)
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');



���� : {a, b, c} == {a, c, b}

table���� ��ȸ, ����� ������ ����(�������� ����)
==> ���нð��� ���հ� ������ ����

SQL������ ����Ʈ�� �����Ϸ��� ������ ������ �ʿ�
ORDER BY �÷��� [��������], �÷���2[��������]....
������ ���� : ��������(DEFAULT) -ASC, �������� -DESC

���� �̸����� ���� ��������
SELECT *
FROM emp
ORDER BY ename ASC;

���� �̸�����  ���� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

job�� �������� ���� ���������ϰ� job�� ������� �Ի����ڷ� �������� ����
ex)
SELECT *
FROM emp
ORDER BY JOB ASC, hiredate DESC;




 
   

 
 
 

 

