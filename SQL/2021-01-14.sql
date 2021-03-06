-- 601. 体育馆的人流量
    -- 方法1：
SELECT DISTINCT D.* FROM 
(SELECT ID,VISIT_DATE,PEOPLE FROM STADIUM WHERE PEOPLE>=100 ORDER BY VISIT_DATE)A,
(SELECT ID,VISIT_DATE,PEOPLE FROM STADIUM WHERE PEOPLE>=100 ORDER BY VISIT_DATE)B,
(SELECT ID,VISIT_DATE,PEOPLE FROM STADIUM WHERE PEOPLE>=100 ORDER BY VISIT_DATE)C,
STADIUM D
WHERE A.ID=B.ID-1 AND A.ID=C.ID+1 AND D.ID IN (A.ID,B.ID,C.ID)

    --方法2：日期排序，用id-row_number 的方式判断是否连续
SELECT ID,VISIT_DATE,PEOPLE FROM(SELECT ID,VISIT_DATE,PEOPLE,COUNT(*)OVER(PARTITION BY K1) K2 FROM
(SELECT ID,VISIT_DATE,PEOPLE,ID-ROW_NUMBER()OVER(ORDER BY VISIT_DATE) K1 FROM STADIUM WHERE PEOPLE >=100 ) A) B
WHERE B.K2>=3