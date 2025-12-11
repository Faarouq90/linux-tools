AUTHOR: FAAROUQ ASAJU


## Overview
`health_report.sh` is a comprehensive Linux diagnostic tool that gathers detailed system health information including memory, swap, CPU, logged-in users, and security-related events. Designed for operational monitoring, troubleshooting, and compliance use cases.

---

## Features
- Hostname and timestamp capture.
- Disk usage summary.
- Memory + swap statistics via `/proc/meminfo`.
- Top 5 CPU processes.
- Top 5 memory processes.
- Logged-in user sessions.
- Failed login attempt detection via `/var/log/auth.log`.
- Error log separation (`stderr → health_report.err`).
- Cron-compatible structure for scheduled usage.

---

## Requirements
- Bash shell 
- Utilities: `df`, `ps`, `head`, `grep`, `who`
- Read access to `/var/log/auth.log` (root required on most systems)
- Write access to `$HOME/logs` or `/var/log`

---

## Installation
Save the script and make it executable and run it:

```bash
chmod +x health_report.sh
./health_report.sh

