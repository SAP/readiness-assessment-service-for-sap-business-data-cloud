select 'RSDDSTAT_OLAP' as TABLE_NAME, OBJNAME as KEY_NAME, CAST(max(STARTTIME) as varchar(20)) as LAST_DATE, '' as COL1, '' as COL2 from <SID>.<OWNER_SCHEMA>.RSDDSTAT_OLAP group by OBJNAME
union
select 'RSANT_PROCESSR', PROCESS, CAST(max(START_TIME) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSANT_PROCESSR group by PROCESS
union
select 'RSMDATASTATE', INFOCUBE, CAST(max(TMSTMP_QUALOK) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSMDATASTATE group by INFOCUBE
union
select 'RSPMXREFPROCVIEW', TGT_DATATARGET, CAST(max(TGT_REQUEST_TSN) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSPMXREFPROCVIEW group by TGT_DATATARGET
union
select 'RSPMXREFPROCVIEW1', PROCESS_ID, CAST(max(TGT_REQUEST_TSN) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSPMXREFPROCVIEW group by PROCESS_ID
union
select 'RSPMPROCESS', UNIQUE_TARGET_DTA, CAST(max(PROCESS_TSN) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSPMPROCESS group by UNIQUE_TARGET_DTA
union
select 'RSBKREQUEST', SRC, CAST(max(TSTMP_START) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSBKREQUEST group by SRC
union
select 'RSBKREQUEST1', DTP, CAST(max(TSTMP_START) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSBKREQUEST group by DTP
union
select 'RSBKREQUEST2', TGT, CAST(max(TSTMP_START) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSBKREQUEST group by TGT
union
select 'RSDMSTAT', ICNAME, CAST(max(TSTPDAT) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSDMSTAT group by ICNAME
union
select 'RSRD_SETTING', SETTING_ID, CAST(max(LASTUSED) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSRD_SETTING group by SETTING_ID
union
select 'RSBREQUID', INFOSPOKE, CAST(max(TSTMP_START) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSBREQUID group by INFOSPOKE
union
select 'RSDHARUN', HAAPNM, CAST(max(START_TIME) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSDHARUN group by HAAPNM
union
select 'RSSELDONE', OLTPSOURCE, CAST(max(SELDATE) as varchar(20)), LOGSYS, '' from <SID>.<OWNER_SCHEMA>.RSSELDONE group by OLTPSOURCE, LOGSYS
union
select 'RSSELDONE1', LOGSYS, CAST(max(SELDATE) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSSELDONE group by LOGSYS
union
select 'RSLDPIO', OLTPSOURCE, CAST(max(TIMESTAMP) as varchar(20)), LOGSYS, '' from <SID>.<OWNER_SCHEMA>.RSLDPIO group by OLTPSOURCE, LOGSYS 
union
select 'RSLDPIO1', LOGSYS, CAST(max(TIMESTAMP) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSLDPIO group by LOGSYS 
union
select 'RSDAARCHREQ_V', DAPNAME, CAST(max(TIMESTAMP_LONG) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSDAARCHREQ_V group by DAPNAME
union
select 'RSREQDONE', LOGDPID, CAST(max(DATUM) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSREQDONE group by LOGDPID
union
select 'RSREQDONE1', LOGGRID, CAST(max(DATUM) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSREQDONE group by LOGGRID
union
select 'RSPCLOGCHAIN', CHAIN_ID, CAST(max(DATUM) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.RSPCLOGCHAIN group by CHAIN_ID
union
select 'ROOSPRMSC', OLTPSOURCE, CAST(max(TIMESTAMP) as varchar(20)), RLOGSYS, SLOGSYS from <SID>.<OWNER_SCHEMA>.ROOSPRMSC group by OLTPSOURCE, RLOGSYS, SLOGSYS
union
select 'RSPCPROCESSLOG', TYPE, CAST(max(STARTTIMESTAMP) as varchar(20)), VARIANTE, '' from <SID>.<OWNER_SCHEMA>.RSPCPROCESSLOG group by TYPE, VARIANTE
union
select 'RSRREPDIR', INFOCUBE, CAST(max(GENTIME) as varchar(20)) as GENTIME, '', '' from <SID>.<OWNER_SCHEMA>.RSRREPDIR group by INFOCUBE
union
select 'V_REP_JOIN', INFOCUBE, CAST(max(LASTUSED) as varchar(20)), '', '' from <SID>.<OWNER_SCHEMA>.V_REP_JOIN group by INFOCUBE
