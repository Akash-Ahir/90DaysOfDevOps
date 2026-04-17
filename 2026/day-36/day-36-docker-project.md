# Day 36 – Docker Project: Dockerize a Full Application
**Date**: April 16, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-36)

## Task Overview

Containerizing a complete AI-Bank Application using Docker. It covers writing an optimized Dockerfile with best practices, setting up a multi-container environment using Docker Compose, and integrating a database with persistent storage. The workflow also includes pushing the image to Docker Hub and verifying that the application runs successfully in a fresh environment, ensuring a production-like setup.

---



## Challenge Tasks

## Task 1: Pick Your App
**AI Bank App** – A Spring Boot-based banking application with MySQL database and Ollama AI integration.
- **Backend Framework**: Java 21, Spring Boot 3.4.1
- **Security Strategy**: Spring Security, IAM OIDC, Secrets Manager
- **Persistence Layer**: MySQL 8.0 (Docker Container)
- **AI Integration**: Ollama (TinyLlama)
- **DevOps Tooling**: Docker, Docker Compose, GitHub Actions, AWS CLI, jq
- **Infrastructure**: Amazon EC2, Amazon ECR, Amazon VPC

### [AI-BankApp](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-36/AI-BankApp)<br/>


---

## Task 2: Write the Dockerfile
#### 1. Create a Dockerfile for your application
#### 2. Use a **multi-stage build** if applicable
#### 3. Use a **non-root user**
#### 4. Keep the image **small** — use alpine or slim base images
#### 5. Add a `.dockerignore` file

### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-36/AI-BankApp/Dockerfile)<br/>


<img width="1177" height="347" alt="task 2 1" src="https://github.com/user-attachments/assets/888998be-0224-4c7d-b142-bff4649470ee" /><br/>

#### Build and test it locally.

---

## Task 3: Add Docker Compose
#### Write a `docker-compose.yml` that includes:
#### 1. Your **app** service (built from Dockerfile)
#### 2. A **database** service (Postgres, MySQL, MongoDB — whatever your app needs)
#### 3. **Volumes** for database persistence
#### 4. A **custom network**
#### 5. **Environment variables** for configuration (use `.env` file)
#### 6. **Healthchecks** on the database


### [docker-compose](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-36/AI-BankApp/docker-compose.yml)<br/>


<img width="1261" height="675" alt="task 3" src="https://github.com/user-attachments/assets/8ce68d52-5a29-4601-9963-a6753ce7cea8" /><br/>


#### Run `docker compose up` and verify everything works together.

<img width="1908" height="147" alt="task 3 2" src="https://github.com/user-attachments/assets/83232530-e675-4ac6-9941-80b0c92040fe" /><br/>

<img width="1912" height="948" alt="task 3 3" src="https://github.com/user-attachments/assets/5d1c036f-0ab7-4c7f-9de7-b08ac7a24bbe" /><br/>

---

## Task 4: Ship It
#### 1. Tag your app image
#### 2. Push it to Docker Hub

<img width="1233" height="501" alt="task 4" src="https://github.com/user-attachments/assets/00f797e2-11e3-4048-88fc-476627b31cfc" /><br/>

<img width="1883" height="756" alt="task 4 1" src="https://github.com/user-attachments/assets/b0cdae0e-7667-4e94-b736-a6ddd51ceb6c" /><br/>
  
#### 3. Share the Docker Hub link
## Docker Hub: https://hub.docker.com/repository/docker/akashahir/ai-bank-app

---

## Task 5: Test the Whole Flow
#### 1. Remove all local images and containers
#### 2. Pull from Docker Hub and run using only your compose file
#### 3. Does it work fresh? If not — fix it until it does

<img width="813" height="490" alt="task 5 1" src="https://github.com/user-attachments/assets/1088cf99-e3e3-4413-8beb-8473ffc19ed2" /><br/>

<img width="1867" height="496" alt="task 5 2" src="https://github.com/user-attachments/assets/480ccb46-c005-486e-893a-02c12d104db7" /><br/>

## Task 6: Application Working & Verification

<img width="1893" height="956" alt="ollma exp" src="https://github.com/user-attachments/assets/657d7272-f55c-4728-822c-bf53f92b7897" /><br/>

#### Ollama Configuration (AI Integration)
   
   <img width="1882" height="452" alt="oolama" src="https://github.com/user-attachments/assets/0148e6b3-2f16-4705-9a4f-e6af1c282033" /><br/>

   <img width="1893" height="956" alt="ollma exp" src="https://github.com/user-attachments/assets/29f4a610-0131-4ed2-8d7d-ed50b4943b75" /><br/>

   <img width="461" height="640" alt="Screenshot 2026-04-16 211333" src="https://github.com/user-attachments/assets/b6ff9a14-efa4-4d3f-ae50-cf07f72e25ab" /><br/>

---

