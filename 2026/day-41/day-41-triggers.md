# Day 41 – Triggers & Matrix Builds
**Date**: April 30, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-41)

## Task Overview


---

## Challenge Tasks

## Task 1: Trigger on Pull Request
1. Create `.github/workflows/pr-check.yml`
2. Trigger it only when a pull request is **opened or updated** against `main`
3. Add a step that prints: `PR check running for branch: <branch name>`
4. Create a new branch, push a commit, and open a PR
5. Watch the workflow run automatically

**Verify:** Does it show up on the PR page?-yes

<img width="1092" height="470" alt="task 1" src="https://github.com/user-attachments/assets/18381460-09c9-4ff5-b337-7958961c595a" /><br/>


---

### Task 2: Scheduled Trigger
1. Add a `schedule:` trigger to any workflow using cron syntax
2. Set it to run every day at midnight UTC
3. Write in your notes: What is the cron expression for every Monday at 9 AM - `0 9 * * 1`


<img width="1876" height="615" alt="task 2" src="https://github.com/user-attachments/assets/68355777-71dc-4756-8f70-b99ad5c7ccd6" /><br/>


---

### Task 3: Manual Trigger
1. Create `.github/workflows/manual.yml` with a `workflow_dispatch:` trigger
2. Add an **input** that asks for an `environment` name (staging/production)
3. Print the input value in a step
4. Go to the **Actions** tab → find the workflow → click **Run workflow**

**Verify:** Can you trigger it manually and see your input printed?- yes

<img width="1667" height="667" alt="task 3 1" src="https://github.com/user-attachments/assets/54e67b3f-8e66-4aa8-92fd-2c7b4d22afb3" /><br>


<img width="972" height="578" alt="task 3 2" src="https://github.com/user-attachments/assets/b77847d5-5efa-4d3e-a40f-cf1cc459afd8" /><br/>



---

### Task 4: Matrix Builds
Create `.github/workflows/matrix.yml` that:
1. Uses a matrix strategy to run the same job across:
   - Python versions: `3.10`, `3.11`, `3.12`
2. Each job installs Python and prints the version
3. Watch all 3 run in parallel

Then extend the matrix to also include 2 operating systems — how many total jobs run now? - `6`


<img width="887" height="803" alt="task 4 1" src="https://github.com/user-attachments/assets/3ea9c229-56ef-4cf4-8f7e-e4cfeae44be7" /><br/>


---

### Task 5: Exclude & Fail-Fast
1. In your matrix, **exclude** one specific combination (e.g., Python 3.10 on Windows)

<img width="1036" height="708" alt="task 5 1 skip version and os" src="https://github.com/user-attachments/assets/12b51b3c-3387-40e7-b371-2abd3d222d9a" /><br/>

2. Set `fail-fast: false` — trigger a failure in one job and observe what happens to the rest

<img width="1067" height="710" alt="task 5 2 false faile false" src="https://github.com/user-attachments/assets/4ab0b4ea-badd-44af-bf7b-6c336be910fb" /><br/>

3. Write in your notes: What does `fail-fast: true` (the default) do vs `false`?

<img width="1061" height="622" alt="task 5 3 false faile true" src="https://github.com/user-attachments/assets/698db8a9-812e-4f5a-9541-beff229f5873" /><br/>

