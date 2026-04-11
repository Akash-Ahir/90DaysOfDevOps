# Day 32 – Docker Volumes & Networking
**Date**: April 6, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-32)

## Task Overview

How Docker handles data persistence and container communication. I experimented with volumes to prevent data loss and used custom networks to enable seamless communication between containers using names instead of IP addresses.

---

## Challenge Tasks

## Task 1: The Problem
  #### 1. Run a Postgres or MySQL container
  ```
  docker run -d -e MYSQL_ROOT_PASSWORD=root mysql
  ```
<img width="932" height="457" alt="task 1 1" src="https://github.com/user-attachments/assets/c9fc1f4e-31b4-4904-b1d2-c2798464cf9d" /><br/>

#### 2. Create some data inside it (a table, a few rows — anything)
  ```
  CREATE DATABASE imp_data;

  ```
<img width="456" height="241" alt="task 1 2" src="https://github.com/user-attachments/assets/4060ba83-07fa-4708-b0bc-a77aedbf01ed" />


#### 3. Stop and remove the container
  ```
  docker stop <container id> && docker rm <container id>
  ```

#### 4. Run a new one — is your data still there?-no
<img width="686" height="227" alt="task 1 3" src="https://github.com/user-attachments/assets/90e028cc-9a6f-42a7-b796-f70619b63d71" />


Write what happened and why.

---

## Task 2: Named Volumes
#### 1. Create a named volume
  ```
  docker volume create mysql-data
  ```
<img width="710" height="113" alt="task 2 1" src="https://github.com/user-attachments/assets/b962eab5-7dfd-4e53-a31d-0d15a88e0909" />

#### 2. Run the same database container, but this time **attach the volume** to it
  ```
  docker run -d -v  mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql
  ```

#### 3. Add some data, stop and remove the container
 <img width="902" height="492" alt="task 2 2" src="https://github.com/user-attachments/assets/227b4488-9f90-44b2-87bf-2f754ad30348" />

#### 4. Run a brand new container with the **same volume**
 <img width="1027" height="651" alt="task 2 3" src="https://github.com/user-attachments/assets/9d3a0b5d-e475-467c-b5c0-1ec5689ae72e" />

#### 5. Is the data still there?-yes

**Verify:** `docker volume ls`, `docker volume inspect`
<img width="677" height="383" alt="task 2 4" src="https://github.com/user-attachments/assets/61df6177-5f02-415a-a2d5-060479cf7630" />

---

## Task 3: Bind Mounts
#### 1. Create a folder on your host machine with an `index.html` file
#### 2. Run an Nginx container and **bind mount** your folder to the Nginx web directory
 
  ```
  docker run -d -v /home/ubuntu/devops-nginx/data:/usr/share/nginx/html -p 80:80 nginx
  ```
<img width="1670" height="122" alt="task 3 2" src="https://github.com/user-attachments/assets/1ff7bcdc-f32b-45d0-9548-b15fa64c9fc0" />

#### 3. Access the page in your browser
  <img width="1788" height="932" alt="task 3 4" src="https://github.com/user-attachments/assets/00f66359-5c7a-44d2-bc66-99848b506520" />

#### 4. Edit the `index.html` on your host — refresh the browser
  <img width="1637" height="950" alt="task 3 5" src="https://github.com/user-attachments/assets/3d69be2c-b79b-4f65-a924-7aec5c9c2284" />

#### Write in your notes: What is the difference between a named volume and a bind mount?
bind mount- linkimg a specific folder on your actual laptop into the container.
named volume- create a seperate volume space and mount/attach to the database/container.
---

## Task 4: Docker Networking Basics
#### 1. List all Docker networks on your machine
  ```
  docker network ls
  ```
<img width="1002" height="486" alt="task 4 1" src="https://github.com/user-attachments/assets/d6ed62f3-687c-4c9b-92ac-e66b7cf97b41" />

#### 2. Inspect the default `bridge` network
  ```
  docker network inspect bridge
  ```
<img width="1002" height="486" alt="task 4 1" src="https://github.com/user-attachments/assets/e6e987a9-8ec1-47b0-9b59-3d8356a286b6" />

#### 3. Run two containers on the default bridge — can they ping each other by **name**?-no

#### 4. Run two containers on the default bridge — can they ping each other by **IP**?-yes
<img width="1067" height="571" alt="task 4 2" src="https://github.com/user-attachments/assets/abcdcda4-e575-4c0b-8461-20839044dad4" />


---

## Task 5: Custom Networks
#### 1. Create a custom bridge network called `my-app-net`
  ```
  docker network create my-app-net
  ```
  <img width="837" height="257" alt="task 5 1" src="https://github.com/user-attachments/assets/3e31f8b7-69dc-405a-a021-a7ce27ea9287" />


#### 2. Run two containers on `my-app-net`
  ```
  docker run -itd --name ubuntucontainer-1 --network my-app-net ubuntu
  docker run -itd --name ubuntucontainer-2 --network my-app-net ubuntu
  ```
  <img width="1233" height="332" alt="task 5 2" src="https://github.com/user-attachments/assets/336793aa-e3aa-4cc2-8995-835bb95a0f90" />


#### 3. Can they ping each other by **name** now?-yes
  ```
  docker exec -it ubuntucontainer-1 bash
  
  ```

  ```
  ping ubuntucontainer-2
  ```
  <img width="1060" height="213" alt="task 5 3" src="https://github.com/user-attachments/assets/ff26a3d7-55ec-41b4-b69d-c0311b1a2ae8" />

  
#### 4. Write in your notes: Why does custom networking allow name-based communication but the default bridge doesn't?
      -Custom networks have built-in Docker DNS that automatically resolves container names to IPs

---

## Task 6: Put It Together
#### 1. Create a custom network
  ```
  docker network create custom-network
  ```
  <img width="827" height="292" alt="task 6 1" src="https://github.com/user-attachments/assets/b18bd9fa-9940-4700-b895-4f63b3878b6f" />

  
#### 2. Run a **database container** (MySQL/Postgres) on that network with a volume for data
  ```
  docker run -d --name mysql -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 --network custom-network mysql
  ```
  <img width="1795" height="177" alt="task 6 2" src="https://github.com/user-attachments/assets/738b7c02-36d0-46b0-8b23-a7e42c19a194" />

#### 3. Run an **app container** (use any image) on the same network
  ```
  docker run -d --name application-cont -e MYSQL_HOST=mysql -e MYSQL_USER=root -e MYSQL_PASSWORD=root -e MYSQL_DB=dev -p 5000:5000 --network custom-network flask-app:latest
  ```
  <img width="1713" height="358" alt="task 6 3" src="https://github.com/user-attachments/assets/5e30eae5-5b45-4eda-804c-3ab58202662d" />

#### 4. Verify the app container can reach the database by container name -yes

  ```
  ping mysql
  ```
  <img width="1713" height="281" alt="task 6 4" src="https://github.com/user-attachments/assets/25635451-eac8-4485-b752-80a7345b13f4" />

---
