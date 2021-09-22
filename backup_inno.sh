#!/bin/bash

################################################################
## MySQL Hot Backup All Databases
################################################################
 
MYSQL_USER='mysql_user'
MYSQL_PASSWORD='mysql_password'
LOGFILE=/opt/logs/backup_hot_$(date +%d%m%Y%H%M).log
BAKDIR='/opt/backups/'

echo "Cleaning backup directory"

rm -rf ${BAKDIR}*

echo "Backup started for all databases"

innobackupex --user=${MYSQL_USER}  --password=${MYSQL_PASSWORD} ${BAKDIR} > ${LOGFILE}

echo "Compress backup"

BAKZIP=/opt/zip/mysql_xb_$(date +%d%m%Y%H%M).zip

zip -r ${BAKZIP} ${BAKDIR}
