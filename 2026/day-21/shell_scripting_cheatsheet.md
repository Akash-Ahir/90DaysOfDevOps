# Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide

**Date**: March 17, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-21)

## Task Overview
---

## Quick Reference Table


| Topic          | Key Syntax          | Example                           |
|----------------|---------------------|-----------------------------------|
| **Variable**   | `VAR="value"`       | `NAME="DevOps"`                   |
| **Argument**   | `$1, $2`            | `./script.sh arg1`                |
| **If**         | `if [ condition ]; then` | `if [ -f file ]; then`       |
| **For loop**   | `for i in list; do` | `for i in 1 2 3; do`             |
| **Function**   | `name() { ... }`    | `greet() { echo "Hi"; }`          |
| **Grep**       | `grep pattern file` | `grep -i "error" log.txt`         |
| **Awk**        | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| **Sed**        | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| **Cut**        | `cut -d: -f1 file`  | `cut -d, -f2 data.csv`            |
| **Logical AND**| `[ cond ] && cmd`   | `[ -f file ] && echo "OK"`        |
| **Logical OR** | `[ cond ] || cmd`   | `[ -d dir ] || mkdir -p dir`      |
| **Logical NOT**| `[ ! cond ]`        | `[ ! -f file ] && echo "Missing"` |
| **Local var**  | `local var="value"` | `local temp="/tmp/file"`          |





---



## Challenge Tasks

### Task 1: Basics
Document the following with short descriptions and examples:
1. Shebang (`#!/bin/bash`) — what it does and why it matters
tells the system which interpreter to use `#!/bin/bash` it should be written at the top of the script

2. Running a script  `chmod +x`, `./script.sh`, `bash script.sh`

   `chmod +x`-----------giving execution permission<br/>
   `./script.sh`--------running the script with the define interpretator written in the script<br/>
   `bash script.sh`----- executing script.sh by the Bash <br/>
 
3. Comments — single line (`#`) and inline


    #--this is single line comment<br/>
     DATE_ANALYSIS=$(date +'%Y-%m-%d') #---this is inline comment<br/>
 
4. Variables — declaring, using, and quoting (`$VAR`, `"$VAR"`, `'$VAR'`)<br/>
NAME="AKASH"-------declaring variable<br/>
echo $NAME---------using variable     <br/>
echo ${NAME}-------quoting variable<br/>


5. Reading user input — `read`<br/>

read -p "Enter name: " NAME"  ------Takes as an input from user and stored it in variable<br/>      
echo "$NAME" 

6. Command-line arguments — `$0`, `$1`, `$#`, `$@`, `$?`<br/>
`$0`------It is a Filename in argument eg:./devops.sh<br/>
`$1`------its the first argument passed by user eg: ./devops.sh akash<br/>
`$#`------total number of arguments<br/>
`$@`------print all arguments<br/>
`$?`------it will catch the last command output<br/>
---

### Task 2: Operators and Conditionals<br/>
Document with examples:<br/>
1. String comparisons — `=`, `!=`, `-z`, `-n`<br/>
    
    `=`------["$str1" = "$str2"]----Equal to <br/>
    
    `!=`------[ "$str1" != "$str2" ]----Not equal to <br/>
    
    `-z`------[ -z "$str" ]----Empty <br/>
    
    `-n`------[ -n "$str" ]----Not empty <br/>
    

