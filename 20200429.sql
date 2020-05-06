OUTER JOIN
���̺� ���� ������ �����ص�, �������� ���� ���̺��� �÷��� ��ȸ�� �ǵ��� �ϴ� ���� ���
<===>
INNER JOIN(�츮�� ���ݱ��� ��� ���)

LEFT OUTER JOIN  : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
RIGHT OUTER JOIN : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
FULL OUTER JOIN  : LEFT OUTER JOIN + RIGHT OUTER JOIN -(�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)

emp���̺��� �÷��� mgr �÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�.
������ KING ������ ��� ����ڰ� ���� ������ �Ϲ����� inner ���� ó���� 
���ο� �����ϱ� ������ KING�� ������ 13���� �����͸� ��ȸ�� ��.

INNER ���� ����
����� ���, ����� �̸�, ���� ���, ���� �̸�
������ �����ؾ߸� �����Ͱ� ��ȸ�ȴ�,
==> KING�� ����� ����(MGR)�� null �̱� ������ ���ο� �����ϰ� king �� ������ ������ �ʴ´�(13��)  
---ORACLE---
SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m, emp e
WHERE m.empno = e.mgr; 

---ANSI----
SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m JOIN emp e ON(m.empno = e.mgr);

���� ������ outer �������� ����
(KING ������ ���ο� �����ص� ���� ������ ���ؼ��� ��������, ������ ����� ������ ���� ������ ������ �ʴ´�)

 ANSI-SQL : OUTER
    SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno);
    
    SELECT m.empno, m.ename, e.empno, e.ename
    FROM emp m RIGHT OUTER JOIN emp e ON(e.mgr = m.empno);
    
    ---�� ������ ������ �����̴�. null �� ǥ���ϱ�����  ���ʰ� �����ʰ����� ������ �־� ǥ���Ѵ�.
    
 ORACLE-SQL : OUTER
 oracle join
 1. FROM ���� ������ ���̺� ���(�޸��� ����)
 2. WHERE ���� ���� ������ ���
 3. ���� �÷�(�����)�� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�.
 ==> ������ ���̺� �ݴ����� ���̺��� �÷�
 
 


--------------------------------------------------
OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ

������ ����� �̸�, ���̵� �����ؼ� ��ȸ
��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�

������ ON���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND e.deptno = 10);

������ WHERE���� ������� ��
SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno )
WHERE  e.deptno = 10;

OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�.

SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
FROM emp e , emp m 
WHERE e.mgr = m.empno(+)AND e.deptno = 10;

-------------------------------------------------------------------
CROSS JOIN
���� ������ ������� ���� ��� ��� ������ ���� �������� ����� ��ȸ�ȴ�.
- ���̺� �����Ѵ� ��캸�� �����亹���� ���

15x3 = 45�� ��� ���� ����Ѵ�.
ex)
SELECT *
FROM product, cycle ,customer
WHERE PRODUCT.PID = CYCLE.PID;

emp 14 *dept 4 = 56��

ANSI-SQL
SELECT *
FROM emp CROSS JOIN dept;

ORACLE(���� ���̺� ����ϰ� where ���� ������ ������� �ʴ´�.)
SELECT *
FROM emp,dept;

cross join �ǽ� 245p
SELECT *
FROM customer, product;

SELECT *
FROM customer CROSS JOIN product;

----------------------------------------------

��������
WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
SELECT *
FROM emp
WHERE 1 = 1 
OR    1 != 1;

���� <==> ����
���������� �ٸ� ���� �ȿ��� �ۼ��� ����
�������� ������ ��ġ
1. SELECT 
    SCALAR SUB QUERY
    ��������
    * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�.
    EX) DUAL���̺�

2. FROM
    INLINE - VIEW
    SELECT ������ ��ȣ�� ���� ��

3. WHERE
    SUB QUERY
    WHERE ���� ���� ����
    
SMITH�� ���� �μ��� ���� �������� ���� ������?

1. SMITH�� ���� �μ��� �������??
2. 1������ �˾Ƴ� �μ���ȣ�� ���Ѵ� ������ ��ȸ


==> �������� 2���� ������ ���� ����
�ι�° ������ ù���� ������ ����� ���� ���� �ٸ��� �������Ѵ�.
(SMITH(20) ==> WARD(30) ==> �ι��� ���� �ۼ��� 10������ 30������ ������ ����
==> ���񺸼��� ���ո�

ù��° ����
SELECT DEPTNO
FROM emp
WHERE ENAME ='SMITH';

�ι�° ����
SELECT *
FROM emp
WHERE deptno = 20;

���������� ���� ��������
SELECT *
FROM emp
WHERE deptno = ( SELECT DEPTNO
                 FROM emp
                WHERE ENAME =:ename);


EX SUB1 252P
SELECT COUNT(*)
FROM EMP
WHERE SAL >
(SELECT ROUND(AVG(sal), 2)
FROM emp);

EX 2 SUB2 253P
SELECT *
FROM EMP
WHERE SAL >
(SELECT ROUND(AVG(sal), 2)
FROM emp);


---����---------

EX) OUTERJOIN 235P

SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
-- ORACLE SQL ���� (+)�� ��� ���ǿ� �ٿ�����Ѵ�.

SELECT  buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM prod LEFT OUTER JOIN buyprod ON(buyprod.buy_prod = prod.prod_id AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

EX OUTERJOIN 2  236P

SELECT  TO_DATE('2005/01/25', 'YYYY/MM/DD'), b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

EX OUTERJOIN 3 237P

SELECT  TO_DATE('2005/01/25', 'YYYY/MM/DD'), b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty,0) BUY_QTY
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');

EX OUTERJOIN  4 238P

SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT
FROM cycle c,product p
WHERE c.PID(+) = P.PID 
AND C.CID(+) = 1;

SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT
FROM product p LEFT OUTER JOIN cycle c ON(c.PID = P.PID AND  C.CID = 1);

EX OUTERJOIN 5 239P
SELECT C.PID, C.PNM, C.CID, CUSTOMER.CNM CNM,C.DAY,C.CNT 
FROM
(SELECT p.PID, p.PNM,NVL(c.CID,1) CID,NVL( c.DAY,0) DAY, NVL(c.CNT, 0) CNT FROM cycle c,product p WHERE c.PID(+) = P.PID AND C.CID(+) = 1) C,CUSTOMER
WHERE C.CID = CUSTOMER.CID
ORDER BY PID DESC ,DAY DESC;






 
    


