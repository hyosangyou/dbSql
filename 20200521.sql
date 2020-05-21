dt �÷��� ����� ������ �ߺ��� �����ؼ� ��ȸ�Ǵ�

dt �÷����� �����Ͱ� 5/8~ 6/7 �� �ش��ϴ� ����Ʈ Ÿ�� �ڷᰡ ����Ǿ� �ִµ�
5/1 ~ 5/31 �� �ش��ϴ� ��¥(�����) �� �ߺ����� ��ȸ�ϰ� �ʹ�
���ϴ� ��� : 5/8 ~ 5/31 �ִ� 24���� ���� ��ȸ�ϰ� ���� ��Ȳ

SELECT TO_CHAR(dt, 'YYYYMMDD'), COUNT(*)
FROM gis_dt
WHERE dt BETWEEN TO_DATE('20200508', 'YYYYMMDD') AND TO_DATE('20200531 23:59:59', 'YYYYMMDD HH24:MI:SS')
GROUP BY TO_CHAR(dt, 'YYYYMMDD');

1.EXISTS ==>

�츮�� ���ϴ� ���� �ִ� ���� ��� : 24 �� ==>  31���� ���� �ִ� ��
SELECT TO_CHAR(d, 'yyyymmdd')
FROM
(SELECT TO_DATE('20200501', 'YYYYMMDD') + (LEVEL -1) D
FROM dual
CONNECT BY LEVEL <= 31) a
WHERE EXISTS (SELECT 'X'
              FROM gis_dt
              WHERE dT BETWEEN TO_DATE(TO_CHAR(dt, 'YYYYMMDD') || '00:00:00', 'YYYYMMDDHH24:MI:SS') AND
                              TO_DATE(TO_CHAR(dt, 'YYYYMMDD') || '23:59:59', 'YYYYMMDDHH24:MI:SS')) ;

SELECT 
FROM gis_dt
WHERE EXISTS

_________________________________________________________________________________
PL/SQL ==> PL/SQL�� �����ϴ� ���� ����Ŭ ��ü
        �ڵ� ��ü�� ����Ŭ�� ����(����Ŭ ��ü�ϱ�)
        ������ �ٲ� �Ϲ� ���α׷��� ���� ���� �� �ʿ䰡 ����
SQL ==>  SQL ������ �Ϲ� ���� ����(JAVA)
        .���� SQL �� ���õ� ������ �ٲ�� JAVA ������ ������ ���ɼ��� ŭ
        
PL/SQL : Procedual Laguage/ Structured  Query Language
SQL : ������, ������ ���� (�̺��ϰ� ����, CASE, DECOE...)

������ �ϴٺ��� � ���ǿ� ���� ��ȸ�ؾ��� ���̺� ��ü�� �ٲ�ų�, ������ ��ŵ�ϴ� ����
�������� �κ��� �ʿ� �� ���� ����

