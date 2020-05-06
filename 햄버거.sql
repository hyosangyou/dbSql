
과제 1] fastfood 테이블과 tax 테이블을 이용하여 다음과 같이 조회되도록 sql 작성
1.도시발전지수를 구하고
2.인당 연말 신고액이 높은 시도 시군구별로 순위를 구하여;
SELECT ROWNUM RN1, a.*
FROM
(SELECT SIDO, SIGUNGU, SAL/PEOPLE 도시발전지수
FROM TAX
ORDER BY 도시발전지수 DESC) a;

3. 도시발전지수와 인당 신고액 순위가 같은 데이터 끼리 조인하여 아래와 같이 컬럼이 조회되도록 sql 작성
순위,햄버거 SIDO,햄버거 SIGUNGU, 햄버거 도시발전지수,국세청, sido 국세청 sigungu, 국세청 연말정산 금액 1인당 신고액

SELECT ham.rn RN, ham.시도 햄버거시도, ham.시군구 햄버거시군구, ham.도시발전지수 햄버거도시발전지수,hu.sido 신고액시도, hu.sigungu 신고액시군구, hu.도시발전지수 신고액
FROM
(SELECT ROWNUM rn, E.*
FROM
(SELECT L.SIDO 시도, L.SIGUNGU 시군구, (M.맥도날드+K.KFC+B.버거킹)/L.롯데리아 도시발전지수
FROM
(SELECT SIDO, SIGUNGU,GB, COUNT(*) 롯데리아
 FROM FASTFOOD B
 WHERE GB = '롯데리아'
 GROUP BY SIDO,SIGUNGU,GB) L ,(SELECT SIDO,SIGUNGU, GB, COUNT(*) KFC
                               FROM FASTFOOD
                               WHERE GB = 'KFC'
                               GROUP BY SIDO,SIGUNGU,GB) K, (SELECT SIDO,SIGUNGU, GB, COUNT(*) 버거킹
                                                             FROM FASTFOOD
                                                             WHERE GB = '버거킹'
                                                             GROUP BY SIDO,SIGUNGU,GB) B,(SELECT SIDO,SIGUNGU, GB, COUNT(*) 맥도날드
                                                                                          FROM FASTFOOD
                                                                                          WHERE GB = '맥도날드'
                                                                                          GROUP BY SIDO,SIGUNGU,GB) M
WHERE L.SIGUNGU = M.SIGUNGU 
AND L.SIGUNGU= K.SIGUNGU
AND L.SIGUNGU= B.SIGUNGU
AND L.SIDO =M.SIDO
AND L.SIDO =K.SIDO
AND L.SIDO =B.SIDO
ORDER BY 도시발전지수 DESC) E) ham, (SELECT ROWNUM RN1, a.*
                                  FROM
                                  (SELECT SIDO, SIGUNGU, SAL/PEOPLE 도시발전지수
                                  FROM TAX
                                  ORDER BY 도시발전지수 DESC) a) hu
WHERE HAM.RN(+) = HU.RN1;


과제 2]
햄버거 도시발전 지수를 구하기 위해 4개의 인라인 뷰를 사용 하였는데 (fastfood 테이블을 4번사용)
이를 개선하여 테이블을 한번만 읽는 형태로 쿼리를 개선(fast food 테이블을 1번만 사용)
hint case, decode

SELECT SIDO, SIGUNGU, COUNT(CASE WHEN  GB IN( '버거킹' , '맥도날드' , 'KFC') THEN 1 END)/COUNT (CASE WHEN GB= '롯데리아'THEN 1 ELSE 0 END) 햄버거지수
FROM FASTFOOD
GROUP BY SIDO, SIGUNGU
ORDER BY 햄버거지수 DESC;

--선생님
SELECT ROWNUM rank, sido ,sigungu, city_idx
FROM
(SELECT SIDO, SIGUNGU, ROUND((KFC+MAC+BK) / NVL(lot,1),2) city_idx
FROM
(SELECT SIDO, SIGUNGU, NVL(SUM(CASE WHEN GB ='롯데리아' THEN 1 END), 1) lot, NVL(SUM(CASE WHEN GB ='KFC' THEN 1 END),0) KFC,
                         NVL(SUM (CASE WHEN GB ='버거킹' THEN 1 END),0) BK, NVL(SUM (CASE WHEN GB ='맥도날드' THEN 1 END),0) mac 
FROM fastfood
WHERE gb IN ('버거킹', 'KFC', '맥도날드', '롯데리아')
GROUP BY SIDO, SIGUNGU)
ORDER BY  city_idx DESC) ;
과제3 햄버거 다른 방법으로 먼둘가
선생님
                      