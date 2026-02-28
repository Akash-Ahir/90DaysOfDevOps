# Day 11 – File Ownership Challenge (chown & chgrp)
**Date**: February 28, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-11)
## Task Overview
 Learn to control who owns files/directories.
 Every Linux file has one owner and one group output.

## Files Created
- devops-file.txt
- team-notes.txt
- project-config.yaml
- app-logs/
- heist-project/ (plans, vault)
- bank-heist/ (access-codes.txt, blueprints.pdf, escape-plan.txt)

## Ownership Changes
| File/Dir | Before | After |
|----------|--------|-------|
| devops-file.txt | ubuntu:ubuntu | berlin:ubuntu |
| team-notes.txt | ubuntu:ubuntu | ubuntu:heist-team |
| project-config.yaml | ubuntu:ubuntu | professor:heist-team |
| heist-project/ | ubuntu:ubuntu | professor:planners  |
| bank-heist/access-codes.txt | ubuntu:ubuntu | tokyo:vault-team |

---

## Challenge Tasks

### Task 1: Understanding Ownership 

1. View owner,group for all files
```
ls -l
```
<img width="693" height="130" alt="1" src="https://github.com/user-attachments/assets/97e43b7c-0659-46e8-b59c-cfadf0548c40" /><br>

2. Identifies the **owner=3 columns** and **group=4 columns** 
3. Ubuntu user owns my files
4.  Owner is the user who created/owns it has full control. Group shares access with multiple users.
 ---

### Task 2: Basic chown Operations 

1. Creating file devops-file.txt
```
touch devops-file.txt
```
2. Checking current owner
 ```
ls -l devops-file.txt
```
3. Creating user `tokyo`
```
sudo useradd -m tokyo
```
4. Change owner to `tokyo`
```
sudo chown tokyo devops-file.txt
```
5. Creating user `berlin`
```
sudo useradd -m berlin
```
6. Change owner to `berlin`
```
sudo chown berlin devops-file.txt
```
7. Verify the changes
```
ls -l devops-file.txt
```
<img width="753" height="312" alt="2" src="https://github.com/user-attachments/assets/ac6eaea2-107f-4eca-a86c-82089f9389c7" /><br/>

---

### Task 3: Basic chgrp Operations 

1. Creating file `team-notes.txt`
```
touch team-notes.txt
```
2. Checking current group
```
ls -l team-notes.txt
```

3. Creating group
```
sudo groupadd heist-team
```
4. Change file group to `heist-team`
```
sudo chgrp heist-team team-notes.txt
```
5. Verify the change
```
ls -l team-notes.txt
```
<img width="652" height="200" alt="3" src="https://github.com/user-attachments/assets/050cad33-677b-4ce9-931b-3fe0ed8419c2" /><br/>

---
### Task 4: Combined Owner & Group Change 


1. Creating file `project-config.yaml`
```
touch project-config.yaml
```
2. adding user `professor`
```
sudo useradd -m professor  
```

3. Change owner to `professor` AND group to `heist-team`
```
sudo chown professor:heist-team project-config.yaml
```
4. Create directory `app-logs/`
```
mkdir app-logs
```
5. Change its owner to `berlin` and group to `heist-team`
```
sudo chown berlin:heist-team app-logs
```
<img width="790" height="332" alt="4" src="https://github.com/user-attachments/assets/719e2368-bd33-49ff-be69-461910158b17" /><br/>

---

### Task 5: Recursive Ownership 

1. Creating directory structure
   ```
   mkdir -p heist-project/vault
   ```
   ```
   mkdir -p heist-project/plans
   ```
   ```
   touch heist-project/vault/gold.txt
   ```
   ```
   touch heist-project/plans/strategy.conf
   ```

2. Creating group `planners`
```
sudo groupadd planners
```
3. Change ownership of entire `heist-project/` directory:
   - Owner: `professor`
   - Group: `planners`
   - Use recursive flag (`-R`)
```
sudo chown -R professor:planners heist-project/
```

4. Verify all files and subdirectories changed
```
ls -lR heist-project/
```
<img width="865" height="651" alt="5" src="https://github.com/user-attachments/assets/4e3a2e55-a0c3-4869-8df6-4fbc735a1779" /><br/>

---

### Task 6: Practice Challenge 

1. Created users:`nairobi`
```
sudo useradd -m nairobi
```
2. Creating groups: `vault-team`, `tech-team`
```
sudo groupadd vault-team tech-team
```
3. Create directory: `bank-heist/`
```
mkdir bank-heist
```
4. Create 3 files inside:
   ```
   touch bank-heist/access-codes.txt
   touch bank-heist/blueprints.pdf
   touch bank-heist/escape-plan.txt
   ```

5. Set different ownership:
 
- `access-codes.txt` → owner: `tokyo`, group: `vault-team` 
```
sudo chown tokyo:vault-team bank-heist/access-codes.txt

```

- `blueprints.pdf` → owner: `berlin`, group: `tech-team`
```
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```

- `escape-plan.txt` → owner: `nairobi`, group: `vault-team`
 ```
  sudo chown nairobi:vault-team bank-heist/escape-plan.txt
 ```

**Verify:** 
```
ls -l bank-heist/
```
<img width="972" height="427" alt="6" src="https://github.com/user-attachments/assets/063b4d83-751e-4feb-8e67-5dd6f4975f89" /><br/>

---


## Why This Matters for DevOps

In real DevOps scenarios, you need proper file ownership for:

- Application deployments
- Shared team directories
- Container file permissions
- CI/CD pipeline artifacts
- Log file management

---
## What I Learned
### • **Owner vs Group**: Owner=primary control, Group=team sharing
### • **`chown user:group`** changes both in 1 command
### • **`-R` flag**: Recursively updates directories + ALL contents inside
### • **Pre-requisite**: Users/groups must exist first (`useradd`, `groupadd`)
### • **`ls -l` decoding**: Owner=3rd column, Group=4th column always



## Commands Used
```bash
ls -l ~
```
```
touch devops-file.txt
```
```
ls -l devops-file.txt  
```
```
sudo useradd -m tokyo berlin 
```
```
sudo chown tokyo devops-file.txt
```
```
ls -l devops-file.txt  
```
```
sudo chown berlin devops-file.txt  
```
```
touch team-notes.txt
```
```
sudo groupadd heist-team
```
```
sudo chgrp heist-team team-notes.txt
```
```
ls -l team-notes.txt
```
```
touch project-config.yaml
```
```
sudo useradd -m professor  
```
```
sudo chown professor:heist-team project-config.yaml
```
```
mkdir app-logs
```
```
sudo chown berlin:heist-team app-logs
```
```
ls -l project-config.yaml app-logs
```
```
mkdir -p heist-project/ vault, plans
```
```
touch heist-project/vault/gold.txt heist-project/plans/strategy.conf
```
```
sudo groupadd planners
```
```
sudo chown -R professor:planners heist-project/
```
```
ls -lR heist-project/
```
```
sudo useradd -m nairobi 
```
```
sudo groupadd vault-team tech-team
```
```
mkdir bank-heist
```
```
touch bank-heist/access-codes.txt  blueprints.pdf escape-plan.txt
```
```
sudo chown tokyo:vault-team bank-heist/access-codes.txt
```
```
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```
```
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```
```
ls -l bank-heist/
```
#etc
```