�������� :�ҵ��� 25% �� �ſ�ī�� + ���ݾ����+ üũī��� �Һ�
 �Һ� �ݾ��� �ҵ��� 25 % �� �ʰ��ϴ� �ݾ׿� ���ؼ�
 �ſ�ī�� ���� : 20 %, ���ݿ������� 30%, üũ ī�� 25%�� �����ϴ� 
 �� ���� �ݾ��� 300������ ���� �� ����
 �� ���߱��뿡 ���� �߰������� 100������ ���� ���� �� �ְ�
 �� ������忡 ���ݿ� ���ؼ��� �߰������� 100������ ���� ���� �� �ִ�.
 
 DBMS �� ���Ͱ��� ������ ������ SQL �� �����ϴµ��� ������ ����(��������)
 �Ϲ����� ���α׷��� ���� ����ϴ� ��������(if, case), �ݺ���(for, while), �������� Ȱ�� �� �� �ִ�  PL/SQL ����
 
 ���� ������
 java = 
 ps/sql :=
 
 java ���� sysout ==> console �� ���
 PL/SQL ���� ����
 SET SERVEROUTPUT ON; �α׸� �ܼ�â�� ��� �����ϰԲ� �ϴ� ����
 
 SET SERVEROUTPUT ON; 
 
 PL/SQL block�� �⺻����
 DECLARE : ����� (���� ���� ����, ��������)
 BEGIN : ����� (������ �����Ǵ� �κ�)
 EXCEPTION : ���ܺ�(���ܰ� �߻� ������ CATCH�Ͽ� �ٸ� ������ �����ϴ� �κ�(JAVA TRY-CATCH))
 
 pl/sql �͸� (�̸��� ����, ��ȸ��) ���
 
 SET SERVEROUTPUT ON; 
 DECLARE 
   /* JAVA : ����TYPE ������
    PL/SQL : ������ ����TYPE;*/
    
   v_deptno NUMBER(2);
   v_dname VARCHAR2(14);
   BEGIN
   /*  dept ���̺��� 10�� �μ��� �ش��ϴ� �μ���ȣ, �μ����� DECLARE ���� ������ �ΰ��� ������ ���*/
     
     SELECT deptno, dname INTO v_deptno, v_dname
     FROM dept
     WHERE deptno = 10;
     
     /*JAVA�� SYSOUT*/
     /*System.out.println (v_deptno +"       "+v_dname);*/
     DBMS_OUTPUT.PUT_LINE(v_deptno || '   '||v_dname);
     
     END;
     /
     
     _________________________________________________________________________________
     ������ Ÿ�� ����
     v_deptno, v_dname �ΰ��� ���� ���� ==> dept ���̺��� �÷� ���� �������� ����
                                      ==> dept ���̺��� �÷� ������ Ÿ�԰� �����ϰ� ���� �ϰ� ���� ��Ȳ
 ������ Ÿ���� ���� �������� �ʰ� ���̺��� �÷� Ÿ���� ���� �ϵ��� ���� �� �� �ִ�.
 ==> ���̺� ������ �ٲ� pl/sql ��Ͽ� ����� ������ Ÿ���� �������� �ʾƵ� �ڵ����� ����ȴ�.
 
 ���̺��.�÷���%TYPE;
 
     
 SET SERVEROUTPUT ON; 
 DECLARE 

   v_deptno dept.deptno%TYPE;
   v_dname dept.dname%TYPE;
   BEGIN
   
     SELECT deptno, dname INTO v_deptno, v_dname
     FROM dept
     WHERE deptno = 10;
     
 
     DBMS_OUTPUT.PUT_LINE(v_deptno || '   '||v_dname);
     
     END;
     /
     
     ��¥�� �Է¹޾� ==> ��ȸ���� �����ϱ������� 5�ϵ��� ��¥�� �����ϴ� �Լ�
     ȸ�縸�� Ư���� ������ �ʿ��� ��� �Լ��� ���� �� �ִ�.   
     
     PROCEDURE : �̸��� �ִ� PL/SQL ���, ���ϰ��� ����
                 ������ ���� ó�� �� �����͸� �ٸ� ���̺� �Է��ϴ� ����
                 ����Ͻ� ������ ó�� �� �� ���
                 ����Ŭ ��ü ==> ����Ŭ ������ ������ �ȴ�.
                 ������ �ִ� ������� ���ν��� �̸��� ���� ������ ����
                  
CREATE  OR REPLACE PROCEDURE printdept () IS
--�����
   v_deptno dept.deptno%TYPE;
   v_dname dept.dname%TYPE;
BEGIN
   
     SELECT deptno, dname INTO v_deptno, v_dname
     FROM dept
     WHERE deptno = 10;
     
 
     DBMS_OUTPUT.PUT_LINE(v_deptno || '   '||v_dname);
     
     END;
     /
     
���ν��� ���� ��� : EXEC ���ν����̸�;
EXEC printdept;
__________________________________________________________
�����ϱ�

CREATE  OR REPLACE PROCEDURE printdept (p_deptno IN dept.deptno%TYPE) IS
--�����
   v_deptno dept.deptno%TYPE;
   v_dname dept.dname%TYPE;
BEGIN
   
     SELECT deptno, dname INTO v_deptno, v_dname
     FROM dept
     WHERE deptno = p_deptno;
     
 
     DBMS_OUTPUT.PUT_LINE(v_deptno || '   '||v_dname);
     
     END;
     /

���ڰ� �ִ� printdept ����
EXEC printdept(50);

PL/SQL ������ SELECT ������ ���� ���� �� �����Ͱ� �Ѱ� �ȳ��ð�� NO_DATA_FOUND ���ܸ� ������.
__________________________________________________________________________________________
PRO_1_EX_17P
CREATE  OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS
--�����
   v_ename emp.ename%TYPE;
   v_dname dept.dname%TYPE;
BEGIN
   
     SELECT ename, dname INTO v_ename, v_dname
     FROM emp,dept
     WHERE emp.deptno = dept.deptno 
     AND emp.empno = p_empno;
     
     DBMS_OUTPUT.PUT_LINE(v_ename || '   '||v_dname);
     
     END;
     /      
     
     EXEC printemp(7369);

