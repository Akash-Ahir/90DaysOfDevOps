# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports
**Date**: February 28, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-15)

## Task Overview
Build on Day 14 by understanding the building blocks of networking every DevOps engineer must know.

---

# Challenge Tasks

## Task 1: DNS – How Names Become IPs
### 1. Explain in 3–4 lines: what happens when you type `google.com` in a browser?
```
1) Whenever we search google.com on browser it uses application layer of protocol

2) First it will check for the ip in cache 

3) If the ip is not there it will create a request to dns 

4) Once its get ip  then it will create a connection HTTP/HTTPS to the google server 

5) After making connection it will get the data to your browser and display it  

```

### 2. What are these record types? Write one line each:
  `A` ---- Maps a name to ip addrresses like google.com to some ip adresses x.x.x.x only for IPV4<br/>
  `AAAA` ----Maps a host name to IP addresses for IPV6<br/>
  `CNAME` ----its allow to alias one domains name to another www.google.com to google.com<br/>
  `MX` ----it is use to receive services for a domain<br/>
  `NS` ----Nameserver responsible for domain<br/>
    
3. Run: `dig google.com` — identify the A record and TTL from the output
   

---

## Task 2: IP Addressing
1. What is an IPv4 address? How is it structured? (e.g., `192.168.1.10`)<br/>
 ---IP addresses is like a unique number for a computer. It allow devices to locate and communicate to each other<br/>
   <img width="827" height="417" alt="ip addresses " src="https://github.com/user-attachments/assets/448d6d8c-f0ed-4958-9473-3a8e0490c883" />

   
3. Difference between **public** and **private** IPs — give one example of each<br/>

    **Public IP**= Public IP can be routable all over the internet<br/>
  
     **Private IP**= Private IP cant be routed ovet internet . It is used inside home or company network.<br/>
   
5. What are the private IP ranges?<br/>

   - `10.x.x.x`-----Class "A" it is used by a Large networks<br/>
   - `172.16.x.x – 172.31.x.x`--- Class "B" it is used by a medium networks<br/>
   - `192.168.x.x`---Class "C"  it is used by a home or smaller networks.<br/>
  
     
6. Run: `ip addr show` — identify which of your IPs are private




---

## Task 3: CIDR & Subnetting
1. What does `/24` mean in `192.168.1.0/24`?

`/24`-- indicates that "254" total are usable and total ips are 256


2. How many usable hosts in a<br/>
  `/24`- 	254<br/>
  `/16`- 	65,534<br/>
  `/28`-  4,096<br/>


3. Explain in your own words: why do we subnet?<br/>
A subnets is a smaller network inside a large network. subnet makes network routing more efficient. Subnetting occurs when a large network is split into smaller networks to kepp security.

4. Quick exercise — fill in:

| CIDR | Subnet Mask | Total IPs | Usable Hosts |
|------|-------------|-----------|--------------|
| /24  | 255.255.255.0| 	256   | 	254         |
| /16  | 255.255.0.0 | 65,536   |   65,534      |
| /28  | 255.255.255.240 | 	16  |     14        |

---

## Task 4: Ports – The Doors to Services
1. What is a port? Why do we need them?
  Ports are the endpoint for the services.
  Because of port we can manage multiple services with one ip only. if there is no port then we need seperate ips for the different services
  


3. Document these common ports:

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | HTTP    |
| 443  | HTTPS   |
| 53   | DNS     |
| 3306 | MySQL   |
| 6379 | Redis   |
| 27017| MongoDB |



3. Run `ss -tulpn` — match at least 2 listening ports to their services

   

---

## Task 5: Putting It Together
Answer in 2–3 lines each:
- You run `curl http://myapp.com:8080` — what networking concepts from today are involved?
  DNS<br/>
  IP Addressing<br/>
  Ports<br/>
  TCP -Transport<br/>

  
- Your app can't reach a database at `10.0.1.50:3306` — what would you check first?
  1) `ping 10.0.1.50`- check the status
  2) `nc -zv 10.0.1.50 3306`- if it show coonection refused then open the port 3306 from security group
  3) `ss -tulpn`- it will display the active network connection
  4) `systemctl status mysql`- check the database service status
---
## What I Learned
```

Happy Learning!
**TrainWithShubham**
