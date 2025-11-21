#!/usr/bin/env bash
# process_monitor.sh - logs top 5 CPU & memory processes
# Author: Faarouq
# Date: 2025-10-20

LOGFILE="$HOME/process_monitor.log"   
TIMESTAMP="$(date '+%F %T')"

{
  printf '%s\n' "======================="
  printf 'Timestamp: %s\n' "$TIMESTAMP"
  printf '\nTop 5 CPU-Consuming Processes:\n'
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

  printf '\nTop 5 Memory-Consuming Processes:\n'
  ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6
  printf '%s\n\n' "======================="
} >> "$LOGFILE"

