# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines
**Date**: May 8, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-47)

## Task Overview
You've used `push` and basic `pull_request` triggers. But GitHub Actions supports **dozens of event types** — today you go deep into PR lifecycle events, scheduled cron jobs, and chaining workflows together.

---

## Challenge Tasks

## Task 1: Pull Request Event Types
Create `.github/workflows/pr-lifecycle.yml` that triggers on `pull_request` with **specific activity types**:
1. Trigger on: `opened`, `synchronize`, `reopened`, `closed`
2. Add steps that:
   - Print which event type fired: `${{ github.event.action }}`
   - Print the PR title: `${{ github.event.pull_request.title }}`
   - Print the PR author: `${{ github.event.pull_request.user.login }}`
   - Print the source branch and target branch
3. Add a conditional step that only runs when the PR is **merged** (closed + merged = true)

Test it: create a PR, push an update to it, then merge it. Watch the workflow fire each time with a different event type.

#### [pr-lifecycle.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/pr-lifecycle.yml)<br/>


### **CLOSED**
<img width="877" height="797" alt="task 1" src="https://github.com/user-attachments/assets/ef4b7a26-91c1-487f-893e-46c157e77bf7" />
<br/>

### **SYNCHRONIZE**
<img width="887" height="781" alt="task 1 2 synchronized" src="https://github.com/user-attachments/assets/66320f80-e934-4072-9a68-68d43c6c914f" />
<br/>

### **REOPENED**
<img width="772" height="785" alt="task 1 2 closed" src="https://github.com/user-attachments/assets/33ec3729-b878-47e7-a839-790506e6db7d" />
<br/>

### **OPENED**
<img width="767" height="717" alt="task 1 3 opened" src="https://github.com/user-attachments/assets/6865b4f3-b2cd-473f-abdb-ee8cffe9e803" />
<br/>


---

## Task 2: PR Validation Workflow
Create `.github/workflows/pr-checks.yml` — a real-world PR gate:
1. Trigger on `pull_request` to `main`
2. Add a job `file-size-check` that:
   - Checks out the code
   - Fails if any file in the PR is larger than 1 MB
3. Add a job `branch-name-check` that:
   - Reads the branch name from `${{ github.head_ref }}`
   - Fails if it doesn't follow the pattern `feature/*`, `fix/*`, or `docs/*`
