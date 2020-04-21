--PROD ���̺���  PROD_LGU (��������), PROD_COST(��������)���� �����Ͽ� ����¡ ó�� ������ �ۼ� �ϼ���
--�� ������ ������� 5
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod 
ORDER BY PROD_LGU , PROD_COST ASC)a)
WHERE rn BETWEEN 1 + (:page-1)*:pageSize AND (:page*:pageSize);

�����ð� --
����¡ó�� 
 . ROWNUM
 . INLINE-VIEW(����Ŭ ����)
 . ����¡ ����
 . ���ε� ����

�Լ� : ������ ���ȭ �� �ڵ�
==> ���� ��� (ȣ��)�ϴ� ���� �Լ��� �����Ǿ��ִ� �κ��� �и� ==> ���������� ���̼��� ���� 
�Լ��� ������� �ʴ°��
 ȣ���ϴ� �κп� �Լ� �ڵ带 ���� ����ؾ� �ϹǷ�, �ڵ尡 ������� ==> �������� ��������.
 
 ����Ŭ �Լ��� ����
 �Է� ���� :
   . single row function
   . multi row function
   
 ������ ���� :
 . ���� �Լ� : ����Ŭ���� �������ִ� �Լ�
 . ����� ���� �Լ� : �����ڰ� ���� ������ �Լ�(pl/sql ��ﶧ)
 
 ���α׷��־��, �ĺ��̸� �ο�, ... ==>�߿��� ��Ģ
 
 
 DUAL TABLE 
 SYS ������ ���� �ִ� ���̺�
 ����Ŭ�� ��� ����ڰ� �������� ����� �� �ִ� ���̺�
 
 �Ѱ��� ��, �ϳ��� �÷�(dummy) - ���� 'X';
 ��� �뵵
 1. �Լ��� �׽�Ʈ�� ����
 2. merge ����
 3. ������ ����
 ---------------------------------------------------------------------
 ����Ŭ ���� �Լ� �׽�Ʈ(��ҹ��� ����)
 LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�;
 
 ex)()�� �ҹ��ڷ� �ٲ��   -> ��� hello, world
 SELECT LOWER('Hello, World')
 FROM dual;
 ex ()�� �빮�ڷ� �ٲ��  -> HELLO, WORLD
  SELECT UPPER('Hello, World')
  FROM dual;
 ex () ù���ڸ� �빮�ڷ� -> Hello, World
   SELECT INITCAP('Hello, World')
  FROM dual;
  
  //������� �ٳ��´�.
  SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
  FROM emp;
  
  �Լ��� where�������� ����� �����ϴ�.
  emp ���̺��� SMITH ����� �̸��� �빮�ڷ� ����Ǿ� ����
  
  SELECT *
  FROM  emp
  WHERE LOWER(ename) ='smith'; �̷������� �ۼ��ϸ� �ȵȴ�.    -�ళ����ŭ
  WHERE enmae =UPPER('smith'); �ΰ��� ����߿��� �������ٴ� �Ʒ���� �ùٸ� ����̴�.
  
  WHERE enmae = 'smith'; ���̺��� ������ ���� �빮�ڷ� ����Ǿ������Ƿ� ��ȸ�Ǽ� 0
  WHERE ename = 'smith'; ���� ����
  
  ���ڿ� ���� �Լ�
  CONCAT( 2���� ���ڿ��� �Է����� �޾�, ������ ���ڿ��� ��ȯ�Ѵ�.
  CONCAT('start', 'end')
  FROM dual;
  
    CONCAT �Լ��� �ۼ��ϱ� (�� || �� ������� �ʴ´�)
      'SELECT * FROM' || table_name || ';'   ====   CONCAT('SELECT * FROM' ,CONCAT(table_name, ';'))
      
      
  SELECT table_name, tablespace_name, CONCAT('start', 'end'),
       CONCAT(table_name, tablespace_name), 
       'SELECT * FROM' || table_name || ';',
       CONCAT('SELECT * FROM' ,CONCAT(table_name, ';'))
  FROM user_tables;
  
  �κй��ڿ�
  SUBSTR(���ڿ�, ���� �ε��� , ���� �ε���) : ���ڿ��� �����ε������� ���� �ε������� ���  
 �����ε����� 1����(Java�� ���� 0����)
 -- 1���� 6�ڸ����� ��� Hello,             
 -- �˸��ƽ�(��Ī)�� ���ָ� �żҵ� ��ü�� ���´�.
  SELECT SUBSTR('Hello, World',1,6)  sub
  FROM dual
  
  ���ڿ� 
  LENGTH(���ڿ�) : ���ڿ��� ���̸� ��ȯ
  SELECT LENGTH('Hello, World') len 
  FROM dual
  
  INSTR(���ڿ�, ã�� ���ڿ�, [�˻� ���� �ε���]) : ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ��� ã�� ���ڿ��� �ε���(��ġ) ��ȯ
  ('Hello, World', 'o', 6) : Hello, World ���� o ��ã�µ� 6�� 6�� �ڸ������� ã������Ѵ��ǹ� 
  106, 107 ��°�� �����ǹ�
  SELECT INSTR('Hello, World', 'o') ins,
  INSTR('Hello, World', 'o',6) ins1,
  INSTR('Hello, World', 'o', INSTR('Hello, World', 'o')+1) ins2   
  FROM dual
  
  LPAD, RPAD(���ڿ�, ���߰� ���� ��ü ���ڿ� ����, [�е� ���ڿ� - �⺻ ���� ����])
  SELECT LPAD('hello', 15, '*') lp ,
  RPAD('hello', 15, '*') rp ,
  LPAD('hello', 15) lp1 ,
  RPAD('hello', 15) rp1 
  FROM dual
  
  REPLACE(���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�) : ���ڿ����� �˻��� ���ڿ� ã�� ������ ���ڿ� ����� ����
  SELECT REPLACE('Hello, World', 'll', 'LL') re
  FROM dual
  
  TRIM(���ڿ�) : ���ڿ��� �� ���� �����Ѵ� ������ ����, ���ڿ� �߰��� �ִ� ������ ���� ����� �ƴ�
  tr1 :H�� �����Ѵ�. ���ڿ� �յ� Ư����������
  SELECT TRIM('  Hel lo    ') tr ,
  TRIM('H' FROM 'Hello')tr1
  FROM dual
  
  NUMBER ���� �Լ�
  ROUND(����, [�ݿø� ��ġ default :0]) : �ݿø�
   ROUND(105.54 ,1) : �Ҽ��� ù��° �ڸ����� ����� ���� ==> �Ҽ��� �ι�° �ڸ����� �ݿø� : 105.5 
   
  SELECT ROUND(105.54, 1) round,      
         ROUND(105.55, 1) round2, 
         ROUND(105.55, 0) round3,
         ROUND(105.55, -1) round4
  FROM dual;
  ����� : 105.5  , 105.6 , 106  , 110

  TRUNC(����, [���� ��ġ- default :0]) : ����
     
  SELECT TRUNC(105.54, 1) trunk,      
         TRUNC(105.55, 1) trunk2, 
         TRUNC(105.55, 0) trunk3,
         TRUNC(105.55, -1) trunk4
  FROM dual;

  MOD(������, ����) : ����������
  
  SELECT MOD(10,3)
  FROM dual;
  
  SELECT MOD(10, 3 ), sal, MOD(sal, 1000)
  FROM emp;
  
  
  ��¥ ���� �Լ�
  SYSDATE : ������� ����Ŭ �����ͺ��̽� ������ ���� �ð�, ��¥�� ��ȯ�Ѵ�.
            �Լ������� ���ڰ� ���� �Լ� (���ڰ� ������� JAVA : �޼ҵ�()/ SQL : �Լ���);
  
  date type +- ���� : ���� ���ϱ� ����
  ���� 1 = �Ϸ�
  1/24 = �ѽð�
  1//24/60 = �Ϻ�
  
  SELECT SYSDATE, SYSDATE +5 
  FROM dual;
  
  EX)
  SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') LASTDAY,
  TO_DATE('2019/12/31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5,
  SYSDATE NOW,
  SYSDATE -3 NOW_BEFORE3
  FROM dual;
  
  
  TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
  TO_CHAR(��¥, ����) : ��¥Ÿ���� ���˿� �°� ���ڿ��� ��ȯ
  YYYY : �⵵
  MM   : ��
  DD   : ����
  D    : �ְ�����(1~7, 1 - �Ͽ��� , 2 - ������ .... 7 - �����)
  IW   : ���� (52~53)
  HH   : �ð�(12�ð�)
  HH24 : 24�ð� ǥ��
  MI   : ��
  SS   : ��
  
  ����ð�(SYSDATE) �ú��� �������� ǥ�� ==> TO_CHAR�� �̿��Ͽ� ����ȯ
  SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
         TO_CHAR(SYSDATE, 'D') d,
         TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
         TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour 
         
  FROM dual;
  
  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
         TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
         TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
         
  FROM dual;
  
  MONTHS_BETWEEN(DATE1, DATE2): DATE1�� DATE2 ������ �������� ��ȯ
  4���� ��¥ �����Լ��߿� ��� �󵵰� ����
  SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21' , 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
         MONTHS_BETWEEN(TO_DATE('2020/04/22' , 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
  FROM dual;
  
  ADD_MONTHS(DATE, ������ ������) : DATE�� ���� �ι�° �Էµ� ������ ��ŭ ������ DATE
  ���� ��¥�κ��� 5���� �� ��¥
  SELECT ADD_MONTHS(SYSDATE,5) dt1,
         ADD_MONTHS(SYSDATE,-5) dt2
  FROM dual;
  
  NEXT_DAY(date, �ְ�����) : DATE���� �����Ѵ� ù���� �ְ������� ��¥�� ��ȯ
  SELECT NEXT_DAY(SYSDATE, 7) 
  FROM dual;
  
  LAST_DAY(DATE) : DATE�� ���� ���� ������ ��¥�� ��ȯ
  SYSDATE : 2020/04/21 ==> 2020/04/30
  SELECT LAST_DAY(SYSDATE)
  FROM dual;
  
  ��¥�� ���� ���� ù��° ��¥ ���ϱ�(1��)
  SYSDATE : 2020/04/21 ==> 2020/04/01;
  
  SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE)+1,
         ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
         TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
  FROM dual;
  
  
  ����--------------------------------------
  
  ���ͷ� 
  ���� : ...
  ���� : ''
  ��¥ : TO_DATE('��¥���ڿ�','YYYUMMDD(����)') 
  
  
  
       
 
 
 
