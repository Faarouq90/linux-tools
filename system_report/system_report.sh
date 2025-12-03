#!/bin/bash
#Author: Faarouq Asaju
#Date: 23-10-2025
#Descr: Shows Current Timestamp, Current system uptime, Disk usage, Top 5 CPU and Memory consuming processes


Timestamp=$(date '+%F +%T')
Destination="$HOME/logs/system_report.log"

{
	printf '\n%s\n' "=========================="
	printf 'Timestamp:%s\n' "$Timestamp"
	
	printf '\nCurrent uptime: \n'
	uptime

	printf '\nCurrent Disk Usage:\n '
        df -h

	printf '\nTop 5 CPU-consuming processes: \n'
	ps -eo pid,comm,%cpu,%mem --sort=%cpu | head -n 6

	printf '\nTop 5 Memory-consuming processes: \n'
        ps -eo pid,comm,%cpu,%mem --sort=%mem | head -n 6


	printf '\n%s\n' "=========================="

	
}>> "$Destination"