4. Add a job `pr-body-check` that:
   - Reads the PR body: `${{ github.event.pull_request.body }}`
   - Warns (but doesn't fail) if the PR description is empty

**Verify:** Open a PR from a badly named branch — does the check fail?

#### [pr-checks.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/pr-checks.yml)<br/>



### **FILE SIZE CHECK**
<img width="900" height="617" alt="task  2 1 file size  valid" src="https://github.com/user-attachments/assets/10984ebf-e93d-4c01-ad13-8b8bbd57d617" />

### **INVALID**
<img width="476" height="447" alt="task  2 5 file size  in-valid" src="https://github.com/user-attachments/assets/67f052bf-93bb-4ef4-97ea-db8e823b6e04" />



### **BRANCH NAME**
<img width="677" height="432" alt="task  2 2 branch name valid" src="https://github.com/user-attachments/assets/eb0f1328-464f-49ec-9959-cadfcde57d21" />

### **INVALID**
<img width="462" height="360" alt="task  2  4 branch name invalid" src="https://github.com/user-attachments/assets/e4088e32-796e-402f-91b3-92eb6955abfc" />


## **PR BODY**
<img width="787" height="480" alt="task  2  3 pr body is valid" src="https://github.com/user-attachments/assets/45ff9561-9a6a-4ec5-8cd2-cad49f9d0f0f" />


---

## Task 3: Scheduled Workflows (Cron Deep Dive)
Create `.github/workflows/scheduled-tasks.yml`:
1. Add a `schedule` trigger with cron: `'30 2 * * 1'` (every Monday at 2:30 AM UTC)
2. Add **another** cron entry: `'0 */6 * * *'` (every 6 hours)
3. In the job, print which schedule triggered using `${{ github.event.schedule }}`
4. Add a step that acts as a **health check** — curl a URL and check the response code

#### [scheduled-tasks.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/scheduled-tasks.yml)<br/>


### **MANUAL**
<img width="600" height="450" alt="task  3" src="https://github.com/user-attachments/assets/48733dc9-b815-41f1-82d4-63ecad132f5e" />

### **CRON**
<img width="562" height="396" alt="task  3 1" src="https://github.com/user-attachments/assets/61d47bb3-eeed-4086-b9e2-8fecff3582e2" />




Write in your notes:
- The cron expression for: every weekday at 9 AM IST
    - 30 3 * * 1-5
- The cron expression for: first day of every month at midnight
    - 0 0 1 * *
- Why GitHub says scheduled workflows may be delayed or skipped on inactive repos
    - inactive repos are not as reliable for time-based runs as active pipelines   

**Important:** Also add `workflow_dispatch` so you can test it manually without waiting for the schedule.

---

## Task 4: Path & Branch Filters
Create `.github/workflows/smart-triggers.yml`:
1. Trigger on push but **only** when files in `src/` or `app/` change:
   ```yaml
   on:
     push:
       paths:
         - 'src/**'
         - 'app/**'
   ```
   #### [smart-triggers.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/smart-triggers.yml)<br/>


   <img width="471" height="432" alt="task  4 1" src="https://github.com/user-attachments/assets/5082975d-52d4-41b3-b192-d6ebbd4f7feb" />


3. Add `paths-ignore` in a second workflow that skips runs when only docs change:
   ```yaml
   paths-ignore:
     - '*.md'
     - 'docs/**'
   ```

   #### [smart-trigger-path-ignore.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/smart-trigger-path-ignore.yml)<br/>

   
4. Add branch filters to only trigger on `main` and `release/*` branches
5. Test it: push a change to a `.md` file — does the workflow skip?- **yes**



Write in your notes: When would you use `paths` vs `paths-ignore`?
  `paths` - When we need to trigger a workflow on making changes in particular file path
  `paths-ignore` - When the workflow is set on push but we do not want to push on a particular file changed has done

---

## Task 5: `workflow_run` — Chain Workflows Together
Create two workflows:
1. `.github/workflows/tests.yml` — runs tests on every push
2. `.github/workflows/deploy-after-tests.yml` — triggers **only after** `tests.yml` completes successfully:
   ```yaml
   on:
     workflow_run:
       workflows: ["Run Tests"]
       types: [completed]
   ```
3. In the deploy workflow, add a conditional:
   - Only proceed if the triggering workflow **succeeded** (`${{ github.event.workflow_run.conclusion == 'success' }}`)
   - Print a warning and exit if it failed

**Verify:** Push a commit — does the test workflow run first, then trigger the deploy workflow? 
  - yest fir test workdlow run and after completion of that the deploy workflow triggered
   
   #### [tests.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/tests.yml)<br/>

   #### [deploy-after-tests.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/deploy-after-tests.yml)<br/>




<img width="1282" height="166" alt="5 1" src="https://github.com/user-attachments/assets/06fe2844-8f8c-443f-92ed-581e6c5c2a8b" />

<img width="377" height="412" alt="5 2" src="https://github.com/user-attachments/assets/616884da-feaf-4c22-8bdc-c6d87d24a053" />

<img width="402" height="342" alt="5 3" src="https://github.com/user-attachments/assets/b82e6181-e194-41e5-ac1f-b3aee478bd05" />

<img width="361" height="435" alt="5 4" src="https://github.com/user-attachments/assets/6c09e43a-ec9d-4e64-b8d9-76a946303bc3" />

<img width="490" height="367" alt="5 5" src="https://github.com/user-attachments/assets/60857c0f-6ef8-4cb6-8bdf-fa836ddae339" />

---

## Task 6: `repository_dispatch` — External Event Triggers
1. Create `.github/workflows/external-trigger.yml` with trigger `repository_dispatch`
2. Set it to respond to event type: `deploy-request`
3. Print the client payload: `${{ github.event.client_payload.environment }}`
4. Trigger it using `curl` or `gh`:
   ```bash
   gh api repos/<owner>/<repo>/dispatches \
     -f event_type=deploy-request \
     -f client_payload='{"environment":"production"}'
   ```

Write in your notes: When would an external system (like a Slack bot or monitoring tool) trigger a pipeline?
  -  a monitoring alert that requests rollback, a service desk approval, or a release event from another platform

   #### [external-trigger.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/external-trigger.yml)<br/>



<img width="295" height="332" alt="task 6 1" src="https://github.com/user-attachments/assets/d60560dd-51af-4e51-89fb-0af7b475e757" />

<img width="1320" height="140" alt="task 6 2" src="https://github.com/user-attachments/assets/f90f9dad-1fa6-4c86-bb12-e1c97a1c8505" />




---
