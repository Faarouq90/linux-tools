#!/bin/bash
#Author: Faarouq Asaju
#Date: 12-12-2025
#Descr:  Audits system users and disk usage using awk-based parsing. Detects suspicious accounts, missing home directories, and high disk utilization 


DISK_THRESHOLD=80


perform_user_audit(){
	printf '==== USER AUDIT ====\n\n'
	printf '%-16s %-16s %-16s %s\n' "USERNAME" "UID" "HOME" "SHELL"
	awk -F: '{ printf "%-16s %-16s %-16s %s\n" "$1" "$3" "$6" "7" }'
}

perform_user_audit
