#!/bin/bash
#Author: Faarouq Asaju
#Date: 17-12-2025
#Descr: Audits critical filesystem permissions and flags misconfigurations that may lead to elevated privileges.



audit_world_writable_dir(){

#You can edit the dir you start your search from as searching from root takes too much time
	printf 'World Writable Directories:\n'
	result=$(find /home \
		\( -path "/sys/*" -o -path "/dev/*" -o -path "/proc/*" \) -prune -o \
		-type d -perm -0002  -print 2>/dev/null)
	if [ -z "$result" ]; then
		printf '\tNone detected\n'
	else
		printf '%s\n' "$result" | sed 's/^/\t- /'
	fi
}

audit_world_writable_files(){
	printf 'World Writable Files:\n'
	result=$(find /home/faarouq -type f -perm -0002 -print 2> /dev/null)

	if [ -z "$result" ]; then 
		printf '\tNone detected\n'
	else
		printf '%s\n' "$result" | sed 's/^/\t- /'
	fi
}



#Edit or add critical files along with their required file permissions if needed

audit_critical_file_permissions(){
	printf 'Critical File Permissions\n'
	file="/etc/shadow"
	perm_requirement=600

	if [ ! -f "$file" ]; then
		printf 'File (%s) does not exist\n' "$file"
		return
	fi

	file_perm=$(stat -c %a "$file")


	if [ "$file_perm" != "$perm_requirement" ]; then

		printf '\t-%s FAIL (%s)\n' "$file" "$file_perm"
	else
		printf '\t-%s OK (%s)\n' "$file" "$file_perm"
	fi
}



audit_world_writable_dir
audit_world_writable_files
audit_critical_file_permissions

