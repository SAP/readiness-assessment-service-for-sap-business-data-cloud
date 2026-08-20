-- ODP-RFC SQL -- SAP ERP 6.0 -- Oracle
SELECT
    SYS_CONTEXT('USERENV', 'DB_NAME')                               AS SID,
    (SELECT COMPONENT FROM (
        SELECT
            ROW_NUMBER() OVER (ORDER BY
                CASE COMPONENT
                    WHEN 'SAP_APPL'  THEN '2'
                    WHEN 'S4CORE'    THEN '1'
                    WHEN 'SAP_BW'    THEN '3'
                    WHEN 'SAP_BASIS' THEN '5'
                    WHEN 'DW4CORE'   THEN '4'
                END ASC
            ) AS ROWN,
            CASE WHEN COMPONENT NOT IN ('SAP_BW','DW4CORE')
                 THEN COMPONENT || RELEASE
                 ELSE COMPONENT
            END AS COMPONENT
        FROM CVERS
        WHERE COMPONENT IN ('SAP_APPL', 'S4CORE', 'SAP_BW', 'SAP_BASIS', 'DW4CORE')
    ) T
    WHERE T.ROWN = 1)                                               AS COMPONENT,
    aud.subscriber_type                                             AS subscriber_type,
    aud.subscriber_id                                               AS subscriber_id,
    aud.modelname                                                   AS modelname,
    aud.queuename                                                   AS queuename,
    aud.uname                                                       AS username,
    aud.caller                                                      AS caller,
    aud.unpermitted                                                 AS unpermitted,
    COUNT(DISTINCT aud.pointer)                                     AS call_count,
    0                                                               AS total_size_mb,
    CAST(NULL AS VARCHAR2(1))                                       AS SOURCE_OBJECT_DDL_NAME,
    SUBSTR(TO_CHAR(MAX(aud.pointer)), 1, 8)                         AS LAST_EXECUTED_DATE,
    SUBSTR(TO_CHAR(MIN(aud.pointer)), 1, 8)                         AS FIRST_EXECUTED_DATE
FROM rodps_repl_key aud
GROUP BY
    aud.subscriber_type,
    aud.subscriber_id,
    aud.modelname,
    aud.queuename,
    aud.uname,
    aud.caller,
    aud.unpermitted
ORDER BY 1, 9 DESC
