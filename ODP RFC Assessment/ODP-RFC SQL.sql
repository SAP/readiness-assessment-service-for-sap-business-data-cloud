SELECT 
(SELECT VALUE AS SID FROM SYS.M_SYSTEM_OVERVIEW WHERE SECTION = 'System' and NAME = 'Instance ID' LIMIT 1) AS  SID,
(SELECT COMPONENT FROM (
SELECT 
ROW_NUMBER() OVER(ORDER BY MAP(COMPONENT,'SAP_APPL','2','S4CORE','1','SAP_BW','3','SAP_BASIS','5','DW4CORE','4') ASC) AS ROWN,
CASE WHEN COMPONENT NOT IN ('SAP_BW','DW4CORE') THEN COMPONENT||RELEASE ELSE COMPONENT END AS COMPONENT
FROM CVERS WHERE COMPONENT IN ('SAP_APPL', 'S4CORE', 'SAP_BW','SAP_BASIS','DW4CORE')
)
WHERE ROWN = 1) 							AS COMPONENT,
        aud.subscriber_type                                             AS subscriber_type,
        aud.subscriber_id                                               AS subscriber_id,
        aud.modelname                                                   AS modelname,
        aud.queuename                                                   AS queuename,
        aud.username                                                    AS username,
        aud.caller                                                      AS caller,
        aud.unpermitted                                                 AS unpermitted,
        COUNT(DISTINCT aud.pointer)                                     AS call_count,
        SUM(aud.requestsize) /1024                                      AS total_size_mb,
        COALESCE(CDSVIEW.DDLNAME,RSO2.EXTRACTOR)                        AS SOURCE_OBJECT_DDL_NAME,
        left(to_char(max(aud.pointer)),8)                               AS LAST_EXECUTED_DATE,
        left(to_char(min(aud.pointer)),8)                               AS FIRST_EXECUTED_DATE
    FROM RODPS_AUDIT_EVAL  aud  
LEFT JOIN RSODPABAPCDSVIEW AS CDSVIEW
    ON SUBSTR_BEFORE(aud.QUEUENAME,'$') = CDSVIEW.SQLVIEWNAME
    AND aud.MODELNAME = 'ABAP_CDS'		 
LEFT JOIN ROOSOURCE AS RSO2
    ON aud.QUEUENAME = RSO2.OLTPSOURCE
    AND aud.MODELNAME = 'DATASOURCE_MODEL'
GROUP BY 
        aud.subscriber_type, 
        aud.subscriber_id, 
        aud.modelname, 
        aud.queuename, 
        aud.username, 
        aud.caller, 
        aud.unpermitted,
        COALESCE(CDSVIEW.DDLNAME,RSO2.EXTRACTOR)
order by 1, 9 desc

