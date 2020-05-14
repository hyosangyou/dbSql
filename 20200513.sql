CREATE TABLE DEPT_TEST2 AS
SELECT *
FROM dept
WHERE 1=1;

CREATE TABLE EMP_TEST2 AS
SELECT *
FROM emp
WHERE 1=1;



ex 1)
CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE  INDEX idx_dept_test2_02 ON dept_test2(dname);
CREATE  INDEX idx_dept_test2_03 ON dept_test2(deptno, dname);

ex 2)
DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_dept_test2_02;
DROP INDEX idx_dept_test2_03;

ex 3)

CREATE INDEX idx_emp_test_02 ON emp_test2(ename);
CREATE INDEX idx_emp_test_03 ON emp_test2(empno, deptno);
CREATE INDEX idx_emp_test_04 ON emp_test2(deptno, sal);


DROP INDEX idx_emp_test_06;

���� �ε���
idx_emp_test_02
idx_emp_test_03
idx_emp_test_04

//1
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;

//2
EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE ename = 'smith';


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;


EXPLAIN PLAN FOR
SELECT *
FROM emp_test2
WHERE empno = 7369;

SELECT *
FROM TABLE(dbms_xplan.display);

-----------------------------------------------------------------------
�����ð��� ��� ����  
== > ������ ���� ���¸� �̾߱� ��, ������� �̾߱Ⱑ �ƴ�
inner join : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���� ��� 
outer join : ���ο� �����ص� �����̵Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���� ���
cross join : ������ ����(īƼ�� ������Ʈ), ���� ������ ������� �ʾƼ� ���� ������ ��� ����� ���� ���εǴ� ���
self join  : ���� ���̺� ���� ���� �ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û �ϸ� DBMS�� SQL�� �м��ؼ�
��� �� ���̺� ������ ���� ����, 3���� ����� ���� ���(������ ���� ���, ������� �̾߱�)
1. Nested Loop Join
  ���߷���������
  - ����
  - ����
2. Sort Merge Join 
 - ���εǴ� ���̺��� ���� ����
 - ������ �Ǿ� �����Ƿ� �������ǿ� �ش��ϴ� �����͸� ã�Ⱑ ����
 - ���� ���ǿ� �ش��ϴ� �����͸� ���� (MERGE)
 - ������ ������ ������ �����ϹǷ� ������ ����
 - ���� �������� ���� = > HASH JOIN ��ü
 - H
 
3. Hash Join

OLTP (OnLine Transaction Processing) : �ǽð� ó��  ==> ������ ����� �ϴ� �ý��� (�Ϲ����� �� ����)
OLAP (OnLine Analysis Processing) : �ϰ�ó�� ==> ��ü ó���ӵ��� �߿� �� ��� (���� ���� ���, ���� �ѹ��� ���)