3. Integer comparisons — `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
   
   `-eq`=[ 5 -eq 5 ]----- Equal too<br/>
   `-ne`=[ 5 -ne 3 ] ----- Not equal to<br/>
   `-lt`=[ 5 -lt 10 ]----- Less than<br/>
   `-gt`=[ 10 -gt 5 ]----- Greater than<br/>
   `-le`=[ 5 -le 5 ] ----- Less/equal<br/>
   `-ge`=[ 10 -ge 5 ]----- Greater/equalto<br/>
   

4. File test operators — `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s`<br/>
`-f`=Regular file [-f file]<br/>
`-d`=Directory [ -d dir ]<br/>
`-e`=Exists [ -e path ]<br/>
`-r`=Readable [ -r file ]<br/>
`-w`=Writable [ -w file ]<br/>
`-x`=Executable [ -x file ]<br/>
`-s`=Size [ -s file ] <br/>

6. `if`, `elif`, `else` syntax<br/>

      `if`<br/>
        if [ "$1" = "start" ]; then<br/>
        echo "Starting..."<br/>
        
      `elif`<br/>
         elif [ "$1" = "stop" ]; then<br/>
        echo "Stopping..."<br/>
        
      `else`<br/>
         else<br/>
        echo "Usage: $0 {start\|stop}"<br/>

8. Logical operators — `&&`, `||`, `!`<br/>

      `&&` = [ -f file ] && echo "Exists"------------AND - run if first succeeds<br/>
      `||` = [ ! -d dir ] || echo "Is directory"-----OR - run if first fails<br/>
      `!`  = [ ! -f file ] && echo "File missing"----NOT - reverse condition<br/>

9. Case statements — `case ... esac`<br/>
     ```
     case "$1" in
       start) echo "Starting" ;;
       stop)  echo "Stopping" ;;
       *)     echo "Unknown" ;;
     esac
   ```
---

### Task 3: Loops
Document with examples:
1. `for` loop — list-based and C-style

    list-based
    ```
    for i in kiwi orange pineapple; do
        echo "Fruit: $i"
    done
    ```

    C-styled
   ```
   for ((i=1; i<=5; i++)); do
    echo "Count: $i"
   done
   ```
   
3. `while` loop

    ```
    count=1
    while [ $count -le 3 ]; do
        echo $count
        ((count++))
    done
    ```

4. `until` loop
   ```
   until [ $count -gt 3 ]; do
       echo $count
       ((count++))
   done
   ```

5. Loop control — `break`, `continue`

    ```
    for i in 1 2 3 4 5; do
        [[ $i -eq 3 ]] && continue  
        [[ $i -eq 4 ]] && break     
        echo $i
    done
    ```
6. Looping over files — `for file in *.log`

    ```
    for file in *.log; do
    echo "Processing $file"
    done
    ```
7. Looping over command output — `while read line`

   ```
   while read line; do
    echo "Line: $line"
   done < /etc/passwd
   ```

## Task 4: Functions
Document with examples:


1. Defining a function — `function_name() { ... }`

    ```
    greet() {
        echo "Hello $1"
    }
     
    ```
2. Calling a function
    ```
    greet() {
        echo "Hello $1"
    }
    greet "World"  #calling function
    ```

3. Passing arguments to functions — `$1`, `$2` inside functions
    
    ```
    backup() {
    local source=$1
    local dest=$2
    cp "$source" "$dest"
    }
    backup /etc/hosts ~/backup/
    ```
4. Return values — `return` vs `echo`

    ```
    check_file() {
        if [ -f "$1" ]; then
            echo "exists"
            return 0
        else
            return 1
        fi
    }
    status=$(check_file file.txt)
    ```
5. Local variables — `local`

    ```
    backup() {
        local temp_file="/tmp/backup_$$"    
        cp "$1" "$temp_file"
        echo "Backup created: $temp_file"
    }
    
    ```

---

### Task 5: Text Processing Commands
Document the most useful flags/patterns for each:
1. `grep` — search patterns `-i`, `-r`, `-c`, `-n`, `-v`, `-E`<br/>
    `grep` =  grep "error" log.txt ( Find pattern)<br/>
    `-i`  =  grep -i "error" log.txt (Case insensitive)<br/>
    `-r`  =  grep -r "TODO" /app (Recursive)<br/>
    `-c`  =  grep -c "error" log.txt (Count)<br/>
    `-n`  =  grep -n "error" log.txt (Line numbers)<br/>
    `-v`  =  grep -v "OK" log.txt (Invert match)<br/>
    `-E`  =  grep -E "error|warn" log.txt (Extended regex)<br/>

2. `awk` — print columns, field separator, patterns, BEGIN/END

    `print columns`  =  awk '{print $1}' file 
    
    `field separator`  =  awk -F: '{print $1}' /etc/passwd 
    
    `patterns`  =  awk '/error/ {print $0}' log
    
    `BEGIN/END`  =  awk 'BEGIN {print "Start"} {print $0} END {print "End"}' file

3. `sed` — substitution, delete lines, in-place edit

    `substitution`  =  sed 's/old/new/g' file 
    
    `delete lines`  =  sed '/^#/d' file 
    
    `in-place edit`  =  sed -i 's/foo/bar/g' config.txt

4. `cut` — extract columns by delimiter
   ``` cut -d: -f1 /etc/passwd```

5. `sort` — alphabetical, numerical, reverse, unique

    `alphabetical` = sort file
   
    `numerical`    = sort -n file  

    `reverse`      = sort -r file  

    `unique`       = sort -u file

6. `uniq` — deduplicate, count

    ```
    sort uniq.txt | uniq -dc
    ```


7. `tr` — translate/delete characters

    `translate`  =  tr [a-z] [A-Z] < file.txt 
    `delete`     =  tr -d a < file.txt

8. `wc` — line/word/char count
    `wc -l file`  

9. `head` / `tail` — first/last N lines, follow mode
    `head -5 file `  =  first 5 lines
    `tail -5 file`   =  last 5 lines  
---

### Task 6: Useful Patterns and One-Liners
Include at least 5 real-world one-liners you find useful. Examples:
- Find and delete files older than N days: `find /logs -name "*.log" -mtime +30 -delete`
- Count lines in all `.log` files : `wc -l *.log`
- Replace a string across multiple files : `sed -i 's/old/new/g' *.txt`
- Check if a service is running : `systemctl status nginx`
- Monitor disk usage with alerts : `df -h | awk '$5>70'`
---

### Task 7: Error Handling and Debugging
Document with examples:
1. Exit codes — `$?`, `exit 0`, `exit 1`
  `$?`      =  last command status(0/1)
  `exit 0`  =  Success
  `exit 1`  =  Failed

3. `set -e` — exit on error
4. `set -u` — treat unset variables as error
5. `set -o pipefail` — catch errors in pipes
6. `set -x` — debug mode (trace execution)

---

### Task 8: Bonus — Quick Reference Table
Create a summary table like this at the top of your cheat sheet:

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## Format Guidelines

Your cheat sheet should be:
- Written in **Markdown** (`.md`)
- Organized with **clear headings** for each section
- Include **code blocks** with syntax highlighting (` ```bash `)
- Keep explanations **short** — 1-2 lines max per item
- Focus on **practical examples** over theory
- Something **you would actually refer back to** on the job

---

## Submission
1. Add your `shell_scripting_cheatsheet.md` to `2026/day-21/`
2. Commit and push to your fork

---

## Learn in Public

Share your cheat sheet on LinkedIn — help others revise too!

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
