# Day 34 – Docker Compose: Real-World Multi-Container Apps
**Date**: April 13, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-34)

## Task


---

## Challenge Tasks

## Task 1: Build Your Own App Stack
Create a `docker-compose.yml` for a 3-service stack:
- A **web app** (use Python Flask, Node.js, or any language you know)
- A **database** (Postgres or MySQL)
- A **cache** (Redis)

Write a simple Dockerfile for the web app. The app doesn't need to be complex — even a "Hello World" that connects to the database is enough.
### [Dockerfile](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-34/webapp/Dockerfile)<br/>
---

### Task 2: depends_on & Healthchecks
1. Add `depends_on` to your compose file so the app starts **after** the database
  """
    depends_on:
      db:
        condition: service_healthy
  """


3. Add a **healthcheck** on the database service
   """
  healthcheck:
      test: ["CMD-SHELL", "pg_isready -U appuser -d appdb"]
      interval: 5s
      timeout: 3s
      retries: 10
      start_period: 5s
   """

5. Use `depends_on` with `condition: service_healthy` so the app waits for the database to be truly ready, not just started

**Test:** Bring everything down and up — does the app wait for the DB?-yes

---

### Task 3: Restart Policies
1. Add `restart: always` to your database service
  """
  restart: always
  """

3. Manually kill the database container — does it come back?
4. Try `restart: on-failure` — how is it different?
  """
  restart: on-failure
  """

6. Write in your notes: When would you use each restart policy?
   



---

### Task 4: Custom Dockerfiles in Compose
1. Instead of using a pre-built image for your app, use `build:` in your compose file to build from a Dockerfile
2. Make a code change in your app
3. Rebuild and restart with one command
  """
  web:
    build: .
    image: webapp-frontend
  """


---

### Task 5: Named Networks & Volumes
1. Define **explicit networks** in your compose file instead of relying on the default
  """
  networks:
  frontend-network:
    driver: bridge
  backend-network:
    driver: bridge
  """

3. Define **named volumes** for database data
  """
  volumes:
  postgres_data:
  """



5. Add **labels** to your services for better organization
  """
   labels:
      description: "Frontend web app connected to Postgres and Redis"
  """

  """
       labels:
      description: "Persistent PostgreSQL database"
  """
  """
  labels:
        description: "Redis cache for visit counter"
  """
---

### Task 6: Scaling (Bonus)
1. Try scaling your web app to 3 replicas using `docker compose up --scale`
2. What happens? What breaks?
3. Write in your notes: Why doesn't simple scaling work with port mapping?

---
