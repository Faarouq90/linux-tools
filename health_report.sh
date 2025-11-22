#!/bin/bash
#Author: Faarouq Asaju
#Date: 21-11-2025
#Descr: An automated health-report tool that collects and logs real-time system diagnostics


DESTINATION="$HOME/logs"
TIMESTAMP="$(date '+%F +%T')"
        # Memory Stats
TOTALMEMORY=$(awk '/MemTotal/ {print $2}')
FREEMEMORY=$(awk '/MemFree/ {print $2}')
TOTALMEMORY=$(awk '/MemTotal/ {print $2}')
USEDMEMORY=$((TOTALMEMORY - FREEMEMORY))

{
	printf '%s\n'"============================"
	printf '\n Hostname: \n'
	hostname
	printf '\n Timestamp: %s\n' "$TIMESTAMP"
	printf '\n Current Working Directory : \n'
	pwd
	printf '\n Disk Usage: \n'
	df
	printf '\n\n Memory Stats\n'
	printf 'Total Memory: %s\n' "$TOTALMEMORY"
	printf 'Used Memory: %s\n' "$USEDMEMORY"
	printf 'Free Memory: %s\n' "$FREEMEMORY"

	
}
