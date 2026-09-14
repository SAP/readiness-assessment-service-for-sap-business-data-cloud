SELECT
    DB_NAME()                                                        AS SID,
    CASE
        WHEN EXISTS (SELECT 1 FROM CVERS WHERE COMPONENT = 'S4CORE')
            THEN (SELECT COMPONENT + RELEASE FROM CVERS WHERE COMPONENT = 'S4CORE')
        WHEN EXISTS (SELECT 1 FROM CVERS WHERE COMPONENT = 'SAP_APPL')
            THEN (SELECT COMPONENT + RELEASE FROM CVERS WHERE COMPONENT = 'SAP_APPL')
        WHEN EXISTS (SELECT 1 FROM CVERS WHERE COMPONENT = 'SAP_BW')
            THEN (SELECT COMPONENT         FROM CVERS WHERE COMPONENT = 'SAP_BW')
        WHEN EXISTS (SELECT 1 FROM CVERS WHERE COMPONENT = 'DW4CORE')
            THEN (SELECT COMPONENT         FROM CVERS WHERE COMPONENT = 'DW4CORE')
        WHEN EXISTS (SELECT 1 FROM CVERS WHERE COMPONENT = 'SAP_BASIS')
            THEN (SELECT COMPONENT + RELEASE FROM CVERS WHERE COMPONENT = 'SAP_BASIS')
        ELSE NULL
    END                                                              AS COMPONENT,
    k.SUBSCRIBER_TYPE                                                AS subscriber_type,
    k.SUBSCRIBER_ID                                                  AS subscriber_id,
    k.MODELNAME                                                      AS modelname,
    k.QUEUENAME                                                      AS queuename,
    p.UNAME                                                          AS username,
    p.CALLER                                                         AS caller,
    p.UNPERMITTED                                                    AS unpermitted,
    COUNT(DISTINCT k.POINTER)                                        AS call_count,
    ISNULL(CONVERT(DECIMAL(20,3), SUM(od.RAWSIZE)), 0) / 1048576    AS total_size_mb,  -- from ODQ
    CAST(NULL AS VARCHAR(1))                                         AS SOURCE_OBJECT_DDL_NAME,
    SUBSTRING(CONVERT(VARCHAR(50), MAX(k.POINTER)), 1, 8)           AS LAST_EXECUTED_DATE,
    SUBSTRING(CONVERT(VARCHAR(50), MIN(k.POINTER)), 1, 8)           AS FIRST_EXECUTED_DATE
FROM RODPS_REPL_KEY k
JOIN RODPS_REPL_POINT p
    ON  k.MANDT   = p.MANDT
    AND k.POINTER = p.POINTER
LEFT JOIN (
    SELECT MODELNAME, QUEUENAME, RAWSIZE FROM ODQDATA
    UNION ALL
    SELECT MODELNAME, QUEUENAME, RAWSIZE FROM ODQDATA_F
    UNION ALL
    SELECT MODELNAME, QUEUENAME, RAWSIZE FROM ODQDATA_C
) od
    ON  od.MODELNAME = k.MODELNAME
    AND od.QUEUENAME = k.QUEUENAME
GROUP BY
    k.SUBSCRIBER_TYPE,
    k.SUBSCRIBER_ID,
    k.MODELNAME,
    k.QUEUENAME,
    p.UNAME,
    p.CALLER,
    p.UNPERMITTED
ORDER BY 1, 9 DESC