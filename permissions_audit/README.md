# File Permission & Security Audit Tool

A Bash-based Linux security auditing script that inspects **file and directory permissions** to identify common misconfigurations that may lead to privilege escalation or unauthorized access.


---

##  Purpose

The goal of this script is **auditing**, not hardening.

It:
- Inspects the current system state
- Identifies risky permission configurations
- Reports findings clearly


---

## 🔍 What the Script Audits

### 1. World-Writable Directories
Detects directories where **any user** can write files.

Why this matters:
- Can be abused for persistence
- Can be used for privilege escalation
- Often indicates misconfiguration


---

### 2. World-Writable Files
Detects files writable by all users.

Why this matters:
- Allows tampering with application or system files
- May lead to code execution or data corruption

---

### 3. Critical System File Permissions
Checks expected permissions on sensitive files:

| File | Expected Permissions |
|----|----|
| `/etc/passwd` | `644` |
| `/etc/shadow` | `600` |
| `/etc/group` | `644` |
| `/etc/sudoers` | `440` |

Any deviation is reported as a finding.

---

### 4. SUID / SGID Binaries
Lists binaries with:
- SUID bit set
- SGID bit set

These binaries can execute with elevated privileges and must be reviewed carefully.

---

## ▶️ Usage

Make the script executable:

```bash
chmod +x permission_audit.sh

Run the audit: 

```bash
./permission_audit.sh


