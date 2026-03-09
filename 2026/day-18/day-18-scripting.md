# Day 18 – Shell Scripting: Functions & intermediate Concepts
**Date**: March 3, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-18)

## Task Overview



## Challenge Tasks

## Task 1: Basic Functions
### 1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script
  
  <img width="725" height="237" alt="1 output" src="https://github.com/user-attachments/assets/770ad217-94bb-4208-9db8-1a80e5cfc607" /><br/>

 ### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-18/scripts/functions.sh)





  
---

## Task 2: Functions with Return Values
### 1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results



<img width="637" height="230" alt="2 output" src="https://github.com/user-attachments/assets/fcd7a106-ca43-41cd-9c18-f4bc6f8ec874" /><br/>


### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-18/scripts/disk_check.sh)


---

## Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top
2. Try using an **undefined variable** — what happens with `set -u`?
3. Try a command that **fails** — what happens with `set -e`?
4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?

   output : without set -euo

   <img width="775" height="222" alt="3 output (with -e)" src="https://github.com/user-attachments/assets/2e9a4f06-7dbe-4339-bf32-a331e7e442af" />

   
   output: with set -euo

   <img width="640" height="205" alt="3 output (without -e)" src="https://github.com/user-attachments/assets/fa7281d4-f3f6-4823-ad05-27ff690c68bb" />
   
   output with and without set -euo  

   <img width="655" height="191" alt="3 output (with -o   without -o)" src="https://github.com/user-attachments/assets/9f7fc336-aff6-4b42-9fff-64b4e4153154" />

   <img width="627" height="266" alt="3 output (with -u   without -u)" src="https://github.com/user-attachments/assets/d1867a6e-3950-4cf5-aca1-3d65e765db59" />


  ### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-18/scripts/strict_demo.sh)







**Document:** What does each flag do?
- `set -e` →  Exit immediately if any command fails 
- `set -u` →  Treat undefined variables as errors 
- `set -o pipefail` →  Pipe fails if ANY command in pipeline fails

---

## Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables
  
     <img width="688" height="362" alt="4  output" src="https://github.com/user-attachments/assets/094f105c-bf9a-4014-b46a-5fb4db124c5a" />

     ### [Script]([2026/day-18/scripts/local_demo.sh](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-18/scripts/local_demo.sh))


---

### Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

 
 <img width="1131" height="567" alt="5  output" src="https://github.com/user-attachments/assets/f7115298-8b62-4074-90ef-775de224c399" /><br/>


### [Script](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-18/scripts/system_info.sh)

Output should look clean and readable.

---

## Hints
- Function syntax: `function_name() { ... }`
- Local vars: `local MY_VAR="value"`
- Strict mode: `set -euo pipefail` as first line after shebang
- Pass args to functions: `greet "Shubham"` → access as `$1` inside
- `$?` gives the exit code of last command

---

## Documentation

Create `day-18-scripting.md` with:
- Each script's code and output
- Explanation of `set -euo pipefail`
- What you learned (3 key points)

---

## Submission
1. Add your scripts and `day-18-scripting.md` to `2026/day-18/`
2. Commit and push to your fork

---

## Learn in Public

Share what you learned about shell functions and strict mode on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
