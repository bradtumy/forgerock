#!/bin/bash
# backup_openam_config.sh - exports a backup from an openam configuration
# written by:  Brad Tumy - brad@tumy-tech.com  23 Oct 2014
# last updated:  05 Nov 2014

# change the following variables to suit your environment

SSOADM=/opt/ssoadmtools/openam/bin/ssoadm
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export JAVA_HOME
ADMIN_USER=amadmin
DATA_STORE=opendj
PASSWORD_LOCATION=/home/brad/.mypass
# SECRET_KEY is retrieved from OpenAM Console Configuration > Servers and Sites > Server Name > Security > Password Encryption Key
SECRET_KEY=xxxx
BACKUP_FILE=~/openam_backup-`date -u +%F-%m-%S`.xml

# back up the openam service configuration
${SSOADM} export-svc-cfg -u ${ADMIN_USER} -e ${SECRET_KEY} -f ${PASSWORD_LOCATION} -o ${BACKUP_FILE}
