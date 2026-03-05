# Day 16 – Shell Scripting Basics
**Date**: March 4, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-16)

## Task Overview
Getting familiar with the shell scripting which are essential for automating repetitive DevOps tasks like deployments, monitoring, and system checks directly in the terminal.

---

---

## Challenge Tasks

## Task 1: Your First Script
1. Create a file `hello.sh`
   ```
   vim  hello.sh

   ```
2. Add the shebang line `#!/bin/bash` at the top
3. Print `Hello, DevOps!` using `echo`
   ```
    echo "Hello, DevOps!"
   ```
4. Make it executable and run it
   ```
    chmod 777 hello.sh
   ```

   <img width="607" height="193" alt="print hello devops" src="https://github.com/user-attachments/assets/7ea970d7-7657-4eed-b339-c48c3b16b340" /><br/>


---

## Task 2: Variables
1. Create `variables.sh` with:
2. ```
      vim variables.sh
   ```
   - A variable for your `NAME`
   - A variable for your `ROLE` (e.g., "DevOps Engineer")
   - Print: `Hello, I am <NAME> and I am a <ROLE>`
     <img width="563" height="180" alt="task 2 1" src="https://github.com/user-attachments/assets/3327b36d-7b90-4aef-bae8-8e3c0fc2ff21" /><br/>
     <img width="655" height="248" alt="task 2 2" src="https://github.com/user-attachments/assets/4e3bf903-d3c5-48d4-904f-19c5421972a6" /><br/>


3. Try using single quotes vs double quotes — what's the difference?

   <img width="432" height="75" alt="task 2 3" src="https://github.com/user-attachments/assets/14971a50-a229-49b0-a84b-83b6c082df89" /><br/>


---

## Task 3: User Input with read
1. Create `greet.sh` that:
   ```
    vim greet.sh
   ```
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`
  
     <img width="527" height="173" alt="task 3 1" src="https://github.com/user-attachments/assets/1fc576ef-509a-44d1-b921-a76abd1e1cb7" /><br/>
     <img width="600" height="257" alt="task 3 2" src="https://github.com/user-attachments/assets/ad4deff2-add9-4f5f-927b-8cd91ec595e1" /><br/>



---

## Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   ```
      vim check_number.sh
   ```
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**
  
     <img width="475" height="278" alt="task 4 1" src="https://github.com/user-attachments/assets/1af2e0d7-a758-49e5-a132-b8918f7670fd" /><br/>

    <img width="527" height="277" alt="task 4 2" src="https://github.com/user-attachments/assets/ebd15f94-4745-4c76-bb18-50cc4379b0a9" /><br/>

3. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message
     <img width="783" height="210" alt="task 4 b 1" src="https://github.com/user-attachments/assets/7c67887f-c929-4d9c-8f04-91b271d79f0b" /><br/>
     <img width="627" height="182" alt="task 4 b 2" src="https://github.com/user-attachments/assets/586cefb8-dfd3-4578-975c-1caf4e5f52bd" />



---

### Task 5: Combine It All
Create `server_check.sh` that:
1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."
<img width="852" height="351" alt="task 5 1" src="https://github.com/user-attachments/assets/00fbad94-de42-4b3c-a44f-45c17d0308f7" /><br/>
<img width="678" height="165" alt="task 5 2" src="https://github.com/user-attachments/assets/034af210-d9b6-4e2b-a3ee-f2b2eb7f2e3e" /><br/>
<img width="1406" height="501" alt="task 5 3" src="https://github.com/user-attachments/assets/713efd1f-5658-4124-bd3e-313b0fbd3518" /><br/>



---

---
