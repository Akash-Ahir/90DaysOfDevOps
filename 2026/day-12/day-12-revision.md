
# Day 12 – Breather & Revision (Days 01–11)
**Date**: February 28, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/)

## Task Overview
Quick revision of Days 01-11 Linux fundamentals 


## Mindset & plan:
On Day 01, I made a clear roadmap for my DevOps journey, including how I'd do it step by step. So far, I'm on the right track and making good progress each day. From Days 01 to 11, I've learned interesting facts, gained solid knowledge, and cleared up my early doubts.
## Processes & services:
1. `ps aux | head -10`
<br/>Shows all running processes with CPU/memory usage - perfect for spotting resource-heavy apps during troubleshooting.System running healthy with normal background services.
2. `systemctl status ssh`
 <br/>Checks service health, quick way to verify if critical services like SSH are active/running.
SSH service active (running) no errors in recent logs.

## File skills: practice 3 quick ops from Days 06–11
1. `echo "DevOps log entry" >> ~/day12-test.log`
<br/>Appends text to file without overwriting. Safe way to build logs/audit.
File created successfully. cat ~/day12-test.log shows "DevOps log entry" added.

2. `chmod 755 ~/script-test.sh`
<br/>Sets executable permissions for owner rwx, group rx  and others rx. Makes scripts runnable securely.
`ls -l ~/script-test.sh` now shows -rwxr-xr-x. Can run ./script-test.sh without "permission denied"

3. `sudo chown $USER:group ~/day12-test.log`
<br/>Changes file ownership to current user + group. 
ls -l ~/day12-test.log confirms ownership:ubuntu users

## Cheat sheet refresh: skim your Day 03 commands—highlight 5 you’d reach for first in an incident:
  1. `df -h`
    Instant disk space check. Catches "No space left" errors before they crash services.
  2. `top / htop`
   Live CPU/memory view. Spots which processes eating resources immediately.
  3. `ps aux | grep <service>`
    Confirms if critical service is actually running PID/process check.
  4. `systemctl status <service>` 
    One-command service health check active? errors? recent logs?.
  5. `journalctl -u <service> -n 20`
    Last 20 log lines for any service. Finds error messages with timestamps fast

## User/group sanity: recreate one small scenario from Day 09 or Day 11 (create a user or change ownership) and verify with id/ls -l.
### 1. Create new user 
```
sudo useradd -m akash-2
```
### 2. Create test directory
```
sudo mkdir /akash-test
```
### 3. Change ownership to new user
```
sudo chown devops_user:akash-2 /akash-test
```
### 4. Verify with id + ls -l
```
id akash-2
```
```
ls -ld /akash-test
```

## Mini Self-Check 
1. Which 3 commands save you the most time right now, and why?<br/>
`ps aux | grep <service>` - Instantly confirms if service is running and its mem and cpu usages.<br/>
`systemctl status <service>` - One-shot service health + recent logs<br/>
`df -h` - Catches disk full issues before they crash<br/>

2. How do you check if a service is healthy? Exact 2-3 commands:
   `systemctl is-active <service>`
   `systemctl status <service>`
   `journalctl -u <service> -n 20`
3. How do you safely change ownership and permissions? Example command:
   ```
    sudo chown -R user:group /path && chmod -R 755 /path

   ```
4. What will you focus on improving in the next 3 days?
  <br/>  Weekly revision practice - Schedule a revision day on every week. to revisit these fundamentals so everything stays fresh and recallable instantly<br/>
  <br/>  Hands-on Linux volumes - Master mounting, LVM, disk management <br/>
  <br/>  Linux networking concepts - ip addr, ss -tuln, iptables basics for service connectivity<br/>
   
