# Day 09 – Linux User & Group Management Challenge
**Date**: February 23, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-09)

## Task Overview
Done with Linux file permissions & operations! Created files with `touch/cat/vim`, understood rwx read-write-execute (4+2+1), modified permissions with `chmod`, and tested access failures.<br/>

• Created `devops.txt`, `notes.txt`, `script.sh`<br/>
• Learned permission numbers: 755=rwxr-xr-x, 640=rw-r-----, 444=r--r--r--<br/>
• Changed permissions + tested failures <br/>
• Created `project/` directory with standard 755 permissions<br/>
• Used`ls -l`, `ls -ld`, `chmod +x`, read-only protection<br/>


## Files Created
- `devops.txt` 
- `notes.txt` 
- `script.sh` 
- `project/` 

## Permission Changes
| File       | Before | After  | Purpose |
|------------|--------|--------|---------|
| script.sh  | 644    | 755    | Executable |
| devops.txt | 644    | 444    | Read-only |
| notes.txt  | 644    | 640    | Group read |

---
## Challenge Tasks

## Task 1: Created Files 

### 1) Created devops.txt by `touch`
```bash
touch devops.txt

```
### 2) Created `notes.txt` with some content using `cat` command
```
cat > notes.txt << EOF
>hey, this is the Day-10 of 90daysofdevops
>in previous day-06 we done this specific  insertion by eco thats why in today task we are using cat command
>EOF-End of File
>after that press ctrl+d to save
>EOF
```
Press ctrl+d to save 
### 3) display notes.txt 
```
cat notes.txt
```
<img width="1240" height="653" alt="1" src="https://github.com/user-attachments/assets/94edde1e-8a6f-40be-8f33-cd4896ac51c7" /><br/>
### 4) Created script.sh using `vim` with content: `echo "Hello DevOps" `

```
vim script.sh
 ____________________
|                    |
|echo "Hello DevOps  |
|                    |
|____________________|
```
### 5) Verify permission by 
```
ls -l script.sh
ls -l *.txt
```

<img width="738" height="221" alt="2" src="https://github.com/user-attachments/assets/97778358-a682-452e-802b-211b05a06737" /><br/>
--
## Task 2: Read Files 

### 1) Read `notes.txt` using `cat`
```
cat notes.txt
```
<img width="1247" height="187" alt="3" src="https://github.com/user-attachments/assets/0abf9409-bdd2-45da-adee-300e057f4423" /><br/>

### 2) View script.sh in `vim` read-only mode 
```
vim -R script.sh

```

<img width="602" height="111" alt="4" src="https://github.com/user-attachments/assets/cead94c4-59cb-48e4-ab7f-7c385e34d9ce" /><br/>
<img width="787" height="642" alt="5" src="https://github.com/user-attachments/assets/cc8dabfb-1dac-4882-b83b-68d991880c07" /><br/>


### 3) Display first 5 lines of /etc/passwd using `head`
```
head -5 /etc/passwd
```
### 4) Display last 5 lines of /etc/passwd using tail
```
tail -5 /etc/passwd
```

<img width="895" height="382" alt="6" src="https://github.com/user-attachments/assets/230d3ab3-6362-4ca7-b8dc-6a135a89fe7a" /><br/>

--
## Task 3: Understanding Permissions
```
ls -l devops.txt notes.txt script.sh
```

<img width="763" height="191" alt="7" src="https://github.com/user-attachments/assets/e79e131d-9ee8-4795-b16c-8151572fc2bb" /><br/><br/>


## Question: What are current permissions? Who can read/write/execute?

### Answer: `devops.txt` `notes.txt` `script.sh`shows <br/>
#### Owner has read and write permission<br/>
Group has read and write permission<br/>
Other has only Read permission <br/>
<img width="1567" height="715" alt="rwx" src="https://github.com/user-attachments/assets/85d15805-3af6-407d-b7fc-e7e2079e6a70" /><br/>

--
## Task 4: Modify Permissions

### 1) Make `script.sh` executable 

```
chmod +x script.sh
```
### 2) Run `script.sh` 
```
./script.sh
```

### 3) Set `devops.txt` to read-only (remove write for all)
```
chmod -w devops.txt
```

### 4) Set `notes.txt` to 640 (owner: rw, group: r, others: none)
```
chmmod 640 notes.txt
```
### 5) Create directory project/ 
```
mkdir project
```
### 6)Give permissions 755 to project 
```
chmod 755 project
```
### 7) verify permission by `ls -ld` <directory/file name >

<img width="607" height="497" alt="8" src="https://github.com/user-attachments/assets/da039fd6-4eff-4633-a1da-e48b6d7cdf67" /><br/>

--

## Task 5: Test Permissions 

### 1) Try writing to a read-only file 
```
eco "trying to write in read only file" >> devops.txt
```
Shows Permission denied Because devops.txt is read-only file we removed the permission of write.

<img width="913" height="128" alt="9" src="https://github.com/user-attachments/assets/10386241-ef88-487b-b40b-b3aa3884b83a" /><br/>


### 2) Try executing a file without execute permission
### removing execute permission from `script.sh`
```
chmod -x script.sh
```
#### executing a file 
```
./script.sh
```
### Permission denied: because we remove the execute permission from the `script.sh`
<img width="672" height="167" alt="10" src="https://github.com/user-attachments/assets/656804dd-e984-4b37-b8e6-5ffeb570cd75" /><br/>

## What I Learned

### • Read, Write, Execute permission management<br/>

### • chmod +x makes scripts executable instantly<br/>

### • Read-only files (444) protect critical configs<br/>

### • How to deal with Restriction of users to dedicate fill/directory or group management<br/>

### • How to Test permissions without switching accounts<br/>

### • Production permission patterns learned today<br/>

--

## Challenges I Faced

### • Permission denied" on devops.txt<br/>
### • bash: ./script.sh: Permission denied<br/>
### • vim accidentally overwrote script.sh<br/>
### • Testing permissions as other users<br/>

## Commands Used
```
touch devops.txt
```
```
cat > notes.txt << EOF
>hey, this is the Day-10 of 90daysofdevops
>in previous day-06 we done this specific  insertion by eco thats why in today task we are using cat command
>EOF-End of File
>after that press ctrl+d to save
>EOF
```
```
cat notes.txt
```
```
vim script.sh

```
```
ls -l script.sh
ls -l *.txt
```

```
cat notes.txt
```

```
vim -R script.sh

```

```
head -5 /etc/passwd
```

```
tail -5 /etc/passwd
```

```
ls -l devops.txt notes.txt script.sh
```

```
chmod +x script.sh
```

```
./script.sh
```

```
chmod -w devops.txt
```

```
chmmod 640 notes.txt
```

```
mkdir project
```

```
chmod 755 project
```

```
eco "trying to write in read only file" >> devops.txt
```

```
chmod -x script.sh
```

```
./script.sh
```



