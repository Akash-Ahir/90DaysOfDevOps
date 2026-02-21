# Day 06: Linux Fundamentals - Read and Write Text Files

**Date**: February 20, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-06)

## Task Overview
Practice basic Linux file I/O operations using fundamental commands:
- Create files with `touch`
- Write with redirection (`>`, `>>`)
- Append and display with `tee`
- Read with `cat`, `head`, `tail`

## Step-by-Step Commands with Observations

### 1. Create Empty File
```bash
touch notes.txt
```
Purpose: Creates an empty notes.txt file 

### 2. Write First Line (Overwrite)
```bash
echo "hey, this is the Day 05 of the task" > notes.txt
```
Purpose: Redirects output to file, overwriting any existing content.


### 3. Append Second Line
```bash
echo "make sure to like, share, subscribe" >> notes.txt
```
Purpose: Appends text without overwriting (>> adds to end).



### 4. Append & Display Third Line
```bash
echo "linux is user friendly it`s just very picy about who it`s friends are" | tee -a notes.txt
```
Purpose: tee -a appends to file and displays on terminal simultaneously.


### 5. Read Full File
```bash
cat notes.txt
```
Purpose: Displays complete file content.


### 6. Read First 2 Lines
```bash
head -n 2 notes.txt
```
Purpose: Shows top N lines (useful for log previews).


### 7. Read Last 2 Lines
```bash
tail -n 2 notes.txt
```
Purpose: Shows bottom N lines (ideal for recent entries).


### Final File Verification
```bash
ls 
```
<img width="1412" height="461" alt="Screenshot 2026-02-20 223113" src="https://github.com/user-attachments/assets/ca524d61-67d2-45d1-929a-da8e55774452" />
