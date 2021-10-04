#!/bin/bash

################################################################
## MySQL restore Percona Xtrabackup hot backup
################################################################

BACKUP_DIR=/opt/backups/

# Stop mysql services
systemctl stop mysql 

# Prepare backup
xtrabackup --prepare --target-dir=${BACKUP_DIR}

# Remove mysql logs
rm /var/log/mysql/*

# Move mysql current files
MYSQL_OLD=/var/lib/mysql_old_$(date +%d%m%Y%H%M)/
mkdir ${MYSQL_OLD}

mv /var/lib/mysql/* ${MYSQL_OLD}

# Restore mysql databases
xtrabackup --copy-back --target-dir=${BACKUP_DIR} --datadir=/var/lib/mysql/

# Change permissions
chown -R mysql:mysql /var/lib/mysql/
chown -R mysql:mysql /var/log/mysql/

# Start mysql services
systemctl start mysql 
