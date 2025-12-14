#!/bin/bash
#Author: Faarouq Asaju
#Date: 12-12-2025
#Descr:  Audits system users and disk usage using awk-based parsing. Detects suspicious accounts, missing home directories, and high disk utilization 


DISK_THRESHOLD=80
TIMESTAMP=$(date  '+%F %T')

perform_user_audit(){
	printf '==== USER AUDIT ====\n\n'
	printf '%-16s %-16s %-18s %s\n' "USERNAME" "UID" "HOME" "SHELL"
	printf '%s\n' "-------------------------------------------------------------"
	awk -F':' '{ printf "%-16s %-16s %-18s %s\n\n", $1, $3, $6, $7 }' /etc/passwd

	printf 'Suspicious Users: \n'
	while IFS=: read -r username passwd uid gid comment home shell; do
		if [ "$uid" -eq 0 ] && [ "$username" != "root" ]; then
		       printf '\t-System User with root login: %s(uid=%s)\n' "$username" "$uid"
		fi

		if [ ! -d "$home" ]; then
			printf '\t-System User with no home directory: %s\n' "$username"
		fi

		if [[ "$uid" -le 100 && ( "$shell" == "/bin/bash" || "$shell" == "/bin/sh" ) ]]; then
			printf '\t-System User with suspicious shell: %s(shell=%s)\n' "$username" "$shell"
			
		fi
	done < /etc/passwd
}

perform_disk_audit() {
	printf '\n\n==== DISK AUDIT ====\n\n'
	printf '%-16s %-20s %-16s\n' "FILESYSTEM" "MountPoint" "Usage"
	printf '%s\n' "---------------------------------------------------"
	
	df -P | awk 'NR>1 {printf "%-16s %-20s %-16s\n", $1, $6, $5 }'

	printf 'High Usage Filesystems (>=%s): \n' "$DISK_THRESHOLD"
	found=0
	while IFS=' ' read -r filesystem per_used mountpoint; do
		usep=${per_used%\%}	
		if [ "$usep" -ge "$DISK_THRESHOLD" ]; then
			printf '\t- %s on %s (=%s) \n' "$filesystem" "$mountpoint" "$per_used"
			found=1
		fi
	done< <(df -P | awk 'NR>1 {printf $1, $5, $6}')

	if [ "$found" -eq 0 ]; then
		printf '\t\n\n -No Filesystem surpasses the Threshold'
	fi
}

#----------------------------------- MAIN ----------------------
printf '%s\n' "============================================================="
printf 'Timestamp: %s\n\n' "$TIMESTAMP"
perform_user_audit
perform_disk_audit
printf '\n\n%s\n' "============================================================="
