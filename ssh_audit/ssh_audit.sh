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
		printf 'WARN Unable to retrieve root login permission. \n'
		return
	fi


	case "$value" in
		yes)
			printf 'PermitRootLogin:\t Fail (%s)\n' "$value"
			return 1
			;;
		no|prohibit-password)
			printf 'PermitRootLogin:\t OK (%s)\n' "$value"
			return 0
			;;
		*)
			printf 'PermitRootLogin:\t WARN Unrecognised value (%s)\n' "$value"
			return 1
			;;
	esac

}


probe_password_auth(){

	value=$(grep -i '^[[:space:]]*PasswordAuthentication' "$CONFIG_FILE" \
		| awk '{print $2}' \
		| tail -n 1)


	if [ -z "$value" ]; then
		printf 'WARN Unable to retrieve Password Authentication permission. \n'
		return
	fi


	case "$value" in
		yes)
			printf 'PasswordAuthentication:\t FAIL (%s)\n' "$value"
			;;
		no)
			printf 'PasswordAuthentication:\t OK (%s)\n' "$value"
			;;
		*)
			printf 'PasswordAuthentication:\t WARN Unrecognised value (%s)\n' "$value"
			;;
	esac

}


probe_max_auth_tries(){


	value=$(grep -i '^[[:space:]]*MaxAuthTries' "$CONFIG_FILE" \
                | awk '{print $2}' \
                | tail -n 1)


        if [ -z "$value" ]; then
                printf 'WARN Unable to retrieve MaxAuthTries. \n'
                return
        fi


        case "$value" in
                1|2|3|4)
                        printf 'MaxAuthTries:\t OK (%s)\n' "$value"
                        ;;
                5|6)
                        printf 'MaxAuthTries:\t WARN (%s)\n' "$value"
                        ;;
                *)
                        printf 'MaxAuthTries:\t FAIL Unrecognised value (%s)\n' "$value"
                        ;;
        esac

}

probe_root_login
probe_password_auth
probe_max_auth_tries
