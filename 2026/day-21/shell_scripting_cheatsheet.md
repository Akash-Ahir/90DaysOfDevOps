# Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide

**Date**: March 17, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-21)

## Task Overview

---

## Challenge Tasks

### Task 1: Basics
Document the following with short descriptions and examples:
1. Shebang (`#!/bin/bash`) — what it does and why it matters
tells the system which interpreter to use `#!/bin/bash` it should be written at the top of the script

2. Running a script  `chmod +x`, `./script.sh`, `bash script.sh`

 `chmod +x`-----------giving execution permission 
 `./script.sh`--------running the script with the define interpretator written in the script
 `bash script.sh`----- executing script.sh by the Bash 
 
3. Comments — single line (`#`) and inline

#--this is single line comment
 DATE_ANALYSIS=$(date +'%Y-%m-%d') #---this is inline comment
 
4. Variables — declaring, using, and quoting (`$VAR`, `"$VAR"`, `'$VAR'`)

NAME="AKASH"-------declaring variable
echo $NAME---------using variable     
echo ${NAME}-------quoting variable


5. Reading user input — `read`
read -p "Enter Name : "AKASH"------Takes Akash as an input from user and stored it in variable

7. Command-line arguments — `$0`, `$1`, `$#`, `$@`, `$?`

`$0`------It is a Filename in argument eg:./devops.sh
`$1`------its the first argument passed by user eg: ./devops.sh akash
`$#`------total number of arguments
`$@`------print all arguments
`$?`------it will catch the last command output
---

### Task 2: Operators and Conditionals
Document with examples:
1. String comparisons — `=`, `!=`, `-z`, `-n`
`=`------
`!=`------
`-z`------
`-n`------


3. Integer comparisons — `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
4. File test operators — `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s`
5. `if`, `elif`, `else` syntax
6. Logical operators — `&&`, `||`, `!`
7. Case statements — `case ... esac`

---

### Task 3: Loops
Document with examples:
1. `for` loop — list-based and C-style
2. `while` loop
3. `until` loop
4. Loop control — `break`, `continue`
5. Looping over files — `for file in *.log`
6. Looping over command output — `while read line`

---

### Task 4: Functions
Document with examples:
1. Defining a function — `function_name() { ... }`
2. Calling a function
3. Passing arguments to functions — `$1`, `$2` inside functions
4. Return values — `return` vs `echo`
5. Local variables — `local`

---

### Task 5: Text Processing Commands
Document the most useful flags/patterns for each:
1. `grep` — search patterns, `-i`, `-r`, `-c`, `-n`, `-v`, `-E`
2. `awk` — print columns, field separator, patterns, `BEGIN/END`
3. `sed` — substitution, delete lines, in-place edit
4. `cut` — extract columns by delimiter
5. `sort` — alphabetical, numerical, reverse, unique
6. `uniq` — deduplicate, count
7. `tr` — translate/delete characters
8. `wc` — line/word/char count
9. `head` / `tail` — first/last N lines, follow mode

---

### Task 6: Useful Patterns and One-Liners
Include at least 5 real-world one-liners you find useful. Examples:
- Find and delete files older than N days
- Count lines in all `.log` files
- Replace a string across multiple files
- Check if a service is running
- Monitor disk usage with alerts
- Parse CSV or JSON from command line
- Tail a log and filter for errors in real time

---

### Task 7: Error Handling and Debugging
Document with examples:
1. Exit codes — `$?`, `exit 0`, `exit 1`
2. `set -e` — exit on error
3. `set -u` — treat unset variables as error
4. `set -o pipefail` — catch errors in pipes
5. `set -x` — debug mode (trace execution)
6. Trap — `trap 'cleanup' EXIT`

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
