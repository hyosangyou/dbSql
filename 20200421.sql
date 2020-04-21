--PROD 테이블을  PROD_LGU (내림차순), PROD_COST(오름차순)으로 정렬하여 페이징 처리 쿼리를 작성 하세요
--단 페이지 사이즈는 5
SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod 
ORDER BY PROD_LGU , PROD_COST ASC)a)
WHERE rn BETWEEN 1 + (:page-1)*:pageSize AND (:page*:pageSize);

지난시간 --
페이징처리 
 . ROWNUM
 . INLINE-VIEW(오라클 한정)
 . 페이징 공식
 . 바인드 변수

함수 : 로직을 모듈화 한 코드
==> 실제 사용 (호출)하는 곳과 함수가 구현되어있는 부분을 분리 ==> 유지보수의 편이성을 도모 
함수를 사용하지 않는경우
 호출하는 부분에 함수 코드를 직접 기술해야 하므로, 코드가 길어진다 ==> 가독성이 나빠진다.
 
 오라클 함수를 구분
 입력 구분 :
   . single row function
   . multi row function
   
 제작자 구분 :
 . 내장 함수 : 오라클에서 제공해주는 함수
 . 사용자 정의 함수 : 개발자가 직접 정의한 함수(pl/sql 배울때)
 
 프로그래밍언어, 식별이름 부여, ... ==>중요한 원칙
 
 
 DUAL TABLE 
 SYS 계정에 속해 있는 테이블
 오라클의 모든 사용자가 공통으로 사욜할 수 있는 테이블
 
 한개의 행, 하나의 컬럼(dummy) - 값은 'X';
 사용 용도
 1. 함수를 테스트할 목적
 2. merge 구문
 3. 데이터 복제
 ---------------------------------------------------------------------
 오라클 내장 함수 테스트(대소문자 관련)
 LOWER, UPPER, INITCAP : 인자로 문자열 하나를 받는다;
 
 ex)()를 소문자로 바꿔라   -> 결과 hello, world
 SELECT LOWER('Hello, World')
 FROM dual;
 ex ()를 대문자로 바꿔라  -> HELLO, WORLD
  SELECT UPPER('Hello, World')
  FROM dual;
 ex () 첫글자를 대문자로 -> Hello, World
   SELECT INITCAP('Hello, World')
  FROM dual;
  
  //모든행이 다나온다.
  SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
  FROM emp;
  
  함수는 where절에서도 사용이 가능하다.
  emp 테이블의 SMITH 사원의 이름은 대문자로 저장되어 있음
  
  SELECT *
  FROM  emp
  WHERE LOWER(ename) ='smith'; 이런식으로 작성하면 안된다.    -행개수만큼
  WHERE enmae =UPPER('smith'); 두가지 방식중에는 위에보다는 아래방식 올바른 방식이다.
  
  WHERE enmae = 'smith'; 테이블에는 데이터 값이 대문자로 저장되어있으므로 조회건수 0
  WHERE ename = 'smith'; 정상 실행
  
  문자열 연산 함수
  CONCAT( 2개의 문자열을 입력으로 받아, 결합한 문자열을 반환한다.
  CONCAT('start', 'end')
  FROM dual;
  
    CONCAT 함수로 작성하기 (단 || 은 사용하지 않는다)
      'SELECT * FROM' || table_name || ';'   ====   CONCAT('SELECT * FROM' ,CONCAT(table_name, ';'))
      
      
  SELECT table_name, tablespace_name, CONCAT('start', 'end'),
       CONCAT(table_name, tablespace_name), 
       'SELECT * FROM' || table_name || ';',
       CONCAT('SELECT * FROM' ,CONCAT(table_name, ';'))
  FROM user_tables;
  
  부분문자열
  SUBSTR(문자열, 시작 인덱스 , 종료 인덱스) : 문자열의 시작인덱스부터 종료 인덱스까지 출력  
 시작인덱스는 1부터(Java의 경우는 0부터)
 -- 1부터 6자리까지 출력 Hello,             
 -- 알리아스(별칭)을 안주면 매소드 전체가 나온다.
  SELECT SUBSTR('Hello, World',1,6)  sub
  FROM dual
  
  문자열 
  LENGTH(문자열) : 문자열의 길이를 반환
  SELECT LENGTH('Hello, World') len 
  FROM dual
  
  INSTR(문자열, 찾을 문자열, [검색 시작 인덱스]) : 문자열에서 찾을 문자열이 존재하는지, 존재할 경우 찾을 문자열의 인덱스(위치) 반환
  ('Hello, World', 'o', 6) : Hello, World 에서 o 를찾는데 6은 6쨰 자리수부터 찾기시작한다의미 
  106, 107 번째는 같은의미
  SELECT INSTR('Hello, World', 'o') ins,
  INSTR('Hello, World', 'o',6) ins1,
  INSTR('Hello, World', 'o', INSTR('Hello, World', 'o')+1) ins2   
  FROM dual
  
  LPAD, RPAD(문자열, 맞추고 싶은 전체 문자열 길이, [패딩 문자열 - 기본 값은 공백])
  SELECT LPAD('hello', 15, '*') lp ,
  RPAD('hello', 15, '*') rp ,
  LPAD('hello', 15) lp1 ,
  RPAD('hello', 15) rp1 
  FROM dual
  
  REPLACE(문자열, 검색할 문자열, 변경할 문자열) : 문자열에서 검색할 문자열 찾아 변경할 문자열 변경로 변경
  SELECT REPLACE('Hello, World', 'll', 'LL') re
  FROM dual
  
  TRIM(문자열) : 문자열의 앞 뒤의 존재한는 공백을 제거, 문자열 중간에 있는 공백은 제거 대상이 아님
  tr1 :H를 제거한다. 문자열 앞뒤 특정문자제거
  SELECT TRIM('  Hel lo    ') tr ,
  TRIM('H' FROM 'Hello')tr1
  FROM dual
  
  NUMBER 관련 함수
  ROUND(숫자, [반올림 위치 default :0]) : 반올림
   ROUND(105.54 ,1) : 소수점 첫번째 자리까지 결과를 생성 ==> 소수점 두번째 자리에서 반올림 : 105.5 
   
  SELECT ROUND(105.54, 1) round,      
         ROUND(105.55, 1) round2, 
         ROUND(105.55, 0) round3,
         ROUND(105.55, -1) round4
  FROM dual;
  결과값 : 105.5  , 105.6 , 106  , 110

  TRUNC(숫자, [내림 위치- default :0]) : 내림
     
  SELECT TRUNC(105.54, 1) trunk,      
         TRUNC(105.55, 1) trunk2, 
         TRUNC(105.55, 0) trunk3,
         TRUNC(105.55, -1) trunk4
  FROM dual;

  MOD(파제수, 제수) : 나머지연산
  
  SELECT MOD(10,3)
  FROM dual;
  
  SELECT MOD(10, 3 ), sal, MOD(sal, 1000)
  FROM emp;
  
  
  날짜 관련 함수
  SYSDATE : 사용중인 오라클 데이터베이스 서버의 현재 시간, 날짜를 반환한다.
            함수이지만 인자가 없는 함수 (인자가 없을경우 JAVA : 메소드()/ SQL : 함수명);
  
  date type +- 정수 : 일자 더하기 빼기
  정수 1 = 하루
  1/24 = 한시간
  1//24/60 = 일분
  
  SELECT SYSDATE, SYSDATE +5 
  FROM dual;
  
  EX)
  SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') LASTDAY,
  TO_DATE('2019/12/31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5,
  SYSDATE NOW,
  SYSDATE -3 NOW_BEFORE3
  FROM dual;
  
  
  TO_DATE(문자열, 포맷) : 문자열을 포맷에 맞게 해석하여 날짜 타입으로 형변환
  TO_CHAR(날짜, 포맷) : 날짜타입을 포맷에 맞게 문자열로 변환
  YYYY : 년도
  MM   : 월
  DD   : 일자
  D    : 주간일자(1~7, 1 - 일요일 , 2 - 월요일 .... 7 - 토요일)
  IW   : 주차 (52~53)
  HH   : 시간(12시간)
  HH24 : 24시간 표기
  MI   : 분
  SS   : 초
  
  현재시간(SYSDATE) 시분초 단위까지 표현 ==> TO_CHAR를 이용하여 형변환
  SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
         TO_CHAR(SYSDATE, 'D') d,
         TO_CHAR(SYSDATE -3, 'YYYY/MM/DD HH24:MI:SS') now_before3,
         TO_CHAR(SYSDATE -1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour 
         
  FROM dual;
  
  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
         TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') DT_DASH_WITH_TIME,
         TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
         
  FROM dual;
  
  MONTHS_BETWEEN(DATE1, DATE2): DATE1과 DATE2 사이의 개월수를 반환
  4가지 날짜 관련함수중에 사용 빈도가 낮음
  SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21' , 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
         MONTHS_BETWEEN(TO_DATE('2020/04/22' , 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
  FROM dual;
  
  ADD_MONTHS(DATE, 가감할 개월수) : DATE로 부터 두번째 입력된 개월수 만큼 가감한 DATE
  오늘 날짜로부터 5개월 뒤 날짜
  SELECT ADD_MONTHS(SYSDATE,5) dt1,
         ADD_MONTHS(SYSDATE,-5) dt2
  FROM dual;
  
  NEXT_DAY(date, 주간일자) : DATE이후 등장한느 첫번쨰 주간일자의 날짜를 반환
  SELECT NEXT_DAY(SYSDATE, 7) 
  FROM dual;
  
  LAST_DAY(DATE) : DATE가 속한 월의 마지막 날짜를 반환
  SYSDATE : 2020/04/21 ==> 2020/04/30
  SELECT LAST_DAY(SYSDATE)
  FROM dual;
  
  날짜가 속한 월의 첫번째 날짜 구하기(1일)
  SYSDATE : 2020/04/21 ==> 2020/04/01;
  
  SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE)+1,
         ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
         TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
  FROM dual;
  
  
  복습--------------------------------------
  
  리터럴 
  숫자 : ...
  문자 : ''
  날짜 : TO_DATE('날짜문자열','YYYUMMDD(포맷)') 
  
  
  
       
 
 
 
