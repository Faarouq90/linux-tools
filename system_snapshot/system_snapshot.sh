#!/bin/bash
#AUTHOR: FAAROUQ ASAJU
#DATE: 03-12-2025
#DESCRIPTION: Collects simple system information




HOSTNAME=$(hostname)
OSNAME=$(uname)
KERNELVERSION=$(uname -r)
LOGGEDIN=$(who | awk '{print $1}' | sort -u | paste -sd, -)
DATE=$(date '+%F %T')
LOG_FILE=$HOME/logs/system_snapshot.log


{

	printf '%s\n'"===================="
	printf '\n TIMESTAMP: %s\n' "$DATE"	
	printf '\n Hostname: %s\n' "$HOSTNAME"
	printf '\n OS: %s\n' "$OSNAME"
	printf '\n Kernel Version: %s\n' "$KERNELVERSION"
	printf '\n Logged-in Users: %s\n' "$LOGGEDIN"
	printf '\n Disk Usage Summary: \n'
	df -h
	printf '\n Memory Usage Summary: \n'
	free -h
	printf '%s\n'"==================== \n\n\n\n"
	
}>> $LOG_FILE

