# Day 08 – Cloud Server Setup: Docker, Nginx & Web Deployment
**Date**: February 22, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-08)

## Task Overview
deployed Nginx  and docker web server on AWS EC2 instance. Configured security groups, accessed web server from internet, and extracted access logs for analysis.

• Launch a cloud instance (AWS EC2 or Utho)

• Connect via SSH

• Install Nginx

• Configure security groups for web access (port 80 by default for nginx)

• Extract and save logs to a file

• Verify your webpage is accessible from the internet

This is real DevOps work - exactly what you'll do in production.

---


## Part 1: Launching Amazon AWS EC2 Instance and Connect via SSH
### 1) Login to AWS Console
### 2) Navigate to EC2 Dashboard → "Launch Instance"
### 3) Name: day08-nginx-server
### 4) AMI: Select "Ubuntu Server 22.04 LTS" (which is free)
### 5) Select the Instance Type which is free for avoiding cost iam selecting t3.micro.
### 6) Key Pair: Create new or select existing (selected exiting key pair)
### 7) Launch Instance

<img width="1917" height="872" alt="instance created" src="https://github.com/user-attachments/assets/e8ea5143-00ba-4eab-80d2-672fdb7e2750" />

##  Connect via SSH
### 1) Open any ssh tool iam using git
### 2) Navigate to the path where you downloaded the key pair

```bash
cd <your path>
```
### 4) Run this command

  Makes key file read-only for owner (SSH security requirement)
 
```bash
chmod 400 your-keyname.pem

```
### 5) Connect to instance
   

   Uses private key for authentication instead of password
 ```bash
ssh -i <mykey> ubuntu@<my instance public-ip>.compute-1.amazonaws.com
   ```
<img width="1428" height="1016" alt="ssh" src="https://github.com/user-attachments/assets/5987e291-0a03-49fd-9fac-371f0de0d192" />

---
##  Part 2: Install Docker & Nginx
### 1) Updating System Packages
  Refreshes package lists and updates all installed software to latest versions.
```
   sudo apt-get update
```
### 2) Installing docker

```
   Sudo apt-get install docker.io
```
<img width="1645" height="475" alt="installing docker" src="https://github.com/user-attachments/assets/fded7d23-138c-45d5-8b1a-1187624ffce2" /><br/>

### 3) Verify docker is install and status of docker

(sudo systemctl start docker and sudo systemctl enable docker)Starts Docker service and sets auto-start on boot

```
sudo systemctl status docker
```
<img width="1890" height="526" alt="verify docker insstall and runnning" src="https://github.com/user-attachments/assets/75c4baa9-84bd-4929-8ec3-af434f9f6668" /><br/>


### 4) Grants docker permissions to ubuntu user
```
sudo usermod -aG docker ubuntu
```

### 5) refresh group
```
newgrp  ubuntu
```
### 6) Installing Nginx web server
```
sudo apt install nginx
```
<img width="1553" height="928" alt="nginx install" src="https://github.com/user-attachments/assets/e37dc941-bb62-4974-b85c-58cd80520576" /><br/>

### 7) This Starts nginx service and sets auto-start on boot
```
sudo systemctl start nginx
sudo systemctl enable nginx
```
### 8) Verify Nginx is install and status of Nginx

```
sudo systemctl status nginx
```
<img width="1422" height="491" alt="verify nginx is active" src="https://github.com/user-attachments/assets/8dee8cdf-8689-4337-9507-e860a3ac0927" /><br/>

### 9) fetches webpage content - should show nginx welcome HTML.
```
curl localhost

```
<img width="1062" height="547" alt="curl local host" src="https://github.com/user-attachments/assets/f71735ba-44e4-4436-85d8-a9af93a21581" /><br/>
---
---

## Part 3: Configure Security Group for Web Access
### 1) Navigate to EC2 Dashboard → Select your instance → Security Groups

<img width="1918" height="797" alt="navigating security grp" src="https://github.com/user-attachments/assets/eb61c789-bd2b-4f7f-88f7-6c48fb7786a6" /><br/>

### 2) Click Security Groups → Select the security group → click Edit inbound rules

<img width="1902" height="737" alt="editing inbound rule" src="https://github.com/user-attachments/assets/45ba52df-8299-48cf-a258-53cd835fed0e" /><br/>

