# System Snapshot Reporter

**AUTHOR:** Faarouq Asaju  
**DATE:** 03-12-2025

---

## Overview
`system_snapshot.sh` is a lightweight Linux system information reporter that collects essential system metadata such as hostname, OS, kernel version, logged-in users, disk usage, and memory statistics.  
This script serves as an introductory tool for building real DevSecOps and Linux automation skills.

---

## Features
- Captures timestamp and hostname  
- Detects OS name and kernel version  
- Lists logged-in users (deduplicated)  
- Summarizes disk usage (`df -h`)  
- Summarizes memory usage (`free -h`)  
- Appends each run to a persistent log file

---

## Installation and Usage

Save the script, make it executable and run it:
    chmod +x system_snapshot.sh
    ./system_snapshot.sh
Edit Variables to preffered destinations and so on
