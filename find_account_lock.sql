-- ========== CHECK USER LOCK ==========--
SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME LIKE '%&USERNAME%';

ALTER USER &USERNAME ACCOUNT UNLOCK;

-- ========== RESET USER ACCOUNT =============-

ALTER USER &USERNAME IDENTIFIED BY &PASSWORD ACCOUNT UNLOCK;

-- ========== GRANT ACCESS TO USER IF CANNOT ENTER INTO SYSTEM ========== --
GRANT INFOINS TO &USERNAME;

-- ========== CHECK DMS USER ========== --
SELECT * FROM SM_M_SALES_FORCE WHERE SFC_USERNAME LIKE '%AMIBKUR%';

SELECT * FROM DMS_INS.SEC_USER WHERE ID='1056';

SELECT * FROM DMS_INS.SEC_USER WHERE U_NAME LIKE '%&USERNAME%';

UPDATE DMS_INS.SEC_USER SET ACTIVE='Y', MUST_CHANGE_PASSWORD='N', FAILED_ATTEMPTS=0 WHERE ID=1056;

COMMIT;