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

SELECT m.empno meneger_no, m.ename meneger_name, e.empno emp_no, e.ename emp_name
FROM emp m, emp e
WHERE m.empno = e.mgr; 
