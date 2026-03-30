# Day 28 – Revision Day: Everything from Day 1 to Day 27
**Date**: March 29, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-28)

## Task Overview

You've covered a lot of ground in 27 days — DevOps fundamentals, Linux deep dives, Shell scripting, Python basics, Git & GitHub, and even your developer branding. Today, **stop and revise**. No new concepts. Just solidify what you've learned.

The goal is to identify gaps, revisit topics you struggled with, and make sure you can confidently explain and use everything covered so far.

---

## What You've Covered So Far

| Days | Topic | Key Concepts |
|------|-------|-------------|
| 1 | DevOps & Cloud Intro | What is DevOps, SDLC, Cloud basics |
| 2–7 | Linux Fundamentals | Architecture, commands, processes, systemd, file system hierarchy, troubleshooting, text files |
| 8 | Cloud Server Setup | Docker, Nginx, web deployment |
| 9–11 | Users, Permissions & Ownership | User/group management, file permissions, chown/chgrp |
| 12 | Revision Day 1 | Days 1–11 recap |
| 13 | Volume Management | LVM — physical volumes, volume groups, logical volumes |
| 14–15 | Networking | Fundamentals, DNS, IP, subnets, ports, hands-on checks |
| 16–18 | Shell Scripting | Basics, loops, arguments, error handling, functions |
| 19–20 | Shell Scripting Projects | Log rotation, backup, crontab, log analyzer |
| 21 | Shell Scripting Cheat Sheet | Personal reference guide |
| 22–25 | Git & GitHub | Init, branching, merge, rebase, stash, cherry pick, reset, revert, branching strategies |
| 26 | GitHub CLI | Managing GitHub from the terminal |
| 27 | GitHub Profile | Profile README, repo organization, developer branding |

---

## Challenge Tasks

## Task 1: Self-Assessment Checklist
Go through the checklist below. For each item, mark yourself honestly:
- **Can do confidently**
- **Need to revisit**
- **Haven't done yet**

#### Linux
- [x] Navigate the file system, create/move/delete files and directories
- [x] Manage processes — list, kill, background/foreground
- [x] Work with systemd — start, stop, enable, check status of services
- [x] Read and edit text files using vi/vim or nano
- [x] Troubleshoot CPU, memory, and disk issues using top, free, df, du
- [x] Explain the Linux file system hierarchy (/, /etc, /var, /home, /tmp, etc.)
- [x] Create users and groups, manage passwords
- [x] Set file permissions using chmod (numeric and symbolic)
- [x] Change file ownership with chown and chgrp
- [x] Create and manage LVM volumes
- [x] Check network connectivity — ping, curl, netstat, ss, dig, nslookup
- [x] Explain DNS resolution, IP addressing, subnets, and common ports

#### Shell Scripting
- [x] Write a script with variables, arguments, and user input
- [x] Use if/elif/else and case statements
- [x] Write for, while, and until loops
- [x] Define and call functions with arguments and return values
- [x] Use grep, awk, sed, sort, uniq for text processing
- [x] Handle errors with set -e, set -u, set -o pipefail, trap
- [x] Schedule scripts with crontab

#### Git & GitHub
- [x] Initialize a repo, stage, commit, and view history
- [x] Create and switch branches
- [x] Push to and pull from GitHub
- [x] Explain clone vs fork
- [x] Merge branches — understand fast-forward vs merge commit
- [x] Rebase a branch and explain when to use it vs merge
- [x] Use git stash and git stash pop
- [x] Cherry-pick a commit from another branch
- [x] Explain squash merge vs regular merge
- [x] Use git reset (soft, mixed, hard) and git revert
- [x] Explain GitFlow, GitHub Flow, and Trunk-Based Development
- [x] Use GitHub CLI to create repos, PRs, and issues

---

## Task 2: Revisit Your Weak Spots
  [Networking] 
  -Revised OSI/TCPIP
  -CIDR REVISED
  [SHELL SCRIPT Revised]

---

## Task 3: Quick-Fire Questions
Answer these from memory (no Googling). Then verify your answers:

1. What does `chmod 755 script.sh` do?
```
give permission
-USER= read,write,execute
-group= Read ,Execute
-others= Read,Execute
```
3. What is the difference between a process and a service?
  ```
A **process** is a running program instance like `nginx`
A **service** is a managed process controlled by systemd that can be started, stopped, enabled, and restarted automatically after boot.
  ```

4. How do you find which process is using port 8080?
  ```
`sudo netstat -tulnp | grep 8080
  ```


5. What does `set -euo pipefail` do in a shell script?
   ```
    `set -e`: exits immediately if any command fails.
    `set -u`: exits if an undefined variable is used.
    `set -o pipefail`: makes the script exit if any command in a pipeline fails.
   ```

6. What is the difference between `git reset --hard` and `git revert`?
  ```
  `git reset --hard`-destroys changes, reverting all files to a previous commit
  `git revert`- revert act as an undo for a commit
  ```
7. What branching strategy would you recommend for a team of 5 developers shipping weekly?
  ```
  GitHub Flow
  ```

8. What does `git stash` do and when would you use it?
  ```
  saves your current uncommitted changes and switch branch 
  if some hotfix which need to be fixed urgently at that time i use it and switch to fix that problem and once it get done i come back and run pop and resume my work
  ```

9. How do you schedule a script to run every day at 3 AM?
  ```
  0 3 * * *
  ```

10. What is the difference between `git fetch` and `git pull`?
  ```
  `git fetch`- get changes of remote but not merged it
  `git pull` - Get changes + Merged it 
  ```

11. What is LVM and why would you use it instead of regular partitions?
  ```
  We can resize it whenever we needed it flexiable and combine multiple disk whenever needed and create a one big volume 
  ```


---

## Task 4: Organize Your Work
- [x] Make sure all your daily submissions (day-1 through day-27) are committed and pushed 
- [x] Check that your `git-commands.md` is up to date
- [x] Check that your shell scripting cheat sheet is complete
- [x] Verify your GitHub profile and repos are clean (from Day 27)

---

## Task 5: Teach It Back
Imagine you and your friends are building a small project together like a WhatsApp group plan for a weekend trip. The main plan is stored in the main branch it has the final date, budget, and destination everyone agrees on.
Now, one friend wants to suggest a new trip to the hills instead of the beach. Instead of changing the main plan directly he creates a branch like a private group chat where they can discuss and tweak the hills trip idea. In this branch they can add new stops, change the budget, and try out different options without touching the original plan.
Once the group likes the new idea, they merge the branch into main, updating the final plan with the new trip details. If they don’t like it, they can simply close that branch (quit that group chat), and the original plan stays safe and unchanged.
In this way Git branches let different people try new ideas safely and only bring in the changes everyone agrees on.

---

