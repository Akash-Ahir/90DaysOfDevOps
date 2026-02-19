# Day 04 - Linux Practice: Processes & Services

**Date:** February 19, 2026 | **Time:** 9:53 PM IST  
**System:** Ubuntu 24.04 LTS | **Chosen Service:** docker  
**Author:** AKASH AHIR

---

## Check Running Processes

### 1. Command: `ps aux | head -5`

<img width="867" height="132" alt="Screenshot 2026-02-19 210430" src="https://github.com/user-attachments/assets/f4047556-0d1c-42f2-b777-cac2d23f850e" />

**What it does:** Lists top 5 processes for ALL users with CPU/Memory usage  


### 2. Command: `top` (20s observation)
<img width="1066" height="505" alt="top" src="https://github.com/user-attachments/assets/006e4e70-2170-4457-8ba3-d1e264e3d954" />

**Purpose:** Real-time interactive monitoring (updates every 3s) 

---

## Inspect Service

### 1. Command: `systemctl list-units --type=service --state=running | head -10`
<img width="1552" height="617" alt="Screenshot 2026-02-19 210936" src="https://github.com/user-attachments/assets/e1575482-85bf-417e-b669-5f9e881be845" />
Purpose: Lists the top 10 RUNNING services on your systemd Linux system.

### 2. Command: `systemctl status docker`
Purpose: Shows detailed health status of the docker service

**Status:** ✅ **Active & Healthy**. 

---

## Log Checks

### 1. Command: `journalctl -u docker -n 15`
Purpose: Quick scan of most recent 15 Docker logs

### 2. Command: `journalctl -u docker --since today`
Purpose: All Docker logs from today 
<img width="1662" height="687" alt="log" src="https://github.com/user-attachments/assets/74265aae-873f-4d28-a474-6c97f1659825" />


---

## Troubleshooting Flow
<img width="1837" height="646" alt="troubleshooting" src="https://github.com/user-attachments/assets/38245d63-3315-4aa6-9b78-116904342c53" />




