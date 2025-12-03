#!/bin/bash
#Author: Faarouq Asaju
#Date: 21-11-2025
#Descr: An automated health-report tool that collects and logs real-time system diagnostics


DESTINATION="$HOME/logs/health_report.log"
TIMESTAMP="$(date '+%F %T')"
ERRORLOG="$HOME/logs/health_report.err"
        # Memory Stats
TOTALMEMORY=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
FREEMEMORY=$(awk '/MemFree/ {print $2}' /proc/meminfo)
TOTALMEMORY=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
USEDMEMORY=$((TOTALMEMORY - FREEMEMORY))
	#Swap Stats
TOTALSWAP=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
FREESWAP=$(awk '/SwapFree/ {print $2}' /proc/meminfo)
USEDSWAP=$((TOTALSWAP - FREESWAP))

{
	printf '%s\n'"============================"
	printf '\n Hostname: '
	hostname
	printf '\n Timestamp: %s' "$TIMESTAMP"
	printf '\n Current Working Directory : '
	pwd
	printf '\n Disk Usage: \n'
	df -h
	printf '\n\n Memory Stats (kB)\n'
	printf 'Total Memory: %s\n' "$TOTALMEMORY"
	printf 'Used Memory: %s\n' "$USEDMEMORY"
	printf 'Free Memory: %s\n' "$FREEMEMORY"
	printf '\n\n Swap Stats (kB)\n'
	printf 'Total Swap: %s\n' "$TOTALSWAP"
        printf 'Used Swap: %s\n' "$USEDSWAP"
        printf 'Free Swap: %s\n' "$FREESWAP"
	printf '\n\n Top 5 Memory-consuming processes \n'
	ps -eo pid,comm,%mem --sort=-%mem | head -n 6
        printf '\n\n Top 5 CPU-consuming processes \n'
	ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
	printf '\n\n Current Logged in Users \n'
	who
	printf '\n \n Failed Login Attempts\n'
	grep -Ei "failure|error|invalid" /var/log/auth.log 2>/dev/null || echo "No failed login attempt found"
	


} >>$DESTINATION 2>>"$ERRORLOG"
