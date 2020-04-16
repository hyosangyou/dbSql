
��� ������ prod ���̺��� ��ȸ;

SELECT *       -- ����÷��� ������ ��ȸ
FROM prod;     -- prod ���̺��� �����͸� ��ȸ


Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2 ...
prod_id, prod_name �÷���  prod ���̺��� ��ȸ;

SELECT prod_id, prod_name 
FROM prod;

--select 1
lprod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM lprod;

buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT buyer_id, buyer_name
FROM buyer;

cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���
SELECT *
FROM cart;

member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ�ϴ� ������ �ۼ��ϼ���.
SELECT  mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� X, �Ϲ��� ��Ģ���� 
INT b = 2;  = ���� ������, == �� ������;

SQL ������ Ÿ�� : ����,  ����, ��¥(date);

USERS ���̺��� (4/14 ����� ����) ����
USERS ���̺��� ��� ����Ʈ�� ��ȸ;


��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���갡��
 date type + ���� : date���� ���� ��¥ ��ŭ �̷� ��¥�� �̵�
 date type - ���� : date���� ���� ��¥ ��ŭ ���� ��¥�� �̵�
 
SELECT userid, reg_dt, reg_dt + 5 after_5days, reg_dt - 5
FROM users;

�÷� ��Ī : ���� �÷����� �����ϰ� ���� ��
syntax : ���� �÷��� [as]  ��Ī ��Ī
as�� ���������ϴ� 
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�.
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
���� �����̼��� ����Ѵ�.

SELECT userid as id, userid id2, userid ���̵�
FROM users;

--select2

prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
(�� prod_id -> id, prod_name -> name ���� �÷� ��Ī�� ����)

SELECT prod_id id, prod_name name 
FROM prod;

lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
(�� lprod_gu -> gu, lprod_nm -> nm ���� �÷� ��Ī�� ����)

SELECT lprod_gu gu, lprod_nm nm
FROM lprod;

buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
(�� buyer_id -> ���̾���̵� , byer_name ->�̸� ���� �÷� ��Ī�� ����)

SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;

���ڿ� ����(���տ���) : || (���ڿ� ������ + �����ڰ� �ƴϴ�)
�ڹٿ����� ""  SQL������ ''
SELECT userid || 'test' , reg_dt + 5  , 'test', 15
FROM users;

�� �̸� ��
SELECT '�� ' || userid || ' ��'
FROM users;


���ڿ� ���� : uesrid �� usernm�� ��ģ��.
SELECT userid, usernm, userid || usernm 
FROM users;

SELECT userid || usernm AS id_name,
      CONCAT(userid, usernm) AS  concat_id_name
FROM users;

sel_co1
user_tables : oracle ���� �����ϴ� ���̺� ������ ��� �ִ� ���̺�(View) ==> data dictionary    

���ڿ� ���� ���ڿ� ���� ���ڿ�
SELECT ' SELECT * FROM ' || table_name || ';' QUERY
FROM user_tables;

���̺��� ���� Į���� Ȯ�� 
1. tool(sql developer)�� ���� Ȯ��
   ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2. SELECT * 
   FROM ���̺�    
   �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
   
3. DESC ���̺��

DESC emp;

4. data dictionary

SELECT * 
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT 
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

sql�� �� ���� : =

SELECT *
FROM users
WHERE userid= 'cony';

SELECT *
FROM users
WHERE userid = userid;
where���� �׻� �÷����� ���ʿ�� ����. ���� ���  �����Ͱ� ���

emp ���̺��� �÷��� ������ Ÿ���� Ȯ�� 
DESC emp;

SELECT *
FROM emp;

emp ���̺��� ������ ���� �μ���ȣ�� 30���� ���ų� ū �μ��� ���� ������ ��ȸ;
SELECT ename
FROM emp
WHERE deptno >= 30;

!= �ٸ���
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ
SELECT *
FROM users
WHERE userid != 'brown';

SQL ���ͷ�
���� : 20, 30.5  ���� ���ڸ� ����
���� : 'hello world' ��������ǥ �ȿ� ����
��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����')

1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
������ �Ի����� : hiredate �÷�

SELECT *
FROM emp
where hiredate <= TO_DATE('1982/01/01', 'YYYY/MM/DD');


 
/*
EMP ���̺� �Ӽ� ����
EMPNO : �����ȣ
ENAME : ����̸�
JOB   : ��å
MGR   : ��� ������
HIREDATE : �Ի�����
SAL : �޿�
COMM : ������
DEPTINO : �μ���ȣ
*/








