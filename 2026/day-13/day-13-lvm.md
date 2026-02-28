# Day 13 – Linux Volume Management (LVM)
**Date**: February 28, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-13)

## Task Overview
• I attached a 10 GiB EBS volume to my EC2 instance and used Linux LVM to manage it as a flexible storage layer.<br/>• I created a physical volume, volume group, and logical volume, then formatted it with `ext4` and mounted it on `/mnt/app-data`. <br/>• I resized the logical volume online with lvextend and saw the filesystem grow without unmounting or rebooting.

---

## Before You Start

Switch to root user:
```bash
sudo -i
```
or
```bash
sudo su
```

No spare disk? Create a virtual one:
1) instance-->volumes-->create volume

<img width="1917" height="738" alt="2 1" src="https://github.com/user-attachments/assets/59ee11b2-9fb9-499b-8346-ef4b10829578" /><br/>

2)  Ensure you create the volume in the same Availability Zone (AZ) as your EC2 instance
<img width="1177" height="728" alt="2 2" src="https://github.com/user-attachments/assets/5362dad5-12d8-46e6-b7ee-f8ee0527f1f1" /><br/>

3) After creation, the volume will appear in the 'Available' state.
<img width="1647" height="340" alt="2 3" src="https://github.com/user-attachments/assets/a851a532-95ed-4b93-a22b-8cc614a73501" /><br/>

4) Select the volume, click 'Actions', and choose 'Attach Volume'.
<img width="1643" height="567" alt="2 4" src="https://github.com/user-attachments/assets/a58416db-a4c3-4cdd-b98e-3083091c3584" /><br/>

5) Select your EC2 instance to attach the volume to.
<img width="1277" height="521" alt="2 5" src="https://github.com/user-attachments/assets/44687d3e-d9b7-4aaa-beaf-a98e58710a60" /><br/>


---

## Challenge Tasks

### Task 1: Checking the Current Storage
```
lsblk
```
```
pvs
```
No output means no Physical Volumes exist yet.
```
vgs
```
No output means no Volumes groups exist yet.
```
lvs
```
No output means no Logical Volumes exist yet.
```
df -h
```
<img width="712" height="526" alt="1" src="https://github.com/user-attachments/assets/ac805340-e257-4cc4-9ab5-edc010661916" /><br/>

### For updating and installing lvm command 
```
apt update
```
```
apt install -y lvm2
```
<img width="993" height="461" alt="3" src="https://github.com/user-attachments/assets/acd30b00-95b6-42a7-abd0-9089593e465a" />

### Task 2: Creating Physical Volume
```
pvcreate /dev/nvme1n1
```
```
pvs
```
<img width="716" height="395" alt="4" src="https://github.com/user-attachments/assets/6185ec49-8622-4016-b9f2-3a07ea05722f" /><br/>

### Task 3: Create Volume Group
```bash
vgcreate devops-vg /dev/nvme1n1
```
```
vgs
```
<img width="838" height="207" alt="5" src="https://github.com/user-attachments/assets/b550dd6a-1676-48a8-91c3-b301ee0b2042" /><br/>

### Task 4: Create Logical Volume
```bash
lvcreate -L 500M -n app-data devops-vg
```
```
lvs
```
<img width="988" height="148" alt="6" src="https://github.com/user-attachments/assets/61dc205d-bd7e-421e-b3fe-805f704fb324" /><br/>

### Task 5: Format and Mount
```
mkfs.ext4 /dev/devops-vg/app-data
```

```
mkdir -p /mnt/app-data
```
```
mount /dev/devops-vg/app-data /mnt/app-data

```
```
df -h /mnt/app-data
```
<img width="868" height="507" alt="7" src="https://github.com/user-attachments/assets/53588d62-f581-4702-b24d-6e17556bc44f" /><br/>

### Task 6: Extend the Volume
```
lvextend -L +200M /dev/devops-vg/app-data
```
```
resize2fs /dev/devops-vg/app-data
```
```
df -h /mnt/app-data
```
<img width="1202" height="287" alt="8" src="https://github.com/user-attachments/assets/fa3b2544-3be3-4b00-a33b-a9e686dfb6ec" /><br/>

---
## What I Learned

1. AWS EBS volumes appear as `/dev/nvme1n1` and can be LVM PVs
2. LVM hierarchy: PV → VG → LV → ext4 filesystem  
3. `lvextend + resize2fs` enables online filesystem growth


