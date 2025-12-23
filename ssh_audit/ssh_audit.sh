#!/bin/bash
#Author: Faarouq Asaju
#Date: 23-12-2025
#Descr: Reads and evaluates SSH server configuration for common hardening misconfigurations.

CONFIG_FILE="/etc/ssh/sshd_config"


#-------------------- Functions --------------------

probe_root_login(){
	 
	value=$(grep -i '^[[:space:]]*PermitRootLogin' "$CONFIG_FILE" \
		| awk '{print $2}' \
		| tail -n 1)


	if [ -z "$value" ]; then
		printf '\n WARNING!!! Unable to retrieve root login permission. \n'
		return
	fi


	case "$value" in
		yes)
			printf 'PermitRootLogin:\t Fail (%s)\n' "$value"
			return 1
			;;
		no)
			printf 'PermitRootLogin:\t OK (%s)\n' "$value"
			return 0
			;;
		*)
			printf 'WARNING!!! Unrecognised value:\t (%s)\n' "$value"
			return 1
			;;
	esac

}


probe_root_login
