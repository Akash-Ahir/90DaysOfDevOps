# Day 33 – Docker Compose: Multi-Container Basics
**Date**: April 8, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-33)

## Task overview

Docker Compose simplifies running multi-container applications by using a single configuration file instead of managing containers individually. This task includes setting up Nginx, connecting WordPress with MySQL for communication and data persistence, and using commands and environment variables to manage and configure services efficiently.

---

## Challenge Tasks

## Task 1: Install & Verify
#### 1. Check if Docker Compose is available on your machine
#### 2. Verify the version
  ```
  docker compose version
  ```
  <img width="602" height="75" alt="task 1 1" src="https://github.com/user-attachments/assets/4d14e5b7-b9f0-40a6-8083-7ffa97181f3b" />


---

## Task 2: Your First Compose File
#### 1. Create a folder `compose-basics`
  ```
  mkdir compose-basics
  ```

#### 2. Write a `docker-compose.yml` that runs a single **Nginx** container with port mapping
  ```
  vim docker-compose.yml
  ```
### [Docker-compose.yml](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-33/compose-basics/docker-compose.yml)<br/>


#### 3. Start it with `docker compose up`
  ```
  docker compose up

  ```
  <img width="1606" height="620" alt="task 2 2" src="https://github.com/user-attachments/assets/393e21e9-1ef0-492f-a880-975eeab35646" />


#### 4. Access it in your browser

  <img width="1857" height="551" alt="task 2 3" src="https://github.com/user-attachments/assets/4ecb8012-ba55-4306-b717-4b2b6d4e8d7b" />



#### 5. Stop it with `docker compose down`
  ```
  docker compose down
  ```
  <img width="767" height="106" alt="task 2 4" src="https://github.com/user-attachments/assets/07282cf2-b0e6-4cae-824a-7800db7e113e" />

---

## Task 3: Two-Container Setup
Write a `docker-compose.yml` that runs:
- A **WordPress** container
- A **MySQL** container
### [Docker-compose.yml](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-33/TWO_CONTAINER_SETUP/docker-compose.yml)<br/>

They should:
- Be on the same network (Compose does this automatically)
  <img width="1131" height="302" alt="task 3 2 ntr" src="https://github.com/user-attachments/assets/368c04f3-85b6-45a6-be8f-b9deb25ea2a8" />


- MySQL should have a named volume for data persistence
- WordPress should connect to MySQL using the service name



Start it, access WordPress in your browser, and set it up.
<img width="1893" height="942" alt="task 3 1" src="https://github.com/user-attachments/assets/f33cf152-ca81-496f-adf2-a1723d2309bf" />


**Verify:** Stop and restart with `docker compose down` and `docker compose up` — is your WordPress data still there?-Yes

---

## Task 4: Compose Commands
Practice and document these:
#### 1. Start services in **detached mode**
  ```
  docker compose up -d 

  ```
  <img width="762" height="147" alt="task 4 1" src="https://github.com/user-attachments/assets/d2c41b2c-f1bd-4032-8f4e-3fcd3a5810f9" />



#### 2. View running services

  ```
  docker compose ps

  ```
  <img width="1900" height="117" alt="task 4 2" src="https://github.com/user-attachments/assets/ab2213c2-7a33-487f-9e18-6fb5dbd79603" />


#### 3. View **logs** of all services
  ```
  docker compose logs -f
  ```
  <img width="1892" height="241" alt="task 4 3" src="https://github.com/user-attachments/assets/b06961a7-a1ba-4fc9-b1ad-75f8c6002c72" />


#### 4. View logs of a **specific** service
  ```
  docker compose logs -f mysql

  ```
  ```
  docker compose logs -f wordpress

  ```
  <img width="1898" height="291" alt="task 4 4" src="https://github.com/user-attachments/assets/bd4d7dbb-7953-4be2-8038-179d0ce7d697" />


#### 5. **Stop** services without removing
  ```
  docker compose stop

  ```
  <img width="1527" height="272" alt="task 4 5" src="https://github.com/user-attachments/assets/8ef1d7fb-e9ab-489e-a3cf-07cffb0f7383" />


#### 6. **Remove** everything (containers, networks)
  ```
  docker system prune

  ```
  <img width="907" height="283" alt="task 4 6" src="https://github.com/user-attachments/assets/f1df786f-0ebf-46aa-a979-2c6aa3df70aa" />

---

## Task 5: Environment Variables
1. Add environment variables directly in your `docker-compose.yml`
2. Create a `.env` file and reference variables from it in your compose file
3. Verify the variables are being picked up
  ```
  docker compose exec mysql env | grep MYSQL
  ```
  ```
  docker compose exec wordpress env | grep WORDPRESS
  ```
  ### [.env](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-33/TWO_CONTAINER_SETUP/.env)<br/>

  <img width="1123" height="288" alt="task 5" src="https://github.com/user-attachments/assets/e2bd8d51-c94f-40c2-a9f6-6a19afa9f9ac" />


---

