DML 
�����͸� �Է� (INSERT), ����(UPDATE), ����(DELETE) �� �� ����ϴ� SQL

INSERT

���� INSERT INTO ���̺�� [(���̺��� �÷���, ....)] VALUES (�Է��� ��,....);

ũ�� ���� �ΰ��� ���·� ���
1. ���̺��� ��� �÷��� ���� �Է��ϴ� ���, �÷����� �������� �ʾƵ� �ȴ�.
  �� �Է��� ���� ������ ���̺� ���ǵ� �÷� ������ �νĵȴ�.(�÷������� �߿��ϴ�.)
INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��Ұ�2...);

2. �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���
 ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���.
 �� ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�.
INSERT INTO ���̺�� (�÷�1, �÷�2)VALUES (�Է��� ��, �Է��Ұ�2);


dept ���̺� deptno = 99, dname, ddit, loc daejeon ���� �Է��ϴ� insert ���� �ۼ�

������ �Է��� Ȯ�� �������� : commit - Ʈ����� �Ϸ�
������ �Է��� ��� �Ϸ��� : rollback - Ʈ����� ���


�ΰ����������
1)
INSERT INTO dept VALUES (99,'DDIT','DAEJEON');
2)
INSERT INTO dept (loc, deptno, dname) VALUES ('DAEJEON',99,'DDIT');

select *
from dept;

rollback;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ���
INSERT �������� ��Į�� ��������, �Լ��� ��밡��
EX : ���̺� �����Ͱ� �� ����� �Ͻ������� ����ϴ� ��찡 ���� ==> SYSDATE;

SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������  8��, NOT NULL�� 1��(EMPNO)
empno �� 9999�̰� ename YOUHYOSANG ,HIREDATE �� �����Ͻø� �����ϴ� INSERT ������ �ۼ�
INSERT INTO emp(empno,ename,hiredate) VALUES (9999,'YOUHYOSANG',SYSDATE);
INSERT ���� ������� ���� �÷����� ���� NULL�� �Էµȴ�.

9998�� ������� JW ����� �Է� , �Ի����ڴ� 2020�� 04 �� 13�Ϸ� �����Ͽ� ������ �Է�
INSERT INTO emp(empno,ename,hiredate) VALUES (9998,'JW', TO_DATE('2020/04/13','YYYY/MM/DD'));
rollback;



3.SELECT ����� INSERT
  SELECT ������ �̿��ؼ� ������  ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
  ==> �������� �����͸� �ϳ��� ������ �Է� ���� (ONE-QUERY)==> ���� ����
  
  ����ڷ� ���� �����͸� ���� �Է� �޴� ��� (ex ȸ������)�� ������ �Ұ�
  db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ���� (�̷� ��찡 ����)
  
  
  INSERT INTO ���̺��[(�÷���1, �÷���2...)])
  SELECT ....
  FROM ....

EX) SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�);

DESC dept;

dept ���̺��� 4���� �����Ͱ� ���� (10~40)
�Ʒ� ������ �����ϸ� ���� ���� 4�� + SELECT �� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;

rollback;

---------------------------------------------------------------------------------------------------

UPDATE : ������ ����
UPDATE ���̺�� SET ������ �÷�1 = ������ ��1,
                   [������ �÷�2 = ������ ��2, ....]
[WHERE condition - select ������ ��� where���� ����
       ������ ���� �ν��ϴ� ������ ���]
       
dept ���̺� 99, DDIT, DAEJEON;

INSERT INTO dept VALUES (99,'DDIT','DAEJEON');

SELECT *
FROM dept;

99�� �μ��� �μ����� ��� IT��, ��ġ�� ���κ������� ���� 
--WHERE���� ��� ���ϸ� ��� �÷��� ����� �ٲ��.
UPDATE dept SET DNAME = '���IT', loc = '���κ���'  
WHERE DEPTNO = 99;

SELECT *
FROM dept;

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ ���°� ����, ����
 ==> ������ �ۼ��� ��� ����
     1. WHERE���� �������� �ʾҴ���
     2. UPDATE, DELETE ���� �����ϱ����� WHERE ���� �����ؼ� SELECT �� �Ͽ� 
     ������ ���� ���� Ȯ��
     



