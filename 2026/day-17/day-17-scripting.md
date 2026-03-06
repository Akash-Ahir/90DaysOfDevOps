# Day 17 – Shell Scripting: Loops, Arguments & Error Handling
**Date**: March 4, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-17)

## Task Overview
 created `for_loop.sh` and `count.sh` for for-loop iteration, `countdown.sh` for while loop countdowns with user input, and `greet.sh` with `args_demo.sh` to handle command-line arguments using `$1`, `$#`, and `$@`. `install_packages.sh` automates nginx/curl/wget installation with dpkg checks and root validation, while `safe_script.sh` implements error handling with `set -e` and `||` 

- Write **for** and **while** loops
- Use **command-line arguments** (`$1`, `$2`, `$#`, `$@`)
- Install packages via script
- Add basic **error handling**

---


## Challenge Tasks

## Task 1: For Loop
### 1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
     <img width="760" height="150" alt="1 script image" src="https://github.com/user-attachments/assets/fee37524-d4bf-4d4d-ad0a-5870a0d68486" /><br/>



      ### output:
       <img width="608" height="252" alt="1 oytput" src="https://github.com/user-attachments/assets/fee874ba-8a7b-4427-950c-865f2c9a9fa4" /><br/>


### 2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop<br/>
   
     <img width="310" height="146" alt="1 b script" src="https://github.com/user-attachments/assets/0e61f99a-cd6d-460d-ba0c-d9d35f1305ab" /><br/>


     ### output:
     <img width="470" height="297" alt="1 b output" src="https://github.com/user-attachments/assets/d444b35d-38c1-45a0-9e5b-788028578faf" /><br/>

       

---

## Task 2: While Loop

### 1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end<br/>
     <img width="432" height="260" alt="2 script" src="https://github.com/user-attachments/assets/156df639-c39d-4e3c-a56b-2562b8e10e2b" /><br/>


   ### output:
   `
    <img width="541" height="252" alt="2 output" src="https://github.com/user-attachments/assets/13e350e0-69e0-4b83-9683-0e1858a82345" /><br/>



---

## Task 3: Command-Line Arguments
### 1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"<br/>
   <img width="456" height="168" alt="3 script" src="https://github.com/user-attachments/assets/a5af9438-a5d9-4012-adc7-d3f002a4acac" /><br/>
   
   ### output:
   <img width="505" height="182" alt="3 output" src="https://github.com/user-attachments/assets/1b722946-9606-4f97-b1fa-9f9e2c64c3db" />

  

### 2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)<br/>
    <img width="367" height="158" alt="3 2 script" src="https://github.com/user-attachments/assets/50b70bb7-47fe-4407-9781-305a59f1fecf" /><br/>

  ### output:
    <img width="778" height="381" alt="3  2  output" src="https://github.com/user-attachments/assets/d16639f4-3cc2-4ef8-a824-ceb804c8c355" />


---

## Task 4: Install Packages via Script
### 1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package<br/>
   <img width="671" height="277" alt="4 script" src="https://github.com/user-attachments/assets/324827eb-017c-451b-a77c-3e3d77be8723" /><br/>

   ### output:
   <img width="742" height="685" alt="4  output" src="https://github.com/user-attachments/assets/66aca50d-34ac-42d8-b232-228ec21b5ce0" /><br/>


     

> Run as root: `sudo -i` or `sudo su`

---

### Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails

Example:
```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.

---

## Hints
- For loop: `for item in list; do ... done`
- While loop: `while [ condition ]; do ... done`
- Arguments: `$1` first arg, `$#` count, `$@` all args
- Check root: `if [ "$EUID" -ne 0 ]; then echo "Run as root"; exit 1; fi`
- Check package: `dpkg -s <pkg> &> /dev/null && echo "installed"`

---

## Documentation

Create `day-17-scripting.md` with:
- Each script's code and output
- What you learned (3 key points)

---

## Submission
1. Add your scripts and `day-17-scripting.md` to `2026/day-17/`
2. Commit and push to your fork

---

## Learn in Public

Share your scripting progress on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
