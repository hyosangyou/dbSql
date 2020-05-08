view�� �����̴�.

DDL : Data Definiton Language
�����͸� �����ϴ� ���
CREATE, DROP, ALTER

***********************************
DDL�� ���� �ڵ� Ŀ��(ROLLBACK �Ұ�)
***********************************

name CHAR(10);

name = 'test' ==> 'test        '


TABLE ����
���� : DROP TABLE ������ ���̺��;

ex) ranger ���̺� ����

DROP TABLE ranger;

���̺� ��� Ȯ�� (refresh :  ���ΰ�ħ)

DDL�� ROLLBACK �Ұ� (�ڵ� COMMIT)

TABLE ����
����: CREATE TABLE [������.] ���̺�� (
                            �÷���1 �÷�Ÿ�� DEFAULT ������ �⺻��,
                            �÷���2 �÷�Ÿ��,
                            �÷���3 �÷�Ÿ��
                            ......
                            );

ranger ���̺��� ������ ���� �÷����� ����
ranger_no �÷��� NUMBER Ÿ������
ranger_nm �÷��� VARCHAR2(50) Ÿ������
reg_dt �÷��� DATE Ÿ������ (��, �⺻���� �Է´���� ������ ����ð�)

CREATE TABLE ranger( 
         ranger_no NUMBER, 
         ranger_nm VARCHAR(50), 
         reg_dt DATE DEFAULT SYSDATE
    );
    
���̺� ��Ͽ��� ���̺� Ȯ��

DDL�� ROLLBACK �Ұ�

INSERT INTO ranger(ranger_no, ranger_nm) VALUES (1,'brown');
reg_dt �÷��� ���� �Է����� �ʾ����� ���̺� ������ ����
�⺻�� sysdate�� �Է��� �ȴ�;

select * from ranger;

DDL ��������
�������� ���Ἲ�� ��Ű�� ���� ����
�� 4���� ���������� ����

UNIQUE : ������ �÷��� ���� �ٸ� ���� ���� �ߺ����� �ʵ��� ����
         EX) ���,�й�
PRIMARY KEY : UNIQUE ���� + NOT NULL CHECK ����
         ���� �����ؾ� �ϸ�, ���� �ݵ�� ���;� �ϴ� �÷�
         EX) ���, �й�
FOREIGN KEY : �ش� �÷��� �����ϴ� ���̺��� ���� �����ϴ��� Ȯ���ϴ� ����
         EX) emp ���̺� �űԻ���� ��Ͻ� deptno ���� dept ���̺� �ݵ��
            �����ϴ� ���� ����� �����ϴ�
CHECK : �÷��� �ԷµǴ� ���� �����ڰ� ���� ������ ���� üũ, ���� �ϴ� ����
         EX) ���� �÷��� ���� F, M �ΰ��� ���� �� �� �ֵ��� ����
        
���������� �����ϴ� ���( 2,3���� �ַ� ����Ѵ�.)
1. ���̺� ������ �÷� �����ٰ� �ش� �÷��� ����� ���������� ���
 ==> �����÷� ������ �Ұ�
2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���
 ==> �����÷� ���� ����
3. ���̺� ���� ����, ������ �������Ǹ� �ش� ���̺� ����
 ==> ���̺� ����, �����÷� ���� ����


1.���̺� ������ �÷� ���� ���������� ���
�μ���ȣ�� �ߺ��� �Ǹ� �ȵǰ�, ���� ��� �־�� �ȵȴ� (�Ϲ�������)
==> dbms���� ���� ������ PRIMARY KEY ���������� �÷� ������ ����

DROP TABLE dept_test;

�������� �̸��� ������� ���� ��� ����Ŭ DBMS�� �ڵ����� �������� �̸��� �ٿ��ش�.
CREATE TABLE dept_test(
   deptno NUMBER(2) PRIMARY KEY,
   dname VARCHAR2(14),
   loc VARCHAR2(13)
);

SELECT *
FROM dept_test;

INSERT INTO dept_test  VALUES(99, 'ddit', 'daejeon');
�� ������ ���������� ����

INSERT INTO dept_test VALUES(99, 'ddit2', 'daejeon');
�� ������ ù��° �������� �Է��� �μ���ȣ�� �ߺ� �Ǳ� ������
PRIMARY KEY(UNIQUE) �������ǿ� ����Ǿ� ���������� �����Ͱ� �Էµ��� �ʴ´�,
 ==> �츮�� ������ ������ �÷��� ���Ἲ�� ��������.
 
 DROP TABLE dept_test;

�������� �̸��� ����� ���� �ִ�.
�ش� ������ �������� ��� ��Ģ�� ����� �Ѵ�.
PRIMARY KEY : pk_���̺��
UNIQUE : u_���̺��
FOREIGN KEY : fk_���̺��_�������̺��
NOT NULL, CHECK : ������ �̸��� ������� �ʴ´�.
ex)
CREATE TABLE dept_test(
   deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
   dname VARCHAR2(14),
   loc VARCHAR2(13)
);


2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���
DROP TABLE dept_test;

CREATE TABLE dept_test(
   deptno NUMBER(2) ,
   dname VARCHAR2(14),
   loc VARCHAR2(13),
   
   CONSTRAINT pk_dept_test PRIMARY KEY (dname)
);
dept_test ���̺� deptno, dname ���� PRIMARY KEY ���������� ����
�ΰ� �÷��� ��� ���ƾ����� �ߺ��Ǵ� ������ �ν�

INSERT INTO dept_test VALUES(99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit2', 'daejeon');
 
 select *
 from dept;
