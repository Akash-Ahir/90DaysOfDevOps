
# Day 02 - Linux Architecture, Processes & systemd

![Linux Architecture](https://github.com/user-attachments/assets/ef3ebdcb-ace8-403c-8de1-0651f55fd2c0)

## Linux Architecture


**What each layer does:**
- **Applications**: User programs like Docker, VSCode, web browsers
- **Shell**: Interactive interface using CLI commands (Bash/ssh) to talk to kernel
- **Kernel**: Core program written in C, compiled to binary. **Controls/Communicates** with all hardware
- **Hardware**: Physical components (CPU, monitor, keyboard, etc.)



##  5 Daily Essential Commands

| Command | Purpose |
|---------|---------|
| `touch/mkdir` | Create files/directories | 
| `cp/rm/mv` | Copy/Delete/Move | 
| `ip addr` | Show shiow ip address |
| `ping` | To Ping a website | 
| `free -h` | Memory/disk usage | 

##  systemd & Process Management

### What is systemd?
systemd is a system and service manager for Linux operating systems. When run as first process on boot (as PID 1), it acts as init system that brings up and maintains userspace services. Separate instances are started for logged-in users to start their services.
it is helpful when we want to start or stop a particular process or service.

### Process Management Commands
```bash

ps aux # shows all processes running
ps -a # shows only active processes
top # The top program provides a dynamic real-time view of a running system. It can display system summary information as well as a list of processes or threads currently being managed by the Linux kernel.
ps aux | grep <process name> # it will find the specific process from the list of processes
kill <process id> # it is used to stop the specific process
systemctl start  <service name> # to start the services
systemctl status <service name > # to get the status of services
