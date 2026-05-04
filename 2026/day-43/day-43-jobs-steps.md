# Day 43 – Jobs, Steps, Env Vars & Conditionals
**Date**: May 2, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-43)

## Task Overview

Instead of running everything in one pipeline, I worked with multiple jobs, passed data between them, and controlled execution using environment variables and conditions.
This is where GitHub Actions starts to feel like a real CI/CD system not just automation, but decision-making and flow control.

---


## Challenge Tasks

## Task 1: Multi-Job Workflow
Create `.github/workflows/multi-job.yml` with 3 jobs:
- `build` — prints "Building the app"
- `test` — prints "Running tests"
- `deploy` — prints "Deploying"

Make `test` run only **after** `build` succeeds.
Make `deploy` run only **after** `test` succeeds.<br/>

#### [Multi-job.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/multi-job.yml)<br/>



<img width="1612" height="551" alt="task 1 1" src="https://github.com/user-attachments/assets/4833f985-254a-4640-85fe-9f09cb0cfc6f" /><br/>

<img width="426" height="393" alt="task 1 2" src="https://github.com/user-attachments/assets/5e08bbc1-d591-4795-a453-555729104be9" /><br/>


**Verify:** Check the workflow graph in the Actions tab — does it show the dependency chain?
  - it correctly shows the dependency chain between build - test - deploy.
---

## Task 2: Environment Variables
In a new workflow, use environment variables at 3 levels:
1. **Workflow level** — `APP_NAME: myapp`
2. **Job level** — `ENVIRONMENT: staging`
3. **Step level** — `VERSION: 1.0.0`

Print all three in a single step and verify each is accessible.

Then use a **GitHub context variable** — print the commit SHA and the actor.

#### [env-vars.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/env-vars.yml)<br/>


<img width="938" height="626" alt="task 2" src="https://github.com/user-attachments/assets/9daf04f8-c90c-4b47-bd04-f54abc9babb9" /><br/>


---

## Task 3: Job Outputs
1. Create a job that **sets an output** — e.g., today's date as a string
2. Create a second job that **reads that output** and prints it
3. Pass the value using `outputs:` and `needs.<job>.outputs.<name>`

#### [job-outputs.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/job-outputs.yml)<br/>


<img width="1373" height="560" alt="task 3 1" src="https://github.com/user-attachments/assets/80f12df6-8afa-433b-940b-71b5b4937411" /><br/>



<img width="1016" height="592" alt="task 3 2" src="https://github.com/user-attachments/assets/a4e6f3e7-812a-40aa-8bbd-739db5dad40c" /><br/>



Write in your notes: Why would you pass outputs between jobs?
 - Share data between isolated jobs
 - Helps in chaining dependent processes

---

## Task 4: Conditionals
In a workflow, add:
1. A step that only runs when the branch is `main`
2. A step that only runs when the previous step **failed**
3. A job that only runs on **push** events, not on pull requests
4. A step with `continue-on-error: true` — what does this do?
   - Pipeline continues execution even if that step fails


#### [Conditionals.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/Conditionals.yml)<br/>


<img width="1360" height="575" alt="task 4 1" src="https://github.com/user-attachments/assets/b2990c54-81f8-486f-ab4b-cf77544e2834" /><br/>

<img width="982" height="858" alt="task 4 2" src="https://github.com/user-attachments/assets/db7c3619-b4cd-492f-bd06-4cb004b03dda" /><br/>

<img width="1488" height="441" alt="task 4 3" src="https://github.com/user-attachments/assets/81ab4605-b634-43e0-a41a-39ed3de98254" /><br/>

<img width="902" height="660" alt="task 4 4" src="https://github.com/user-attachments/assets/d2c1b5ef-5159-45de-bcc0-e3166e08d5be" /><br/>



---

## Task 5: Putting It Together
Create `.github/workflows/smart-pipeline.yml` that:
1. Triggers on push to any branch
2. Has a `lint` job and a `test` job running in parallel
3. Has a `summary` job that runs after both, prints whether it's a `main` branch push or a feature branch push, and prints the commit message

#### [smart-pipeline.yml](https://github.com/Akash-Ahir/flask-app-ecs)<br/>


<img width="1298" height="583" alt="task 5 1" src="https://github.com/user-attachments/assets/7dd6a8e5-d80a-4519-ac7c-9ad12d4056da" /><br/>

<img width="1388" height="432" alt="task 5 2" src="https://github.com/user-attachments/assets/5d98a06d-4ce2-4e03-8941-6bb77b922d66" /><br/>

<img width="1052" height="637" alt="task 5 3" src="https://github.com/user-attachments/assets/65455d8b-f52d-4f63-8750-773717ba396a" /><br/>

<img width="611" height="512" alt="task 5 4" src="https://github.com/user-attachments/assets/2310a79b-dbfa-4188-9884-745ad8641ace" /><br/>





