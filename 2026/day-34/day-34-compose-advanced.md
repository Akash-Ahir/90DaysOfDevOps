# Day 34 – Docker Compose: Real-World Multi-Container Apps
**Date**: April 13, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-34)

## Task Overview

This task builds a real world multi container application using Docker Compose, including a web app, database, and cache. It covers service dependencies, health checks, restart policies, custom Docker builds, and the use of networks and volumes, along with basic scaling to understand real-world behavior.


---

# Challenge Tasks

## Task 1: Build Your Own App Stack
### Create a `docker-compose.yml` for a 3-service stack:
#### - A **web app** (use Python Flask, Node.js, or any language you know)
#### - A **database** (Postgres or MySQL)
#### - A **cache** (Redis)

Write a simple Dockerfile for the web app. The app doesn't need to be complex — even a "Hello World" that connects to the database is enough.

### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-34/webapp/Dockerfile)<br/>
---

### Task 2: depends_on & Healthchecks

#### 1. Add `depends_on` to your compose file so the app starts **after** the database
  ```
  depends_on:
    db:
      condition: service_healthy
  ```


#### 2. Add a **healthcheck** on the database service
    
  ```
      healthcheck:
        test: ["CMD-SHELL", "pg_isready -U appuser -d appdb"]
        interval: 5s
        timeout: 3s
        retries: 10
        start_period: 5s
 ```

#### 3. Use `depends_on` with `condition: service_healthy` so the app waits for the database to be truly ready, not just started

**Test:** Bring everything down and up — does the app wait for the DB?-Yes

---

### Task 3: Restart Policies
#### 1. Add `restart: always` to your database service


  ```
  restart: always
  ```

#### 2. Manually kill the database container — does it come back?-- 
  -  `restart: always` - Container restarts after `docker kill` 
#### 3. Try `restart: on-failure` — how is it different?
- `restart: on-failure` - Restarts only when the container exits with a failure it does not behave like `always` for every stop case.

 
  
  ```
  restart: on-failure
  ```


#### 4. Write in your notes: When would you use each restart policy?
   
- `always` → Production databases always restart

 - `on-failure` → Web apps avoid restart loops on manual stops
---

### Task 4: Custom Dockerfiles in Compose

#### 1. Instead of using a pre-built image for your app, use `build:` in your compose file to build from a Dockerfile
#### 2. Make a code change in your app
#### 3. Rebuild and restart with one command
  ```
  web:
    build: .
    image: webapp-frontend
  ```


---

### Task 5: Named Networks & Volumes

#### 1. Define **explicit networks** in your compose file instead of relying on the default
  ```
  networks:
    frontend-network:
      driver: bridge
    backend-network:
      driver: bridge
  ```

#### 2. Define **named volumes** for database data
  
  ```
  volumes:
    postgres_data:
  ```



#### 3. Add **labels** to your services for better organization
  ```
  labels:
    description: "Frontend web app connected to Postgres and Redis"
  ```

  ```
  labels:
    description: "Persistent PostgreSQL database"
  ```


  

  ```
  labels:
    description: "Redis cache for visit counter"
  ```
---

### Task 6: Scaling (Bonus)

#### 1. Try scaling your web app to 3 replicas using `docker compose up --scale`
  ```
  docker compose up --scale web=3
  ```

#### 2. What happens? What breaks?
`Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint webapp-web-3 (f6fce6e9a44ae8cd25802f21b08d3e94f49cfdc0903f51b8cac829c46df7c0b9): Bind for 0.0.0.0:5000 failed: port is already allocated`

-give port error all container fighting for the same port


#### 3. Write in your notes: Why doesn't simple scaling work with port mapping?

  - All web replicas try binding host port `5000` simultaneously

### [docker-compose.yml](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-34/webapp/docker-compose.yml)<br/>

<img width="1912" height="392" alt="Screenshot 2026-04-14 181416" src="https://github.com/user-attachments/assets/c4e5ad95-948e-487f-b1b5-29f2be8caade" /><br/>


<img width="1897" height="730" alt="task " src="https://github.com/user-attachments/assets/b483eb04-e600-428e-a7bd-62887c9f9442" />


--
