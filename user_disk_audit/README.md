# User & Disk Audit Tool

A Bash-based security auditing tool that inspects **local user accounts** and **filesystem disk usage** on a Linux system.  
Designed as part of a progressive DevSecOps learning path and as a building block toward a full **Linux Hardening & Compliance Scanner**.

---

##  Overview

This script performs two core audits:

### 1. User Audit
- Parses `/etc/passwd`
- Displays all local users in a formatted table
- Flags **suspicious user configurations**, including:
  - UID 0 accounts that are not `root`
  - Users with missing home directories
  - System accounts (UID ≤ 100) with interactive login shells (`/bin/bash`, `/bin/sh`)

### 2. Disk Audit
- Parses `df -P` 
- Displays filesystem usage in a readable table
- Detects filesystems exceeding a configurable usage threshold (default: 80%)

---

##  Requirements

- Linux system
- Bash (tested with Bash 5+)
- Standard utilities:
  - `awk`
  - `df`
  - `printf`

No external dependencies.

---

## ▶️ Usage

Make the script executable:

```bash
chmod +x user_disk_audit.sh
./user_disk_audit.sh to run

---

##  Configuration

DISK_THRESHOLD=80
