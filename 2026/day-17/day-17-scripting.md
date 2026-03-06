# Day 17 – Shell Scripting: Loops, Arguments & Error Handling
**Date**: March 4, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-17)

## Task Overview<br/>
 Built  `for_loop.sh`  &  `count.sh`  for for-loop iteration, `countdown.sh` for while-loop countdowns with user input, `greet.sh` & `args_demo.sh` for command-line args (`$1`, `$#`, `$@`). Automated nginx/curl/wget installs with `install_packages.sh` (dpkg + root checks) and error handling via `safe_script.sh` (`set -e`, `||`).



- Write **for** and **while** loops
- Use **command-line arguments** (`$1`, `$2`, `$#`, `$@`)
- Install packages via script
- Add basic **error handling**

---


## Challenge Tasks

## Task 1: For Loop
### 1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one
 ```
#!/bin/bash
fruits=("kiwi" "avacado" "grapes" "watermellon" "banana")
for fruit in "${fruits[@]}"; do
  echo "$fruit"
done
 ```
   <img width="760" height="150" alt="1 script image" src="https://github.com/user-attachments/assets/fee37524-d4bf-4d4d-ad0a-5870a0d68486" /><br/>



   ### output:
   <img width="608" height="252" alt="1 oytput" src="https://github.com/user-attachments/assets/fee874ba-8a7b-4427-950c-865f2c9a9fa4" /><br/>


### 2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop<br/>

  ```
 #!/bin/bash

for ((i=1;i<=10;i++)); do
    echo "$i"
done

  ```
   <img width="310" height="146" alt="1 b script" src="https://github.com/user-attachments/assets/0e61f99a-cd6d-460d-ba0c-d9d35f1305ab" /><br/>


   ### output:
   <img width="470" height="297" alt="1 b output" src="https://github.com/user-attachments/assets/d444b35d-38c1-45a0-9e5b-788028578faf" /><br/>

       

---

## Task 2: While Loop

### 1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end<br/>
   ```
   #!/bin/bash
   read -p "Enter a number: " NUMBER
   while [ "$NUMBER" -gt 0 ] ; do
         echo "$NUMBER"
   NUMBER=$((NUMBER - 1))
    done
    echo "done"
   ```
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
   ```
    #!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: ./greet.sh <name>"
  exit 1
fi
echo "Hello, $1!"

   ```
   <img width="456" height="168" alt="3 script" src="https://github.com/user-attachments/assets/a5af9438-a5d9-4012-adc7-d3f002a4acac" /><br/>
   
   ### output:
   <img width="505" height="182" alt="3 output" src="https://github.com/user-attachments/assets/1b722946-9606-4f97-b1fa-9f9e2c64c3db" />

  

### 2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)<br/>
  ```
   
#!/bin/bash

echo "Total arguments: $#"
echo "All arguments: $@"
echo "Script name: $0"
   ```
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
   ```
   packages=("nginx" "curl" "wget")
for pg in "${packages[@]}"; do
  if dpkg -s "$pg" &> /dev/null; then
    echo "$pg: already installed"
  else
    echo "Installing $pg..."
    apt-get update -qq && apt-get install -y "$pg"
    echo "$pg: installiton done"
  fi
done
   ```
   <img width="671" height="277" alt="4 script" src="https://github.com/user-attachments/assets/324827eb-017c-451b-a77c-3e3d77be8723" /><br/>

   ### output:
   <img width="742" height="685" alt="4  output" src="https://github.com/user-attachments/assets/66aca50d-34ac-42d8-b232-228ec21b5ce0" /><br/>


     

> Run as root: `sudo -i` or `sudo su`

---

## Task 5: Error Handling
### 1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails
   ```
   #!/bin/bash
set -e  

echo "Creating /tmp/devops-test..."
mkdir -p /tmp/devops-test || echo "Directory already exists"

echo "Navigating to directory..."
cd /tmp/devops-test || echo "Failed to cd into directory"

echo "Creating test file..."
echo "DevOps test" > test.txt || echo "File creation failed"

echo "DIRECTORY created sucessfully"
   ``` 
   <img width="940" height="371" alt="5 script" src="https://github.com/user-attachments/assets/5a7e6425-7bb7-42fb-afeb-d73308f0a1e3" /><br/>

### output:
   <img width="1893" height="473" alt="5 output" src="https://github.com/user-attachments/assets/bb88f512-9262-489e-9e6d-8a5a526f4de9" /><br/>

Example:
```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

### 2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not.
   <img width="697" height="522" alt="modify install script" src="https://github.com/user-attachments/assets/6f5ee6b5-6efc-4abd-b841-7000e3ec0ca9" /><br/>
   ### output:
   <img width="743" height="197" alt="modify install output" src="https://github.com/user-attachments/assets/e0e622b9-c1df-4261-913e-eeb990c2f70c" />

---


## Key Learnings
1. **Loops** automate repetitive tasks efficiently
2. **Args** (`$1/$#/$@`) make scripts reusable  
3. **Error handling** prevents silent failures in production
