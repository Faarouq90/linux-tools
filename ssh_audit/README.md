# SSH Configuration Audit

## Overview
This tool implements an **audit-only SSH configuration scanner** using Bash.  
The script inspects the SSH server configuration (`sshd_config`) and reports
whether key security-related settings are configured safely.

**This tool does NOT modify any system configuration.**  
It is read-only and safe to run on any Linux system.

---

## Objectives
- Practice parsing real-world configuration files in Bash
- Learn how to safely extract and evaluate config values
- Implement the **probe → fix** pattern (probe only in this lab)
- Produce clear, audit-style output (OK / WARN / FAIL)

---

## What the Script Audits
The script checks the following SSH server settings:

1. **PermitRootLogin**
   - Detects whether root login is allowed over SSH

2. **PasswordAuthentication**
   - Checks if password-based SSH authentication is enabled

3. **MaxAuthTries**
   - Evaluates how many failed login attempts are allowed per connection

4. **LoginGraceTime**
   - Checks how long a client can remain connected before authenticating

Each setting is classified as:
- **OK** — Secure or recommended value
- **WARN** — Missing or weak but not critical
- **FAIL** — Insecure configuration

---

## Script Behavior
- Reads `/etc/ssh/sshd_config`
- Ignores commented lines
- Uses the *effective* (last) value if a setting appears multiple times
- Handles missing configuration keys safely
- Does **not** restart or reload SSH
- Does **not** edit any files

---

## Usage

```bash
bash ssh_audit.sh

