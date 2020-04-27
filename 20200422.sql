SELECT '201912' PARAM , 
TO_CHAR(LAST_DAY(TO_DATE('201912', 'YYYYMM')), 'DD')DT,
TO_CHAR(LAST_DAY(TO_DATE('201911', 'YYYYMM')), 'DD')DT1,
TO_CHAR(LAST_DAY(TO_DATE('201602', 'YYYYMM')), 'DD')DT2
FROM dual;

--������ ������� �ϳ���
SELECT TO_DATE(:yyyymm, 'YYYYMM').
       LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),
       TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),'DD')
FROM dual;



-------------------------------------------------------------------------------------------------

EXPLAIN PLAN FOR
SELECT *
FROM emp 
WHERE empno ='7369';
-->��� ����Ǿ����ϴ�. ������´�

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
--> �м��� ������ ����Ѵ�. 


--��¹�--
Plan hash value: 3956160932
* �鿩���� �Ǿ������� �ڽ� ���۷��̼�
1. ������ �Ʒ���
  *�� �ڽ� ���۷��̼��� ������ �ڽ� ���� �д´�.
 1==> 0      1���� �ڽ� ���۷��̼��̱⶧���� 1�����д´�.
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)  -- ����ȯ�� �ڵ����� �Ͽ���.
   
   
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY)
-����� -

Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter(TO_CHAR("EMPNO")='7369')  -- ����࿡ ���Ͽ� TO_CHAR �� ����Ǿ���. �߸��� ���
   
EXPLAIN PLAN FOR 
SELECT *
FROM emp 
WHERE empno =7300 + '69';

SELECT *
FROM TABLE(dbms_xplan.display);

-- ��¹� --
Plan hash value: 3956160932
 
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)  --> �ڵ����� ���ڿ� 69 �� ���ڷ� ����ȯ �Ͽ���.
   
   
   
   
   ----------------------------------------------------------------------------------------------
   --���������� ���������� ����ȯ--
   
    --Ȱ�뵵�� ����-
 SELECT ename, sal, TO_CHAR(sal, 'L009,999.00') TOTAL
 FROM emp;
 
 NULL�� ���õ� �Լ�
 �� NVL           
 NVL2
 NULLIF
 COALESCE;
 
 �� null ó���� �ؾ��ұ�?
 NULL�� ���� �������� NULL�̴�
 
 ������ emp ���̺� �����Ѵ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �;
 ������ ���� SQL�� �ۼ�.
 
 SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
 FROM emp; 
 
 NVL(expr1, expr2)
 expr1 �� NULL �̸� expr2 ���� �����ϰ�
 expr1 �� NULL �� �ƴϸ� expr1 �� ����
 
 SELECT empno, ename, sal ,comm, sal + NVL(comm, 0) sal_plus_comm
 FROM emp;
 => ��� ���� ������ �ٸ��� NULL ���� �����ϰ� ����Ͽ���.
 
 REG_DT �÷��� NULL �� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
 SELECT userid, usernm, NVL(REG_DT, LAST_DAY(SYSDATE))
 FROM users;
 
 
 
   
   
   
   
   
   
   
   
   