### 3) Click Add Rule:

   Type: HTTP → Port: 80 → Source: Anywhere (0.0.0.0/0) → Tag: nginx → click save rule <br/>
   (Security Groups act as virtual firewall Port 80 rule allows internet browsers to reach your nginx web server)

<img width="1905" height="642" alt="edit 80" src="https://github.com/user-attachments/assets/a4fb2b64-0ec3-4730-8125-2863530db76f" /><br/>

## 4) Test Web Access
```
Open browser: http://YOUR-PUBLIC-IP`

```
<img width="1910" height="422" alt="welcome to nginx page" src="https://github.com/user-attachments/assets/32a17fb9-1e7e-4793-8e3c-c786da7ac6b7" /><br/>

---
## Part 4: Docker Nginx  & Extract Logs
### 1) Run Nginx in Docker

```
docker run -d -p 8080:80 --name my-nginx nginx:latest
```

### 2) Test docker nginx

```
curl localhost:8080
```
<img width="1108" height="808" alt="running nginx container" src="https://github.com/user-attachments/assets/01d00431-4fd8-4bb2-889f-a7a0ae8844c4" /><br/>

---

## Extract Nginx Logs
### 1) Shows last lines and follows new log entries live
```
sudo tail -f /var/log/nginx/access.log
```

### 2) Open new EC2 Terminal

### 3) Saved last 50 log to file
```
sudo tail -n 50 /var/log/nginx/access.log > ~/nginx-logs.txt
```
### 4) View log file
   ```
   cat ~/nginx-logs.txt
   ```
<img width="1895" height="927" alt="created log file on server" src="https://github.com/user-attachments/assets/fd5fa013-d734-4eed-b0da-5d6b5eba765b" /><br/>

## Download Logs to Local Machine
### 1) Open new terminal on local machine navigate whhere you hav your private key and run this command
```
scp -i your-key.pem ubuntu@YOUR-PUBLIC-IP:~/nginx-logs.txt .
```
<img width="1850" height="51" alt="got nginx in local system" src="https://github.com/user-attachments/assets/174de299-5efe-494c-a123-76038298cdcc" />


<br/>

Webpage is accessible from the internet
![mob](https://github.com/user-attachments/assets/6254a6ec-6f46-44d0-b601-a2b3901c068e)

##Commands Used
### 1) chmod 400 your-keyname.pem
### 2) ssh -i <mykey> ubuntu@<my instance public-ip>.compute-1.amazonaws.com
### 3) sudo apt-get update
### 4) sudo apt-get install docker.io
### 5) sudo systemctl status docker
### 6) sudo systemctl start docker
### 7) sudo systemctl enable docker
### 8) sudo usermod -aG docker ubuntu
### 9) newgrp ubuntu
### 10) sudo apt install nginx
### 11) sudo systemctl start nginx
### 12) sudo systemctl enable nginx
### 13) sudo systemctl status nginx
### 14) curl localhost
### 15) docker run -d -p 8080:80 --name my-nginx nginx:latest
### 16) curl localhost:8080
### 17) sudo tail -f /var/log/nginx/access.log
### 18) sudo tail -n 50 /var/log/nginx/access.log > ~/nginx-logs.txt
### 19) cat ~/nginx-logs.txt
### 20) scp -i your-key.pem ubuntu@YOUR-PUBLIC-IP:~/nginx-logs.txt .

---

## Challenges Faced
### - SSH permission denied: Fixed with `chmod 400 key.pem`
### - Nginx not accessible: Added HTTP port 80 to security group
### - Docker permission error: Added user to docker group and reconnected

---

## What I Learned:
### - Cloud servers need security group rules for web access
### - Server logs contain valuable access information for debugging
### - SSH key authentication is more secure than passwords
### - Security groups act as firewalls controlling traffic

---
# Why This Matters for DevOps:
### This exercise teaches you:

### • Cloud infrastructure provisioning - launching and configuring servers
### • Remote server management - SSH, security, access control
### • Service deployment - installing and running applications
### • Log management - accessing and analyzing logs
### • Security - configuring firewalls and security groups
### These are core skills for any DevOps engineer working in production.


