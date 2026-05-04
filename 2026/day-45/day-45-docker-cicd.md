# Day 45 – Docker Build & Push in GitHub Actions
**Date**: May 4, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-45)

## Task


---


## Challenge Tasks

## Task 1: Prepare
1. Use the app you Dockerized on Day 36 (or any simple Dockerfile)
2. Add the Dockerfile to your `github-actions-practice` repo (or create a minimal one)
3. Make sure `DOCKER_USERNAME` and `DOCKER_TOKEN` secrets are set from Day 44

---

## Task 2: Build the Docker Image in CI
Create `.github/workflows/docker-publish.yml` that:
1. Triggers on push to `main`
2. Checks out the code
3. Builds the Docker image and tags it

#### [docker-publish.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/docker-publish.yml)<br/>


<img width="1087" height="582" alt="task 2" src="https://github.com/user-attachments/assets/4d4b9ea9-34fb-41a1-b9fc-758969a9bdce" />


**Verify:** Check the build step logs — does the image build successfully? - **Yes**

---

## Task 3: Push to Docker Hub
Add steps to:
1. Log in to Docker Hub using your secrets
2. Tag the image as `username/repo:latest` and also `username/repo:sha-<short-commit-hash>`
3. Push both tags

<img width="1377" height="868" alt="task 3 1" src="https://github.com/user-attachments/assets/20995440-0dc5-4744-af0e-0ffb888f7196" /><br/>

<img width="901" height="662" alt="task 3 2" src="https://github.com/user-attachments/assets/9d3f1351-7155-4f6c-b64b-dabd07ba2c1b" /><br/>



**Verify:** Go to Docker Hub — is your image there with both tags? - **Yes**

---

## Task 4: Only Push on Main
Add a condition so the push step only runs on the `main` branch — not on feature branches or PRs.

<img width="1077" height="752" alt="task 4 2" src="https://github.com/user-attachments/assets/65442a62-1436-4feb-90ad-80bdeae2bf42" /><br/>



Test it: push to a feature branch and verify the image is built but NOT pushed.

<img width="742" height="732" alt="task 4 1" src="https://github.com/user-attachments/assets/72ff1fd2-599d-4f80-95a5-4d57a0905a62" /><br/>


---

## Task 5: Add a Status Badge
1. Get the badge URL for your `docker-publish` workflow from the Actions tab
2. Add it to your `README.md`
3. Push — the badge should show green

[![Docker publish](https://github.com/Akash-Ahir/github-actions-practice/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/Akash-Ahir/github-actions-practice/actions/workflows/docker-publish.yml)

---

## Task 6: Pull and Run It
1. On your local machine (or a cloud server), pull the image you just pushed
2. Run it
3. Confirm it works


<img width="532" height="147" alt="task 6 2" src="https://github.com/user-attachments/assets/40d47294-53f5-448b-920a-3a713028277d" /><br/>

<img width="1917" height="343" alt="task 6 1" src="https://github.com/user-attachments/assets/a64ef546-1e9e-489b-b6c2-1f80c8722b4d" /><br/>



Write in your notes: What is the full journey from `git push` to a running container?

- After git push, the GitHub Actions workflow is triggered and starts executing.
The repository code is checked out
`uses: actions/checkout@v4`

- Docker Hub login is performed using stored secrets username and token
`uses: docker/login-action@v3`

- The Docker image is then built from the application source code
and tagged with two versions:
`latest and sha-<commit>`

- The built image is pushed to Docker Hub

- The image is pulled from Docker Hub

- The same image is referenced in docker-compose.yml

- docker compose up

- The container is started using the pulled image

git push -> GitHub Actions (build + login + push) -> Docker Hub -> pull -> run container -> application running






---
