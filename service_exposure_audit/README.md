#  Service Exposure Audit

## Overview
The script inspects which services are running and enabled on the system,
and which network ports are listening.


This tool is **audit-only**.  
It does **not** stop services, close ports, or modify system configuration.

---

## Objectives
- Enumerate running systemd services
- Identify services enabled at boot
- Detect listening TCP/UDP ports
- Highlight potentially high-risk exposed services
- Practice defensive Bash scripting and output parsing

---

## What the Script Audits

### 1. Active Services
- Lists services that are currently running
- Uses `systemctl` to query systemd state

### 2. Enabled Services
- Identifies services configured to start automatically at boot
- Helps spot unnecessary or forgotten services

### 3. Listening Network Ports
- Displays TCP and UDP ports currently listening
- Differentiates between:
  - Public bindings (`0.0.0.0`, `::`)
  - Local-only bindings (`127.0.0.1`, `::1`)

### 4. High-Risk Exposure Summary
Flags commonly targeted services if detected, such as:
- SSH (22)
- HTTP / HTTPS (80 / 443)
- Databases (3306, 5432)
- SMB (445)
- RDP (3389)

---

## Script Behavior
- Uses `systemctl` for service enumeration
- Uses `ss` (or equivalent) for network visibility
- Handles empty results gracefully
- Prints clear audit-style output
- Does **not** require configuration changes

---

## Usage

```bash
chmod +x service_exposure_audit.sh
bash service_exposure_audit.sh

