#!/bin/bash
#Author: Faarouq Asaju
#Date: 17-12-2025
#Descr: Audits critical filesystem permissions and flags misconfigurations that may lead to elevated privileges.



audit_world_writable_dir(){

#You can edit the dir you start your search from as searching from root takes too much time
	printf '\nWorld Writable Directories:\n'
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
	printf '\nWorld Writable Files:\n'
	result=$(find /home/faarouq -type f -perm -0002 -print 2> /dev/null)

	if [ -z "$result" ]; then 
		printf '\tNone detected\n'
	else
		printf '%s\n' "$result" | sed 's/^/\t- /'
	fi
}



#Edit or add critical files along with their required file permissions if needed

audit_critical_file_permissions(){
	printf '\nCritical File Permissions\n'
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


audit_suid_sgid_binaries() {
    printf '\nSUID/SGID binaries:\n'

    found=0

    # SUID
    while read -r file; do
        [ -z "$file" ] && continue
        printf '\t- %s (SUID)\n' "$file"
        found=1
    done < <(
        find /home \
            \( -path "/proc/*" -o -path "/sys/*" -o -path "/dev/*" \) -prune -o \
            -type f -perm -4000 -print 2>/dev/null
    )

    # SGID
    while read -r file; do
        [ -z "$file" ] && continue
        printf '\t- %s (SGID)\n' "$file"
        found=1
    done < <(
        find /home \
            \( -path "/proc/*" -o -path "/sys/*" -o -path "/dev/*" \) -prune -o \
            -type f -perm -2000 -print 2>/dev/null
    )

    if [ "$found" -eq 0 ]; then
        printf '\tNone detected.\n'
    fi
}



audit_world_writable_dir
audit_world_writable_files
audit_critical_file_permissions
audit_suid_sgid_binaries
