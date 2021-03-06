SELECT 
    SUBSTR(df.tablespace_name,1,20) "Tablespace Name",
    SUBSTR(df.file_name,1,40) "File Name",
    ROUND(df.bytes / power(1024,3),2) "Si7  (G)",
    ROUND(e.used_bytes / power(1024,3),2) "Used (G)",
    ROUND(f.free_bytes / power(1024,3),2) "Free (G)",
    ROUND(e.used_bytes / df.bytes * 100,0)||'%' "Used (%)"
FROM 
    DBA_DATA_FILES df,
    (SELECT file_id, SUM(DECODE(bytes,NULL,0,bytes)) used_bytes FROM dba_extents GROUP by file_id) e,
    (SELECT MAX(bytes) free_bytes, file_id FROM dba_free_space GROUP BY file_id) f
WHERE e.file_id (+) = df.file_id AND df.file_id = f.file_id (+)
ORDER BY df.tablespace_name, df.file_name;