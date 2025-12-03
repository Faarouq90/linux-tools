## AUTHOR: FAAROUQ ASAJU


## Process Monitor Script (process_monitor.sh)

## Overview
`process_monitor.sh` is an automated monitoring tool that logs the top CPU- and memory-consuming processes on a Linux system. It is designed to run manually or on a schedule (e.g., via cron) and is useful for performance diagnostics and system health auditing.

---

## Features
- Logs the top 5 CPU-consuming processes.
- Logs the top 5 memory-consuming processes.
- Automatically timestamps each entry.
- Appends data to a persistent log file.
- Supports cron-based automated execution.

---

## Requirements
- Bash shell (`/bin/bash`)
- Linux utilities: `ps`, `head`, `date`, `tee` (optional)
- Permission to write to the chosen log directory.

---

## Installation
Place the script anywhere and make it executable
To manually run, use ./process_monitor.sh



