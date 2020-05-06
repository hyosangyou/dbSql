DML 
데이터를 입력 (INSERT), 수정(UPDATE), 삭제(DELETE) 할 때 사용하는 SQL

INSERT

구문 INSERT INTO 테이블명 [(테이블의 컬럼명, ....)] VALUES (입력할 값,....);

크게 다음 두가지 형태로 사용
1. 테이블의 모든 컬럼에 값을 입력하는 경우, 컬럼명을 나열하지 않아도 된다.
  단 입력할 값의 순서는 테이블에 정의된 컬럼 순서로 인식된다.(컬럼순서는 중요하다.)
INSERT INTO 테이블명 VALUES (입력할 값, 입력할값2...);

2. 입력하고자 하는 컬럼을 명시하는 경우
 사용자가 입력하고자 하는 컬럼을 선택하여 데이터를 입력할 경우.
 단 테이블에 NOT NULL 설정이 되어있는 컬럼이 누락되면 INSERT는 실패한다.
INSERT INTO 테이블명 (컬럼1, 컬럼2)VALUES (입력할 값, 입력할값2);


dept 테이블에 deptno = 99, dname, ddit, loc daejeon 값을 입력하는 insert 구문 작성

데이터 입력을 확정 지으려면 : commit - 트랜잭션 완료
데이터 입력을 취소 하려면 : rollback - 트랜잭션 취소


두가지방법으로
1)
INSERT INTO dept VALUES (99,'DDIT','DAEJEON');
2)
INSERT INTO dept (loc, deptno, dname) VALUES ('DAEJEON',99,'DDIT');

select *
from dept;

rollback;

위의 INSERT 구문은 고정된 문자열, 상수를 입력한 경우
INSERT 구문에서 스칼라 서브쿼리, 함수도 사용가능
EX : 테이블에 데이터가 들어갈 당시의 일시정보를 기록하는 경우가 많음 ==> SYSDATE;

SELECT *
FROM emp;

emp 테이블의 경우 컬럼 총 개수는  8개, NOT NULL은 1개(EMPNO)
empno 가 9999이고 ename YOUHYOSANG ,HIREDATE 는 현재일시를 저장하는 INSERT 구문을 작성
INSERT INTO emp(empno,ename,hiredate) VALUES (9999,'YOUHYOSANG',SYSDATE);
INSERT 절에 기술하지 않은 컬럼들은 값이 NULL로 입력된다.

9998번 사번으로 JW 사원을 입력 , 입사일자는 2020년 04 월 13일로 설정하여 데이터 입력
INSERT INTO emp(empno,ename,hiredate) VALUES (9998,'JW', TO_DATE('2020/04/13','YYYY/MM/DD'));
rollback;



3.SELECT 결과를 INSERT
  SELECT 쿼리를 이용해서 쿼리의  의해 조회되는 결과를 테이블에 입력 가능
  ==> 여러건의 데이터를 하나의 쿼리로 입력 가능 (ONE-QUERY)==> 성능 개선
  
  사용자로 부터 데이터를 직접 입력 받는 경우 (ex 회원가입)는 적용이 불가
  db상에 존재하는 데이터를 갖고 조작하는 경우 활용 가능 (이런 경우가 많음)
  
  
  INSERT INTO 테이블명[(컬럼명1, 컬럼명2...)])
  SELECT ....
  FROM ....

EX) SELECT 결과를 테이블에 입력하기 (대량 입력);

DESC dept;

dept 테이블에는 4건의 데이터가 존재 (10~40)
아래 쿼리를 실행하면 기존 존재 4건 + SELECT 로 입력되는 4건 총 8건의 데이터가 dept 테이블에 입력됨
INSERT INTO dept
SELECT *
FROM dept;

rollback;

---------------------------------------------------------------------------------------------------

UPDATE : 데이터 수정
UPDATE 테이블명 SET 수정할 컬럼1 = 수정할 값1,
                   [수정할 컬럼2 = 수정할 값2, ....]
[WHERE condition - select 절에서 배운 where절과 동일
       수정할 행을 인식하는 조건을 기술]
       
dept 테이블에 99, DDIT, DAEJEON;

INSERT INTO dept VALUES (99,'DDIT','DAEJEON');

SELECT *
FROM dept;

99번 부서의 부서명을 대덕 IT로, 위치를 영민빌딩으로 변경 
--WHERE절을 명시 안하면 모든 컬럼의 행들이 바뀐다.
UPDATE dept SET DNAME = '대덕IT', loc = '영민빌딩'  
WHERE DEPTNO = 99;

SELECT *
FROM dept;

INSERT : 없던 걸 새로 생성
UPDATE, DELETE : 기존에 없는걸 변경, 삭제
 ==> 쿼리를 작성할 경우 주의
     1. WHERE절이 누락되지 않았는지
     2. UPDATE, DELETE 문을 실행하기전에 WHERE 절을 복사해서 SELECT 를 하여 
     영향이 가는 행을 확인
     



