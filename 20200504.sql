SQL ������
= : �÷�|ǥ���� = �� ==> ���� ������
  = 1
IN : �÷�|ǥ���� IN (����)
 deptno IN (10, 30) ==> IN(10, 30), deptno (10,30)
 
 EXISTS ������
 ����� : EXISTS (��������)
 ���������� ��ȸ����� �Ѱ��̶� ������ TRUE 
 �߸��� ����� : WHERE deptno EXISTS (��������)
 
 ���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
 emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�.
 
 �Ʒ� ������ ���ȣ ��������
 �Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���
 
 EXISTS �������� ����
 �����ϴ� ���� �ϳ��� �߰��� �ϸ� �� �̻� Ž���� ���� �ʰ� �ߴ�.  
 ���� ���� ���ο� ������ ���� �� ���
 ex)
 SELECT *
 FROM emp
 WHERE EXISTS (SELECT 'X'
               FROM dept);
               
�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14 - KING =13 ���� ����
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
IS NOT NULL �� ���ؼ��� ������ ����� ����� �� �� �ִ�.
SELECT *
FROM emp
WHERE mgr IS NO NULL;

join 
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;

ex )sub9 274
SELECT *
FROM product 
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid =1
              AND cycle.pid = product.pid);
             

ex ) sub 10 275
SELECT *
FROM product 
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid =1
              AND cycle.pid = product.pid);
              


���տ���
{1, 5 , 3} U {2, 3}={1, 2, 3, 5}

SQL���� �����ϴ�  UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�.
{1, 5 , 3} U {2, 3}={1, 2, 3, 2, 5}

������
{1 , 5, 3} ������ {2, 3}  = {3}

������
{1 , 5, 3} -{2, 3}  = {1, 5}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL �� �������� ������ Ȯ�� (��, �Ʒ��� ���յȴ�)/

UNION ������ : �ߺ����� (������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)



UNION ALL ������ : �ߺ����

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)



INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)


MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

SQL ���տ������� Ư¡
���� �̸� : ù�� SQL�� �÷��� ���󰣴�;

SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)

UNION

SELECT ename , empno
FROM emp
WHERE empno IN(7698);

2.������ �ϰ���� ��� �������� ���� ����
 ���� SQL���� ORDER BY �Ұ� (�ζ��κ� �� ����Ͽ� ������������ ORDER BY �� ������� ������ ����)


SELECT ename nm, empno no
FROM emp
WHERE empno IN(7369)
--ORDER BY nm ,�߰� ������ ���� �Ұ�
UNION

SELECT ename , empno
FROM emp
WHERE empno IN(7698)
ORDER BY nm;

3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ� (������ ���� ����� ����), �� UNION ALL�� �ߺ� ���

4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
  ==> ����ڿ��� ����� �����ִ� �������� ������
   ==> UNION ALL �� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡��
       �����ϴ�.
�˰��� (���� - ���� ����, ���� ����,....
            �ڷ� ���� : Ʈ������ (���� Ʈ��, �뷱�� Ʈ��)
                       heap, stack, queue, list)
  ���տ��꿡�� �߿��� ���� : �ߺ�����    
  ���� ����
  

���ù��� ����;


SELECT *
FROM FASTFOOD;

SELECT ROWNUM rn, E.*
FROM
(SELECT L.SIDO �õ�, L.SIGUNGU �ñ���, (M.�Ƶ�����+K.KFC+B.����ŷ)/L.�Ե����� ���ù�������
FROM
(SELECT SIDO, SIGUNGU,GB, COUNT(*) �Ե�����
 FROM FASTFOOD B
 WHERE GB = '�Ե�����'
 GROUP BY SIDO,SIGUNGU,GB) L ,(SELECT SIDO,SIGUNGU, GB, COUNT(*) KFC
                               FROM FASTFOOD
                               WHERE GB = 'KFC'
                               GROUP BY SIDO,SIGUNGU,GB) K, (SELECT SIDO,SIGUNGU, GB, COUNT(*) ����ŷ
                                                             FROM FASTFOOD
                                                             WHERE GB = '����ŷ'
                                                             GROUP BY SIDO,SIGUNGU,GB) B,(SELECT SIDO,SIGUNGU, GB, COUNT(*) �Ƶ�����
                                                                                          FROM FASTFOOD
                                                                                          WHERE GB = '�Ƶ�����'
                                                                                          GROUP BY SIDO,SIGUNGU,GB) M
WHERE L.SIGUNGU = M.SIGUNGU 
AND L.SIGUNGU= K.SIGUNGU
AND L.SIGUNGU= B.SIGUNGU
AND L.SIDO =M.SIDO
AND L.SIDO =K.SIDO
AND L.SIDO =B.SIDO
ORDER BY ���ù������� DESC) E;


SELECT *
from tax
���� 1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� sql �ۼ�
1.���ù��������� ���ϰ�
2.�δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� sql �ۼ�
����,�ܹ��� SIDO,�ܹ��� SIGUNGU, �ܹ��� ���ù�������,����û, sido ����û sigungu, ����û �������� �ݾ� 1�δ� �Ű��

���� 2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�����)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fast food ���̺��� 1���� ���)
hint case, decode




                      
















