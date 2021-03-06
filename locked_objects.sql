SELECT b.object_name, c.*,a.* from v$locked_object a,all_objects b , v$session C
where a.object_id=b.object_id
and a.session_id = c.sid;

SELECT b.object_name, c.*, a.* from v$locked_object a,all_objects b , v$session C
where a.object_id=b.object_id
and a.session_id = c.sid
and a.object_id in (
    select object_id 
    from user_objects 
    --where object_name in ('CL_T_CLM_SHARED_MEM','CL_T_PERILS_SECTION')
);

select * from gv$lock where id1=(select  object_id from  dba_objects where owner = 'SICL' and object_name = 'UW_X_POLICIES');