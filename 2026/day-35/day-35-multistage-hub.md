# Day 35 – Multi-Stage Builds & Docker Hub
**Date**: April 15, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-35)

## Task Overview
This task focuses on optimizing Docker images using multi-stage builds and pushing them to Docker Hub. It includes comparing image sizes, improving efficiency with best practices, and understanding image versioning and distribution.

---

## Challenge Tasks

## Task 1: The Problem with Large Images
#### 1. Write a simple Go, Java, or Node.js app (even a "Hello World" is fine)
#### 2. Create a Dockerfile that builds and runs it in a **single stage**
#### 3. Build the image and check its **size**

### [Application](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-35/multi-build-app)<br/>

### [Dockerfile (Single-Stage)](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-35/multi-build-app/Dockerfile.singlebuild)<br/>

   #### Note down the size — it will be compared later. <br/>


<img width="841" height="58" alt="task 1 1" src="https://github.com/user-attachments/assets/18bc53f1-fab3-422e-a3db-f6e118fef3a5" /><br/>


---

## Task 2: Multi-Stage Build
#### 1. Rewrite the Dockerfile using **multi-stage build**:
   - Stage 1: Build the app (install dependencies, compile)
   - Stage 2: Copy only the built artifact into a minimal base image (`alpine`, `distroless`, or `scratch`)
     
#### 2. Build the image and check its size again


### [Dockerfile (Multi-Stage)](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-35/multi-build-app/Dockerfile.multibuild)<br/>


#### 3. Compare the two sizes

   <img width="842" height="65" alt="task 2 1" src="https://github.com/user-attachments/assets/9a1bff67-0858-464c-affe-e23e048ac277" />


#### Write in your notes: Why is the multi-stage image so much smaller?
   - It removes build dependencies and keeps only the final compiled artifact, reducing unnecessary layers and image size.

---

## Task 3: Push to Docker Hub
#### 1. Create a free account on [Docker Hub](https://hub.docker.com) (if you don't have one)
#### 2. Log in from your terminal
  
  ```
  docker login
  ```

#### 3. Tag your image properly: `yourusername/image-name:tag`
 
  ```
  docker tag node-multi-build akashahir/node-multistage-build:v1.0
  ```

#### 4. Push it to Docker Hub
 
  ```
  docker push akashahir/node-multistage-build:v1.0
  ```
 
  <img width="1081" height="222" alt="task 3 1" src="https://github.com/user-attachments/assets/57592599-27c9-40a4-aac1-dd99326be4d5" /><br/>

  

#### 5. Pull it on a different machine (or after removing locally) to verify

  <img width="1062" height="420" alt="task 3 2" src="https://github.com/user-attachments/assets/41406619-980b-467f-a7af-1ab09fb919eb" /><br/>


---

## Task 4: Docker Hub Repository
#### 1. Go to Docker Hub and check your pushed image
#### 2. Add a **description** to the repository


   <img width="1870" height="820" alt="task 4 1" src="https://github.com/user-attachments/assets/ba6e3211-2d4f-4bfe-b6d4-c4fc2bd02114" /><br/>



#### 3. Explore the **tags** tab — understand how versioning works
#### 4. Pull a specific tag vs `latest` — what happens?
   -pulling tag 1.0
   
   <img width="1867" height="961" alt="task 4 2" src="https://github.com/user-attachments/assets/1e3e16f2-a38c-48a9-b0e8-78be3444d420" /><br/>

  
   #### -pulling latest version

   
   <img width="1877" height="852" alt="task 4 3" src="https://github.com/user-attachments/assets/4f92cd1e-7ee8-4a99-a8e7-253fc94722d4" /><br/>

  


---

## Task 5: Image Best Practices
#### Apply these to one of your images and rebuild:
#### 1. Use a **minimal base image** (alpine vs ubuntu — compare sizes)
#### 2. **Don't run as root** — add a non-root USER in your Dockerfile
#### 3. Combine `RUN` commands to **reduce layers**
#### 4. Use **specific tags** for base images (not `latest`)

  ### [Dockerfile (Users & Group)](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-35/multi-build-app/Dockerfile.multibuild-user-and-group)


   <img width="876" height="102" alt="task 5 1" src="https://github.com/user-attachments/assets/287b1eb7-8710-4d85-8a9d-a382bd4bab59" />


---

