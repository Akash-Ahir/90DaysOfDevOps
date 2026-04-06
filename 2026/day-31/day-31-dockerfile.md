# Day 31 – Dockerfile: Build Your Own Images
**Date**: April 1, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-31)
## Task Overview

I started by creating my first Dockerimages with Dockerfile. I learned how different instructions work and how to create custom images instead of just using pre-built ones. Get to know about CMD vs ENTRYPOINT, built a simple Nginx webpage, and understood how .dockerignore and caching improve build performance.

---

## Challenge Tasks

## Task 1: Your First Dockerfile
1. Create a folder called `my-first-image`
  ```
  mkdir my-first-image
  ```

2. Inside it, create a `Dockerfile` that:
  ```  
  vim Dockerfile
  ```
   - Uses `ubuntu` as the base image
   - Installs `curl`
   - Sets a default command to print `"Hello from my custom image!"`
3. Build the image and tag it `my-ubuntu:v1`
4. Run a container from your image

**Verify:** The message prints on `docker run`
### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-31/my-first-image/Dockerfile)<br/>




<img width="820" height="573" alt="task 1" src="https://github.com/user-attachments/assets/3e9dc2f9-4ee7-4c1d-b452-2aa80630021d" />


---

## Task 2: Dockerfile Instructions
Create a new Dockerfile that uses **all** of these instructions:
- `FROM` — base image
- `RUN` — execute commands during build
- `COPY` — copy files from host to image
- `WORKDIR` — set working directory
- `EXPOSE` — document the port
- `CMD` — default command

Build and run it. Understand what each line does.
### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-31/pyhton-fastapi/Dockerfile)<br/>

<img width="1752" height="363" alt="task 2 output" src="https://github.com/user-attachments/assets/4c7f31ef-8fdf-410e-9a76-9b010713cff4" />


---

## Task 3: CMD vs ENTRYPOINT
1. Create an image with `CMD ["echo", "hello"]` — run it, then run it with a custom command. What happens?
   -CMD acts as the default command but when I provide a command in docker run Docker replaces the original CMD completely.




3. Create an image with `ENTRYPOINT ["echo"]` — run it, then run it with additional arguments. What happens?
  -ENTRYPOINT fixes the main command as echo and whatever I pass after docker run my-ubuntu:v2 is appended as arguments to that command.



4. Write in your notes: When would you use CMD vs ENTRYPOINT?
  CMD- when I want to set a default command that users can easily replace.
  ENTRYPOINT- when I want the container to always behave like one specific executable and I only want users to pass extra arguments.



### [Dockerfile---CMD](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-31/my-first-image/Dockerfile---CMD)<br/>
### [Dockerfile---ENTRYPOINT](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-31/my-first-image/Dockerfile---ENTRYPOINT)<br/>


<img width="1078" height="88" alt="task 3 1" src="https://github.com/user-attachments/assets/316c13ee-0fdf-4df6-a9c7-f3b450d7e432" />
<img width="1022" height="111" alt="task 3 2" src="https://github.com/user-attachments/assets/c1628df7-8831-4f49-b64d-2ad81e1cf29e" />



---

## Task 4: Build a Simple Web App Image
1. Create a small static HTML file (`index.html`) with any content
2. Write a Dockerfile that:
   - Uses `nginx:alpine` as base
   - Copies your `index.html` to the Nginx web directory
3. Build and tag it `my-website:v1`
4. Run it with port mapping and access it in your browser
### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-31/Nginx-webpage/Dockerfile)<br/>




<img width="1801" height="677" alt="result website task 4" src="https://github.com/user-attachments/assets/a75c45f9-87f3-47dd-b6c6-cd58a04f9a76" />


---

### Task 5: .dockerignore
1. Create a `.dockerignore` file in one of your project folders
2. Add entries for: `node_modules`, `.git`, `*.md`, `.env`
3. Build the image — verify that ignored files are not included


<img width="666" height="398" alt="task 4 1 without  dockerignore" src="https://github.com/user-attachments/assets/beb654cb-4fb7-41f9-bfd1-b7c3e2fd10c4" />
<img width="650" height="297" alt="task 4 2 with  dockerignore" src="https://github.com/user-attachments/assets/213c84cc-a136-4b73-8084-e7dc2f6a444e" />


---

### Task 6: Build Optimization
1. Build an image, then change one line and rebuild — notice how Docker uses **cache**
2. Reorder your Dockerfile so that frequently changing lines come **last**
3. Write in your notes: Why does layer order matter for build speed?

 
 #### Docker builds images layer by layer and stores each step in cache. If I change an early layer, Docker rebuilds that layer and all the layers after it. That is why Dockerfile order matters. I should keep stable steps at the top and frequently changing steps like `COPY . .` at the end so rebuilds become faster
  




---
