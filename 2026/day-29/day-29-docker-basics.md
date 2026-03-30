# Day 29 – Introduction to Docker
**Date**: March 30, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-29)

## Task Overview


---

## Challenge Tasks

## Task 1: What is Docker?
Research and write short notes on:
- What is a container and why do we need them?
  ```
  Container is a light weight box that has everything your app neeed to run,
  but shares the heavy system parts with the computer it runs on.
  Container is like a virtulization when they run on the docker engine.
  ```
  
- Containers vs Virtual Machines — what's the real difference?


| Feature           | Containers                                   | Virtual Machines                          |
|------------------|----------------------------------------------|-------------------------------------------|
| OS Basis         | Run on the host OS shared kernel             | Each VM includes its own full OS          |
| Resource Model   | Share host system resources                  | Allocated dedicated resources             |
| Performance      | Fast startup and efficient execution         | Slower startup and execution              |
| Weight / Size    | Lightweight and compact                      | Heavier and resource-intensive            |

- What is the Docker architecture? (daemon, client, images, containers, registry)<br/>
`daemon` -It is responsible for running container and managing docker services its run on the host os.<br/>
`client` - Docker user can interact with docker daemon through the docker client. Docker client uses commands and rest api to communicate with the daemon<br/>
`images` - Docker image is blueprint of the container it has all the necessary commands to run app<br/>
`containers` - Container is a light weight box that has everything your app neeeds to run, but shares the heavy system parts with the computerit runs on.Container is like avirtulization when they run on the docker engine.<br/>
`registry` - docker registry is used to store and manage the docker images.<br/>
    `Private` - it is used to share images within enterprises<br/>
    `Public` -  public registry is also called dockerhub<br/>

Draw or describe the Docker architecture in your own words.<br/>

<img width="1147" height="538" alt="client server architecture" src="https://github.com/user-attachments/assets/8c8998e6-12f3-416f-8ead-fbca84e5208e" />


---

## Task 2: Install Docker
1. Install Docker on your machine (or use a cloud instance)
```
sudo apt-get install docker.io
```

<img width="985" height="318" alt="task 2 1" src="https://github.com/user-attachments/assets/f8568cda-c238-42c2-acfb-598525e010d7" /><br/>


2. Verify the installation
```
docker --version
```

3. Run the `hello-world` container
```
docker run hello-world
```

4. Read the output carefully — it explains what just happened



<img width="882" height="638" alt="task 2 2" src="https://github.com/user-attachments/assets/0d225298-8057-4918-bdd5-26109efc1d18" /><br/>



---

## Task 3: Run Real Containers
1. Run an **Nginx** container and access it in your browser
```
docker run -d -p 80:80 nginx
```

<img width="1915" height="470" alt="task 3 a" src="https://github.com/user-attachments/assets/7a38bbe4-2b86-4a47-9aa3-826a63a50fad" /><br/>



<img width="1633" height="805" alt="task 3 b (2)" src="https://github.com/user-attachments/assets/bb26b6c9-31a0-49b2-95b7-63e0de4f740b" /><br/>




2. Run an **Ubuntu** container in interactive mode — explore it like a mini Linux machine
```
docker run -it ubuntu
```



<img width="1635" height="422" alt="task 3 c" src="https://github.com/user-attachments/assets/41152ed3-d823-4770-bfd6-51d74d561ac1" /><br/>



3. List all running containers
```
docker ps
```

4. List all containers (including stopped ones)
```
docker ps -a
```

5. Stop and remove a container
```
docker stop <container-id>
```
```
docker rm <container-id>
```

<img width="1217" height="401" alt="task 3 d" src="https://github.com/user-attachments/assets/c19fe7c1-0711-4d9b-90c7-6bed4f187a34" /><br/>


---

## Task 4: Explore
1. Run a container in **detached mode** — what's different?
```
docker run -d 
```

2. Give a container a custom **name**
```
docker run  --name
```

3. Map a **port** from the container to your host
```
docker run -p 80:80
```

4. Check **logs** of a running container
```
docker logs
```

5. Run a command **inside** a running container


<img width="1422" height="637" alt="task 4" src="https://github.com/user-attachments/assets/d0d39836-a8bf-4338-8723-d34ec2fd6737" /><br/>


---
