# Linux Troubleshooting Runbook - Docker Daemon
**Target Service: Docker Daemon** | **Date: Feb 20, 2026** | **System: Ubuntu 22.04 AWS EC2**

---

##  **Purpose**
Docker daemon runs all containers. When it fails → **no apps work**! This runbook captures evidence systematically before fixes.

---

##  **Checklist Structure**


---

## 1. **Environment Basics**

### Command 1: `uname -a`
**Purpose:** Kernel compatibility check  
**Observation:**  Modern kernel, Docker supported

### Command 2: `cat /etc/os-release`  
**Purpose:** Distro verification
**Observation:**  Docker's preferred OS

---

## 2. **Filesystem Sanity**

### Command 3: `mkdir /tmp/docker-demo && cp /etc/hosts /tmp/docker-demo/hosts-copy && ls -l /tmp/docker-demo`
**Purpose:** Test Docker storage writes
**Observation:**  Filesystem writable

### Command 4: `df -h`
**Purpose:** Disk space for Docker images
**Observation:**  85G free (10+ images capacity)

---

## 3. **CPU & Memory**

### Command 5: `docker stats`
**Purpose:** Container resource usage
**Observation:**  Daemon healthy, no containers running

### Command 6: `free -h`
**Purpose:** System RAM availability
**Observation:**  5.2Gi available, no swap risk

---

## 4. **Disk & IO**

### Command 7: `du -sh /var/lib/docker/* | head -5`
**Purpose:** Docker storage growth
**Observation:**  Normal sizes, no bloat

### Command 8: `docker system df`
**Purpose:** Docker-specific disk usage
**Output:** (From your screenshot - low usage)
**Observation:**  Healthy storage

---

## 5. **Network**

### Command 9: `ss -tulpn | grep docker`
**Purpose:** Security - exposed ports?
**Observation:**  Secure! Uses Unix socket only

### Command 10: `ls -l /var/run/docker.sock`
**Purpose:** Daemon communication pipe
**Observation:**  Socket active & accessible

---

## 6. **Logs**

### Command 11: `journalctl -u docker.service -n 50`
**Purpose:** Recent daemon activity
**Observation:**  Clean startup, no errors

### Command 12: `systemctl status docker`
**Purpose:** Service health overview
**Observation:**  Stable uptime

---

## 📊 **Health Summary**

| Area | Status | Key Metric |
|------|--------|------------|
| CPU | 🟢 | 0.0% dockerd |
| Memory | 🟢 | 5.2Gi available |
| Disk | 🟢 | 85% free |
| Network | 🟢 | Secure socket |
| Logs | 🟢 | No errors |

**Verdict:** Docker daemon **PRODUCTION READY** 

---

##  **Escalation Plan - If Worsens**

| Issue | **Step 1** | **Step 2** | **Step 3** |
|-------|------------|------------|------------|
| **High CPU** | `docker stats --no-stream` | `docker system prune -a` | `systemctl restart docker` |
| **Disk Full** | `docker system df` | `docker image prune -a` | Check volumes |
| **Won't Start** | `journalctl -u docker -f` | `dockerd --debug` | `strace -p PID` |

---




---

