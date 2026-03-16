# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Task
Done with the log rotaion and backup creation with shell script an dschedualing crontab
## Challenge Tasks

### Task 1: Log Rotation Script
Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist
### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-19/scripts/log_rotate.sh)
![alt text](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-19/output/task%201%20output.png?raw=true)



---

### Task 2: Server Backup Script
Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist

![alt text](https://github.com/akashahir50/90DaysOfDevOps/blob/eb16790d4e7a608e3244bc888da3274f2ee5220e/2026/day-19/output/task%202%20output.png)


### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-19/scripts/backup.sh)
---

### Task 3: Crontab
1. Read: `crontab -l` — what's currently scheduled?
2. Understand cron syntax:
   ```
   * * * * *  command
   │ │ │ │ │
   │ │ │ │ └── Day of week (0-7)
   │ │ │ └──── Month (1-12)
   │ │ └────── Day of month (1-31)
   │ └──────── Hour (0-23)
   └────────── Minute (0-59)
   ```
3. Write cron entries (in your markdown, don't apply if unsure) for:
   - Run `log_rotate.sh` every day at 2 AM : 0 2 * * *
   - Run `backup.sh` every Sunday at 3 AM : 0 3 * * 0
   - Run a health check script every 5 minutes : */5 * * * *

---

### Task 4: Combine — Scheduled Maintenance Script
Create `maintenance.sh` that:
1. Calls your log rotation function
2. Calls your backup function
3. Logs all output to `/var/log/maintenance.log` with timestamps
4. Write the cron entry to run it daily at 1 AM

![alt text](https://github.com/akashahir50/90DaysOfDevOps/blob/eb16790d4e7a608e3244bc888da3274f2ee5220e/2026/day-19/output/task%204%20output.png)


### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-19/scripts/maintenance.sh)
---



