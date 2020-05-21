'202005' ==> �Ϲ����� �޷��� row, col;
�μ���ȣ��, ��ü �� �� SAL ���� ���ϴ�

ù��°��� 
union all

2��°���
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

JOIN ������ ��
CROSS JOIN : ������ ���� �� ��....

3��° ���
SELECT DECODE(lv, 1, deptno, 2, null) deptno, sum(sal) sal
FROM emp, (SELECT  LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2) 
GROUP BY DECODE(lv, 1, deptno, 2, null)
ORDER BY 1;

__________________________________________________________________________________
������ ����
START WITH : ���� ������ ������ ���
CONNECT BY : ���� (��)�� ������� ǥ��

XXȸ�����(�ֻ��� ���)���� ���� ��������� ���������� Ž���Ѵ� ����Ŭ ������ ���� �ۼ�
1. �������� ���� : xx ȸ��

SELECT *
FROM dept_h
START WITH deptcd = 'dept0';

2. ������(��� ��) ����� ǥ��
   PRIOR : ���� ���� �а� �ִ� ���� ǥ��
   �ƹ��͵� ������ ���� : ���� ������ ���� ǥ��
   ���� �������ٸ��� 
   
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
=>
SELECT dept_h.*, LEVEL
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;
=>
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

 
 h_2 ���� 75p
SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

����� 
������ : ��������
CONNECT BY ���Ŀ� �̾ PRIOR�� ���� �ʾƵ� ��� ����
PRIOR�� ���� �ϰ� �ִ� ���� ��Ī�ϴ� Ű����

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h-3 ���� 80 p
SELECT deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_4 ���� 81p
SELECT LPAD(' ', (LEVEL-1)*3) || s_id s_id, value
FROM h_sum
START WITH s_id= '0'
CONNECT BY PRIOR s_id = ps_id;

SELECT *
FROM h_sum

h_5 ���� 82p
SELECT LPAD(' ', (LEVEL-1)*7) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd= 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--------------------------------------------------------------------------
Pruning branch : ���� ġ��
WHERE���� ������ ��� ���� �� : ������ ������ ���� �� ���� �������� ����ȴ�.
CONNECT BY ���� ��� ���� �� : �����߿� ������ ����
�� ���̸� ��

*�� ������ ��������  FROM -> START WITH CONNECT BY -> WHERE�� ������ ó���ȴ�.

1. WHERE���� ������ ����� ��� 

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

��� : ��ȹ���� �����κ� ���� �μ�ó�� ����ȴ�.

2. CONNECY BY ���� ������ ����� ���

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';

��� : ���α�ȹ�� ���� �μ��鵵 �� ���ŵȴ�.(����ġ��)!!!!!!!

__________________________________________________________________________________________

������ �������� ����� �� �ִ� Ư�� �Լ�
CONNECT_BY_ROOT(column) : �ش� �÷��� �ֻ��� �����͸� ��ȸ
SYS_CONNECT_BY_PATH(column, ������) : �ش� ���� ������� ���Ŀ� ���� column���� ǥ���ϰ� �����ڸ� ���� ����
                                    LTRIM(SYS_CONNECT_BY_PATH(column, ������), ������) ���·� ���� ���δ�. ���� ���� ������ ����
CONNECT_BY_ISLEAF ���ڰ� ���� : �ش� ���� ������  �� �̻� ���� ������ �������(LEAF ���)
                                LEAF ��� : 1, NO LEAF ��� : 0

SELECT LEVEL lv, deptcd, LPAD(' ', (LEVEL-1)*5) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm),
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-'),
       CONNECT_BY_ISLEA
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd ;


_______________________________________________________________
h6_���� 88p
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR Seq = parent_Seq ;


h7_���� 89p 
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER BY SEQ DESC;

___________________________________________________________
ORDER SIBLINGS BY
������ ������ ���Ľ� ���� ������ �����ϸ鼭 ���� �ϴ� ����� ����
___________________________________________________________

h8_���� 90p
SELECT SEQ,  LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER SIBLINGS BY SEQ DESC;

h9_����96p

ALTER TABLE board_test ADD (gp_no NUMBER);

UPDATE board_test SET gp_no = 4
WHERE seq IN (4, 10, 11, 5, 8, 6, 7);

UPDATE board_test SET gp_no = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gp_no = 1
WHERE seq IN (1, 9);

COMMIT;

SELECT *
FROM board_test;


SELECT gp_no, CONNECT_BY_ROOT(seq), SEQ, LPAD(' ', (LEVEL-1)*5) || TITLE TITLE
FROM board_test
START WITH parent_seq IS NULL 
CONNECT BY PRIOR Seq = parent_Seq 
ORDER  BY  CONNECT_BY_ROOT(seq) desc,seq asc;


___________________________________________________________________________
��ü �����߿� ���� ���� �޿��� �޴� ����� �޿� ����

emp ���̺��� 2�� �о ������ �޼� ==> ���ݴ� ȿ������ ����� ������?? ==> WINDOW / ANALYSIS function
SELECT ename
FROM emp
WHERE SAL =(SELECT MAX(sal)
            FROM emp);
            
    
    
ana_ex 100p

SELECT O.ENAME ENAME, O.sal SAL, O.deptno deptno, O.rn SAL_RANK
FROM
(SELECT a.*, b.lv
FROM
(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno )a, (SELECT  LEVEL lv
                     FROM dual
                     CONNECT BY LEVEL <= 6) b
WHERE a.cnt >= lv
ORDER BY a.deptno, b.lv) q, (SELECT ROWNUM rn, c.*
                             FROM
                            (SELECT ename, sal, deptno 
                             FROM emp
                             ORDER BY deptno) c) o
WHERE Q.lv = o.rn






