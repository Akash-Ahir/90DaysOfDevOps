# Day 30 – Docker Images & Container Lifecycle
**Date**: March 31, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-30)

## Task Overview

Understanding how Docker images and containers actually work. I learned how images act as blueprints and how containers move through different states like create, run, pause, stop, and remove.
I also learned image layers and caching, which help Docker stay efficient and lightweight. I practiced working with running containers and cleaned up unused resources to manage space better.

## Challenge Tasks

## Task 1: Docker Images
1. Pull the `nginx`, `ubuntu`, and `alpine` images from Docker Hub
  ```
  docker pull nginx
  docker pull ubuntu
  docker pull alpine
  ```

  <img width="901" height="565" alt="task 1 a" src="https://github.com/user-attachments/assets/e622f550-f28b-4ba6-ab5c-0880378aaa0c" /><br/>


2. List all images on your machine — note the sizes
  ```
  docker images
  ```
  <img width="743" height="127" alt="task 1 b" src="https://github.com/user-attachments/assets/43c9f0f9-8adc-462f-8d15-e5400d67f9e5" /><br/>


3. Compare `ubuntu` vs `alpine` — why is one much smaller?
  ```
  ubuntu will be much bigger
  
  ```

    Alpine-based Docker images are typically much smaller than standard images as they include only the bare essentials needed to run the application
  
---

## Task 2: Image Layers
1. Run `docker image history nginx` — what do you see?
2. Each line is a **layer**. Note how some layers show sizes and some show 0B
3. Write in your notes: What are layers and why does Docker use them?
  ```
  Layers are individual changes stacked on top of each other to form a final Docker image. Each RUN, COPY, or ADD in a Dockerfile usually creates a new layer.
  -Reuse and share the same base layers across many images saving disk space.
  -Cache layers during builds so unchanged steps don’t need to be repeated making builds faster. Such layer‑based caching speeds up CI/CD pipelines and local development
  ```


  <img width="1231" height="460" alt="task 2 a" src="https://github.com/user-attachments/assets/9b433eed-6fb9-4d8d-b4c5-ebf038aa22dd" />


---

## Task 3: Container Lifecycle
Practice the full lifecycle on one container:
1. **Create** a container (without starting it)
  ```
  docker create --name new-nginx-container
  ```
  ```
  docker ps -a
  ```

2. **Start** the container
  ```
    docker start new-nginx-container
  ```
  ```
  docker ps -a
  ```

3. **Pause** it and check status
  ```
  docker pause new-nginx-container
  ```
  ```
  docker ps -a
  ```

4. **Unpause** it
  ```
  docker unpause new-nginx-container
  ```
  ```
  docker ps -a
  ```

5. **Stop** it
  ```
  docker stop new-nginx-container
  ```
  ```
  docker ps -a
  ```

6. **Restart** it
  ```
  docker restart new-nginx-container
  ```
  ```
  docker ps -a
  ```

7. **Kill** it
  ```
  docker kill new-nginx-container
  ```
  ```
  docker ps -a
  ```

8. **Remove** it
  ```
  docker rm new-nginx-container
  ```
  ```
  docker ps -a
  ```

Check `docker ps -a` after each step — observe the state changes.


  <img width="978" height="678" alt="task 3" src="https://github.com/user-attachments/assets/1b8de341-df19-48e1-ad57-1f828ffb1671" /><br/>
  



---

### Task 4: Working with Running Containers
1. Run an Nginx container in detached mode
  ```
  docker run -d --name new-nginx-container -p 80:80 nginx
  ```
2. View its **logs**
  ```
  docker logs new-nginx-container 
  ```


  <img width="1196" height="470" alt="task 4 a" src="https://github.com/user-attachments/assets/18f69300-be31-4b7c-9149-e4fb666fff85" /><br/>


3. View **real-time logs** (follow mode)
  ```
  docker logs -f new-nginx-container
  ```

  <img width="1421" height="361" alt="task 4 b" src="https://github.com/user-attachments/assets/dce628d6-6d54-44e0-b797-030fd32b2d35" /><br/>

4. **Exec** into the container and look around the filesystem
  ```
  docker exec -it new-nginx-container sh
  ```

  <img width="1711" height="571" alt="task 4 c" src="https://github.com/user-attachments/assets/17719dc0-a648-466f-8711-121de78f4189" /><br/>


5. Run a single command inside the container without entering it
   ```
   docker exec new-nginx-container ls /usr/share/nginx/html
   ```

  <img width="1018" height="122" alt="task 4 d" src="https://github.com/user-attachments/assets/ee6f41a5-7b3d-4781-b93d-27fc2b1898ac" /><br/>


6. **Inspect** the container — find its IP address, port mappings, and mounts
  ```
  docker inspect new-nginx-container
  ```
  

<img width="975" height="237" alt="task 4 e-ipadresses" src="https://github.com/user-attachments/assets/fe0b45ab-f43c-4a90-b00a-f6aae5b89e99" /><br/>

<img width="977" height="506" alt="task 4 e-mounts" src="https://github.com/user-attachments/assets/df149329-5c5d-4364-8d70-cd0dce83a5bf" /><br/>

<img width="1132" height="385" alt="task 4 e-port mapping" src="https://github.com/user-attachments/assets/6043654e-3e88-4be2-b1e8-2e037b379cdf" /><br/>

---

### Task 5: Cleanup
1. Stop all running containers in one command
  ```
  docker stop $(docker ps -q)
  ```

2. Remove all stopped containers in one command

  ```
  docker rm $(docker ps -aq)  
  ```
<img width="722" height="300" alt="task 5 a" src="https://github.com/user-attachments/assets/0843dfa3-24e6-47ad-88f1-3598c92e2d0b" />


3. Remove unused images
  ```
  docker rmi <images>
  ```

<img width="1202" height="481" alt="task 5 b" src="https://github.com/user-attachments/assets/1aae32b1-dacd-43f2-b22c-85a39a3fc8c0" />


4. Check how much disk space Docker is using
  ```
  docker system df
  ```

<img width="678" height="197" alt="task 5 c" src="https://github.com/user-attachments/assets/f4591878-e5e7-4913-ab4a-d9d13b6c2d2c" />

---
