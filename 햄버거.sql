
���� 1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� sql �ۼ�
1.���ù��������� ���ϰ�
2.�δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�;
SELECT ROWNUM RN1, a.*
FROM
(SELECT SIDO, SIGUNGU, SAL/PEOPLE ���ù�������
FROM TAX
ORDER BY ���ù������� DESC) a;

3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� sql �ۼ�
����,�ܹ��� SIDO,�ܹ��� SIGUNGU, �ܹ��� ���ù�������,����û, sido ����û sigungu, ����û �������� �ݾ� 1�δ� �Ű��

SELECT ham.rn RN, ham.�õ� �ܹ��Žõ�, ham.�ñ��� �ܹ��Žñ���, ham.���ù������� �ܹ��ŵ��ù�������,hu.sido �Ű�׽õ�, hu.sigungu �Ű�׽ñ���, hu.���ù������� �Ű��
FROM
(SELECT ROWNUM rn, E.*
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
ORDER BY ���ù������� DESC) E) ham, (SELECT ROWNUM RN1, a.*
                                  FROM
                                  (SELECT SIDO, SIGUNGU, SAL/PEOPLE ���ù�������
                                  FROM TAX
                                  ORDER BY ���ù������� DESC) a) hu
WHERE HAM.RN(+) = HU.RN1;


���� 2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�����)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fast food ���̺��� 1���� ���)
hint case, decode

SELECT SIDO, SIGUNGU, COUNT(CASE WHEN  GB IN( '����ŷ' , '�Ƶ�����' , 'KFC') THEN 1 END)/COUNT (CASE WHEN GB= '�Ե�����'THEN 1 ELSE 0 END) �ܹ�������
FROM FASTFOOD
GROUP BY SIDO, SIGUNGU
ORDER BY �ܹ������� DESC;

--������
SELECT ROWNUM rank, sido ,sigungu, city_idx
FROM
(SELECT SIDO, SIGUNGU, ROUND((KFC+MAC+BK) / NVL(lot,1),2) city_idx
FROM
(SELECT SIDO, SIGUNGU, NVL(SUM(CASE WHEN GB ='�Ե�����' THEN 1 END), 1) lot, NVL(SUM(CASE WHEN GB ='KFC' THEN 1 END),0) KFC,
                         NVL(SUM (CASE WHEN GB ='����ŷ' THEN 1 END),0) BK, NVL(SUM (CASE WHEN GB ='�Ƶ�����' THEN 1 END),0) mac 
FROM fastfood
WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
GROUP BY SIDO, SIGUNGU)
ORDER BY  city_idx DESC) ;
����3 �ܹ��� �ٸ� ������� �յѰ�
������
                      