#!/bin/bash
# Date Created  : 08-06-2017
# Purpose       : Incremental Level 1 Backup (Differential Backup)
# Creator       : AMI - HTET PAING
# Role		: DBA

ORACLE_HOME=/vol0/app/oracle/product/12.1.0.2/db_1
export ORACLE_HOME
export PATH=$ORACLE_HOME/bin:$PATH
ORACLE_SID=SICL; export ORACLE_SID

rman target / @/vol2/backup/bin/backup_script_daily.sql

chmod -R 775 /vol2/backup/*
