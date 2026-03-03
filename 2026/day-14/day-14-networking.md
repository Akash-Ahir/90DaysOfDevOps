# Day 14 – Networking Fundamentals & Hands-on Checks
**Date**: February 28, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-14)

## Task Overview
Today I checked basic networking on my EC2 instance by finding my IP address, testing google.com
reachability with `ping`, tracing the packet route with traceroute, listing listening ports with `ss -tulpn`,
verifying DNS resolution, and confirming HTTP works with `curl`. I then tested SSH port 22 locally using nc and documented what I'd check if connectivity breaks.

---

## OSI Model-<br/>
OSI Model is a 7-layer theoretical model only like a detailed blueprint:<br/>
`L7`- Application (User interaction)<br/>
`L6`- Presentation (Encryption / Decryption, data formatting)<br/>
`L5`- Session (Login session)<br/>
`L4`- Transport (TCP/UDP, ports, reliable delivery)<br/>
`L3`- Network (IP addresses, routing between networks)<br/>
`L2`- Data link (Ethernet frames, MAC addresses)<br/>
`L1`- Physical (Hardware integration)<br/>

## TCP / IP
TCP/IP Model is a 4-layer practical model what actually uses to make communication over internet:<br/>
`L4`- Application (Application + Presentation + Session)<br/>
`L3`- Transport <br/>
`L2`- Internet (Network)<br/>
`L1`- Network Access (Data Link + Physical)<br/>

----

## **Protocol Locations:**<br/>
Application Layer: HTTP, DNS, SSH, FTP <br/>
Transport Layer:   TCP, UDP  <br/>
Internet Layer:    IP, ICMP <br/>
Network Access:    Ethernet, WiFi <br/>

----
## Hands-on Checklist

### Identity: 
```
hostname -I
```
<img width="582" height="96" alt="2" src="https://github.com/user-attachments/assets/54683a23-ed8e-4499-970b-f83960ac16a1" /><br/>
observation: 172.31.5.197 (EC2 instance ip)


### Reachability: 
```
ping nexustekfusion.in
```
<img width="1370" height="670" alt="3" src="https://github.com/user-attachments/assets/758d6455-da66-4314-9025-17217607f4e3" /><br/>
Observation: 0% packet loss, ~21026ms avg latency 


### Path: 
```
tracepath -m 15 nexustekfusion.in
```
<img width="1200" height="552" alt="4" src="https://github.com/user-attachments/assets/7a925d8f-e392-4083-8458-17f4510a55b3" /><br/>


Observation: 15 hops total, Clear routing path to Google


### Ports: 
```
ss -tulpn
```
<img width="1373" height="515" alt="5" src="https://github.com/user-attachments/assets/86eb6122-fdfc-49e5-94a5-5d35e0a7492f" /><br/>

observation: ssh -> 22

### Name resolution: 
```
dig nexustekfusion.in
```

<img width="1093" height="631" alt="6" src="https://github.com/user-attachments/assets/960d322c-16dd-4af8-a26a-638b581ad493" /><br/>

Output: resolved ip 75.2.60.5<br/>


### HTTP check: 
```
curl -I www.google.com
```
<img width="1412" height="605" alt="7" src="https://github.com/user-attachments/assets/6e82b0c1-31f0-49b6-9373-d8b2d04b376f" /><br/>
Output: HTTP/1.1 200 OK -> Web server responding healthy

### Connections snapshot:
```
netstat -an | head
```
<img width="1105" height="395" alt="8" src="https://github.com/user-attachments/assets/1a39a800-8ce0-4e8b-95c3-679ab7659ef4" /><br/>




----

## Mini Task: Port Probe & Interpret

1) Identifying one listening port from `ss -tulpn`
   <img width="1887" height="67" alt="9" src="https://github.com/user-attachments/assets/48685ec8-bac1-4fe6-ad45-1e0c254bf360" /><br/>
Result: Connection to localhost 22 port [tcp/ssh] succeeded!
     
3) From the same machine, test it: `nc -zv localhost 22`
   <img width="915" height="158" alt="10" src="https://github.com/user-attachments/assets/7ad76d53-36ed-423b-bfe4-4b457f0bd4ad" /><br/>
   

   
4) Test: SSH service reachable locally 

### Reflection<br/>

•  Fastest signal when broken: <br/>
`ping`

• Layer Troubleshooting:

 - Since DNS works via UDP 53 -> Next check Transport (L4) + Network (L3)
 - Response received = L3/L4 working -> Focus Application Layer

• Real Incident Follow-ups:

  - ss -tulpn -> Service listening?
     (SSH:22 confirmed)

  - nc -zv localhost 22 → Port open locally?
    (Connection succeeded)
    
  - curl -I target:PORT -> External access working?

  - sudo ufw status → Firewall blocking?

  - systemctl status <service> → Service healthy?
​


​


​



---

