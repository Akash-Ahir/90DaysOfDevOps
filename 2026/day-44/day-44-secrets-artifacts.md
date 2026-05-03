# Day 44 – Secrets, Artifacts & Running Real Tests in CI
**Date**: May 3, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-44)

## Task Overview

Today your pipeline starts doing **real work** — storing sensitive values securely, saving build outputs, and running actual tests from your previous days.

---


## Challenge Tasks

## Task 1: GitHub Secrets
1. Go to your repo → Settings → Secrets and Variables → Actions
2. Create a secret called `MY_SECRET_MESSAGE`
3. Create a workflow that reads it and prints: `The secret is set: true` (never print the actual value)
4. Try to print `${{ secrets.MY_SECRET_MESSAGE }}` directly — what does GitHub show?
    - masks the value in logs instead of showing the real text


    <img width="712" height="527" alt="task 1" src="https://github.com/user-attachments/assets/757b6e37-57a1-4f4e-a6a6-8b235a7bcec5" /><br/>


Write in your notes: Why should you never print secrets in CI logs?
  - because logs are easier to access than secret settings. If a password, token, or API key appears there, anyone with log access may misuse it
---

## Task 2: Use Secrets as Environment Variables
1. Pass a secret to a step as an environment variable
2. Use it in a shell command without ever hardcoding it
3. Add `DOCKER_USERNAME` and `DOCKER_TOKEN` as secrets (you'll need these on Day 45)

  <img width="815" height="410" alt="task 2" src="https://github.com/user-attachments/assets/7fc34d2b-5535-4b7c-a4f5-3efe91bab1a8" /><br/>


---

### Task 3: Upload Artifacts
1. Create a step that generates a file — e.g., a test report or a log file
2. Use `actions/upload-artifact` to save it
3. After the workflow runs, download the artifact from the Actions tab

  <img width="1302" height="748" alt="task 3 1" src="https://github.com/user-attachments/assets/e9649542-67cf-41fb-b6e5-bbfa5a5b032b" /><br/>


**Verify:** Can you see and download it from GitHub?
  -Yes

---

## Task 4: Download Artifacts Between Jobs
1. Job 1: generate a file and upload it as an artifact
2. Job 2: download the artifact from Job 1 and use it (print its contents)

  <img width="1257" height="848" alt="task 4 1" src="https://github.com/user-attachments/assets/42b8b5bd-74e9-4766-83a6-c434c4c0743e" /><br/>



  <img width="1707" height="792" alt="task 4 2" src="https://github.com/user-attachments/assets/549889f3-6878-4f90-a003-275c85e15f76" /><br/>



  


Write in your notes: When would you use artifacts in a real pipeline?
  - When one stage of a pipeline creates something valuable for a later stage or for humans to inspect. 

---

## Task 5: Run Real Tests in CI
Take any script from your earlier days (Python or Shell) and run it in CI:
1. Add your script to the `github-actions-practice` repo
2. Write a workflow that:
   - Checks out the code
   - Installs any dependencies needed
   - Runs the script
   - Fails the pipeline if the script exits with a non-zero code
  
  <img width="1505" height="151" alt="task 5 3" src="https://github.com/user-attachments/assets/9b644f7a-d68b-4cb9-9e27-df7d04a39ab8" /><br/>


3. Intentionally break the script — verify the pipeline goes red -Yes
4. Fix it — verify it goes green again-Done

  <img width="1441" height="786" alt="task 5 1" src="https://github.com/user-attachments/assets/7921d712-2591-4e0a-ace0-4b30a772df7e" /><br/>

  
  <img width="891" height="832" alt="task 5 2" src="https://github.com/user-attachments/assets/07050246-5f9c-44eb-8eba-c1b81afe7a6e" /><br/>


---

## Task 6: Caching
1. Add `actions/cache` to a workflow that installs dependencies
2. Run it twice — observe the time difference
3. Write in your notes: What is being cached and where is it stored?

    - cache stores reusable dependency files so the runner does not need to download them from scratch on every workflow run

  <img width="1288" height="137" alt="task 6 1" src="https://github.com/user-attachments/assets/f42be1eb-2547-4ab9-b7a5-9ff3c79cf1cb" />
  
  <img width="1347" height="95" alt="task 6 2" src="https://github.com/user-attachments/assets/513f8b25-8452-49a7-8d56-43eab54846b5" />
  
  <img width="1283" height="171" alt="task 6 3" src="https://github.com/user-attachments/assets/cc687628-9b77-4f43-9a9f-231860726f0b" />
  
  


---