__________________________________________________________________________________________
PRO_2_EX_18P

CREATE OR REPLACE PROCEDURE pdept_test (p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE, p_loc IN dept_test.loc%TYPE ) IS
--�����

BEGIN
   
    INSERT INTO dept_test VALUES (p_deptno, p_dname, p_loc); 
    
     
     END;
     /      
     
     EXEC pdept_test(99, 'ddit', 'daejeon');
     
     SELECT *
     FROM dept_test;
     
__________________________________________________________________________________________
PRO_3_EX_19P


CREATE OR REPLACE PROCEDURE UPDATEdept_test(p_deptno IN dept_test.deptno%TYPE, p_dname IN dept_test.dname%TYPE, p_loc IN dept_test.loc%TYPE ) IS
--�����

BEGIN
   
    UPDATE dept_test SET deptno = p_deptno, dname = p_dname, loc = p_loc; 
    
     
     END;
     /      
     
     EXEC UPDATEdept_test(99, 'ddit_m', 'daejeon');
     
     SELECT *
     FROM dept_test;
    
_____________________________________________________________________________________________

���պ���
��ȸ����� �÷��� �ϳ��� ������ ��� �۾� ���ŷӴ� ==> ���� ������ ����Ͽ� �������� �ؼ�

1.%ROWTYPE : Ư�� ���̺��� ���� ��� �÷��� ������ �� �ִ� ���� ���� Ÿ��
(���� %TYPE - Ư�� ���̺��� �÷� Ÿ���� ����)
2. PL/SQL RECORD : ���� ������ �� �ִ� Ÿ��, �÷��� �����ڰ� ���� ���
                   ���̺��� ��� �÷��� ����ϴ°� �ƴ϶� �÷� �� �Ϻθ� ����ϰ� ���� ��
3. PL/SQL TABLE TYPE : �������� ��, �÷��� ������ �� �ִ� Ÿ��

%ROWTYPE 
�͸� ������ dept ���̺��� 10�� �μ������� ��ȸ�Ͽ� %ROWTYPE���� ������ ������ �������
�����ϰ� DBMS_OUTPUT.PUT_LINE �� �̿��Ͽ� ���


DECLARE
     v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno =10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.deptno || ' / ' || v_dept_row.loc);
END;
/

2. record : ���� �����Ҽ� �ִ� ����Ÿ��, �÷� ������ �����ڰ� ���� ������ �� �ִ�.
dept ���̺��� deptno, dname �ΰ� �÷��� ������� �����ϰ� ���� ��

DECLARE
-- deptno, dname �÷� �ΰ��� ���� ������ �� �ִ� TYPE�� ����
    TYPE dept_rec IS RECORD(
       deptno dept.deptno%TYPE,
       dname dept.dname%TYPE);
       
    --   ���Ӱ� ���� Ÿ������ ������ ���� (class ����� �ν��Ͻ� ����)
       v_dept_rec dept_rec;
BEGIN
    SELECT deptno, dname INTO v_dept_rec
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_rec.deptno || ' / ' || v_dept_rec.dname);

END;
/

____________________________________________________________________________________
�������� ������ �� ��
SELECT ����� �������̱� ������ �ϳ��� �� ������ ���� �� �ִ� ROWTYPE �������� ���� ���� ���� ���� ���� �߻�
==> ���� ���� ������ �� �ִ� TABLE TYPE ���

DECLARE
     v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' / ' || v_dept_row.deptno || ' / ' || v_dept_row.loc);
END;
/

TABLE TYPE : �������� ������ �� �ִ� Ÿ��
���� : TYPE Ÿ�Ը� IS TABLE OF �� Ÿ�� INDEX BY �ε����� Ÿ��;

dept ���̺��� �� ������ ������ �� �ִ� ���� TYPE 
   List<dept> dept_tab = new ArrayList<Dept>();
   
   java���� �迭 �ε���
   int[] intArray = new int [50];
   intArray[0]
   java������ �ε����� �翬�� ����
   
   intArray["ù��°"] = 50;
   System.out.println(intArray["ù����"]);
   
   MAP<Stirng, Dept> deptMap = new HashMap<String, Dept>();
   deptMap.put("ù��°",new Dept());
   
   
   
   PL/SQL ������ �ΰ��� Ÿ���� ���� : ���� (BINARY_INTEGER, ���ڿ�(VARCHAR(2)))
   TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER
                   
DECLARE
 TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
 v_dept dept_tab;
BEGIN
  SELECT * BULK COLLECT INTO v_dept
  FROM dept;
END;
/


     
 