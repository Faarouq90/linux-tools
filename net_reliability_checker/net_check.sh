#!/bin/bash
#Author: Faarouq Asaju
#Date: 07-12-2025
#Descr: Checks whether a host is reachable via ping and optionally verifies if a specific TCP port is open.



HOST=$1
PORT=$2

if [ $# -eq 0 ]; then
	 echo "Argument is empty"
	 printf "Usage: %s <host> [port]\n" "$0"
	 exit 1
fi

#-------------------- Functions ----------------------------

check_host_reachable(){
	local host="$1"
	
	if  ping -c 3 -W 2 "$host" >/dev/null 2>&1;then
		printf 'Host: %s	OK\n' "$host"
		return 0
	else
		printf 'Host: %s	FAILED\n' "$host"
		return 1
	fi
}

check_port_open(){
	local host="$1"
	local port="$2"

	if  nc -z -w 3 "$host" "$port" >/dev/null 2>&1; then
		printf 'Port %s on %s    OK\n' "$port" "$host"
		return 0
	else
		printf 'Port %s on %s    Failed\n' "$port" "$host"
		return 1

	fi	
}

#--------------------- Main Body -----------------------------



if [ $# -eq 1 ]; then
	check_host_reachable "$HOST"
	exit $?
elif [ $# -eq 2 ]; then
	check_host_reachable "$HOST"
	host_status=$?
	
	if [ "$host_status" -ne 0 ]; then
		printf 'Port %s on %s skipped (Host Unreachable) \n' "$PORT" "$HOST"
		exit 1
	fi

	check_port_open "$HOST" "$PORT"
	port_status=$?

	if [ "$port_status" -eq 0 ]; then
		
		exit 0
	else
		exit 1
	fi
else
	printf 'Usage: %s <host> [port]\n' "$0"
	exit 1
fi


