

# Day 09 – Linux User & Group Management Challenge
**Date**: February 23, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-09)

## Task Overview
Understand and Practice Linux user and group management - created 4 users, 3 groups, and 2 shared directories with proper team permissions (775). Tested collaborative access across different team role.

• Created users: tokyo, berlin, professor, nairobi with home directories

• Built groups: developers, admins, project-team  

• Configured shared directories: /opt/dev-project, /opt/team-workspace

• Verified group permissions with `sudo -u username` testing

• Learned critical `-aG` flag for group setting

This is exactly how DevOps manages server access control.

---


## Users & Groups Created
**Users:** tokyo, berlin, professor, nairobi  
**Groups:** developers, admins, project-team

## Group Assignments
| User     | Groups                  |
|----------|-------------------------|
| tokyo    | developers, project-team|
| berlin   | developers, admins      |
| professor| admins                  |
| nairobi  | project-team            |

## Directories Created
| Directory         | Group         | Permissions |
|-------------------|---------------|-------------|
| /opt/dev-project  | developers    | 775 (rwxrwxr-x) |
| /opt/team-workspace | project-team | 775 (rwxrwxr-x) |

## Commands Used (detailed attached at end of file )
```bash
# User creation
sudo useradd -m username && sudo passwd username
```
### Group management  
```
sudo groupadd groupname
sudo usermod -aG groupname username
```
### Directory permissions
```
sudo mkdir /path
sudo chgrp groupname /path
sudo chmod 775 /path
```
### Verify
groups username
```
ls -ld /path
```
---
---
## Part 1: Created Users

### 1) Create users with `-m` flag creates home directory automatically
```bash
sudo useradd -m tokyo
sudo useradd -m berlin  
sudo useradd -m professor
```
<img width="668" height="72" alt="user add" src="https://github.com/user-attachments/assets/d05e0a3c-fc61-4a6b-8006-4c2dae3738af" /><br/>

### 2) Set passwords for all users
```bash
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
```
For enables SSH login and sudo access for users

<img width="536" height="287" alt="seeting password" src="https://github.com/user-attachments/assets/96a2fa16-46eb-41c8-bda5-eb7e3d129372" /><br/>


### 3) Verify users created successfully
```
tail -5 /etc/passwd
ls -la /home/

```
<img width="722" height="172" alt="verifyiing user" src="https://github.com/user-attachments/assets/c70a58ec-6291-4043-9882-ec0f0c8f03d5" /><br/>

<img width="777" height="266" alt="users and their permission" src="https://github.com/user-attachments/assets/967e0900-1364-4238-a3f0-5f0d5b9f637c" /><br/>


## Part 2: Create Groups & Assign Users
### 1) Create team groups

```
sudo groupadd developers
sudo groupadd admins
```



### 2) Assign users to groups 
```
sudo usermod -aG developers tokyo
sudo usermod -aG developers,admins berlin  
sudo usermod -aG admins professor
```
"-a" flag PREVENTS removing user from primary group.

### 3) Verify group membership
```
tail -3 etcc/group

```
<img width="645" height="212" alt="group add and verify" src="https://github.com/user-attachments/assets/906b8d5c-fa86-4783-813a-f6504850c212" /><br/>


##  Part 3: Developers Shared Directory
### 1) Create shared project directory
```
sudo mkdir /opt/dev-project

```

### 2) Set group ownership to developers + 775 permissions
```
sudo chgrp developers /opt/dev-project
sudo chmod 775 /opt/dev-project

```


### 3) Verify permissions
```
ls -ld /opt/dev-project

```

<img width="797" height="153" alt="creating directory asso to grp chnge permision show permision" src="https://github.com/user-attachments/assets/eb438b73-0f04-4c5b-a3c7-8b7e508a6115" /><br/>



### 4) Test group access
```
sudo -u tokyo touch /opt/dev-project/tokyo-test.txt
sudo -u berlin touch /opt/dev-project/berlin-test.txt
sudo -u professor touch /opt/dev-project/professor-test.txt 

```

<img width="1135" height="155" alt="denied the creation of file by professor" src="https://github.com/user-attachments/assets/9d681ff0-af4e-4639-ab2b-4d945fd5ef1b" /><br/>

## Part 4: Team Workspace Setup
### 1) Create nairobi user and project-team group
 ```
sudo useradd -m nairobi
sudo passwd nairobi
sudo groupadd project-team
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

 ```

### 2) Create team workspace
```
sudo mkdir /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

```

### 3) Test team access
```
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt
sudo -u tokyo touch /opt/team-workspace/tokyo-file.txt
ls -l /opt/team-workspace/

```

<img width="1013" height="462" alt="team work spac" src="https://github.com/user-attachments/assets/9a1d33e5-2b16-4d5b-94cb-99578237cae7" /><br/>


---

## Commands Used 

## 1. User Creation
```
sudo useradd -m tokyo
sudo useradd -m berlin  
sudo useradd -m professor
sudo useradd -m nairobi
```
## 2. Set passwords
```
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
sudo passwd nairobi
```
## 3. Verify creation
```
tail -5 /etc/passwd
ls -la /home/
```
## 4. Create groups
 ```
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team

 ```
## 5. verify groups
```
tail -3 /etc/group
```
## 6. Group Management  
```
sudo usermod -aG developers tokyo
sudo usermod -aG developers berlin
sudo usermod -aG admins berlin
sudo usermod -aG admins professor
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```
## 7. Permission settings
```
sudo chmod 775 /opt/dev-project
sudo chmod 775 /opt/team-workspace
```

## 8. Shared Directory Setup
```
sudo mkdir /opt/dev-project
sudo chgrp developers /opt/dev-project
sudo mkdir /opt/team-workspace
sudo chgrp project-team /opt/team-workspace


```

## 9. Verification
```
groups username
ls -ld /opt/dev-project
groups tokyo
groups berlin
groups professor
tail /etc/passwd
ls -l /opt/team-workspace/
```
## 10. Test
```
sudo -u tokyo touch /opt/dev-project/tokyo-test.txt
sudo -u berlin touch /opt/dev-project/berlin-test.txt
sudo -u professor touch /opt/dev-project/professor-test.txt (failed)
sudo -u nairobi touch /opt/team-workspace/nairobi-file.txt


```


# Challenges Faced
• Permission Denied Issues

• touch commands failed :  Verified group membership with groups username + checked ls -ld

• Forgot -a flag so the User lost primary group : Always use sudo usermod -aG 

• Groups not refreshed or effected  : newgrp groupname or logout/login refreshes group membership


# What I Learned:
• -aG flag is non-negotiable - prevents wiping user's primary group membership

• 775 permissions = team collaboration - group gets full rwx access (but not safe for fresher or earlybirds)

• sudo -u username = fastest way to test permissions without account switching

• Group ownership (chgrp) + permissions (chmod) = complete access control

• /opt/ = standard location for shared application/project directories



# Why This Matters for DevOps:
Core production skills learned today:

• Multi-user server management - exactly how teams share production servers

• Access control - developers write to /var/www, admins manage systems

• Collaborative workspaces - /opt/project directories for sprint teams

• Permission auditing - ls -ld + groups commands you'll use daily

• Security principle - least privilege through targeted group permissions

