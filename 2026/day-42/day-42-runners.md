# Day 42 – Runners: GitHub-Hosted & Self-Hosted
**Date**: May 1, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-42)

## Task Overview
Until now, we’ve been writing workflows, but today we explored the environments that execute them. I worked with both GitHub-hosted runners, which are managed by GitHub, and self-hosted runners, where I set up and controlled my own execution environment on a real machine (EC2).
---


## Challenge Tasks

## Task 1: GitHub-Hosted Runners
#### 1. Create a workflow with 3 jobs, each on a different OS:
   - `ubuntu-latest`
   - `windows-latest`
   - `macos-latest`
#### 2. In each job, print:
   - The OS name
   - The runner's hostname
   - The current user running the job
#### 3. Watch all 3 run in parallel




<img width="962" height="788" alt="task 1" src="https://github.com/user-attachments/assets/581f9306-53ea-454e-872e-929ccf3a3f20" />


#### Write in your notes: What is a GitHub-hosted runner? Who manages it?
  A runner is a simply the server that executed your workflow instruction github runner are computers owned and maintained by github we rent them by a min. 2000 minutes/month are free

---

## Task 2: Explore What's Pre-installed
#### 1. On the `ubuntu-latest` runner, run a step that prints:
   - Docker version
   - Python version
   - Node version
   - Git version
#### 2. Look up the GitHub docs for the full list of pre-installed software on `ubuntu-latest`


<img width="788" height="740" alt="task 2" src="https://github.com/user-attachments/assets/5115a9c6-5819-48e6-b733-92a0e73f227d" />


#### Write in your notes: Why does it matter that runners come with tools pre-installed?
  - Pre-installed tools save setup time, reduce configuration complexity, and ensure consistency across builds. This allows workflows to start faster without manually installing dependencies every time.

---

## Task 3: Set Up a Self-Hosted Runner
#### 1. Go to your GitHub repo → Settings → Actions → Runners → **New self-hosted runner**
#### 2. Choose Linux as the OS
#### 3. Follow the instructions to download and configure the runner on:
   - Your local machine, OR
   - A cloud VM (EC2, Utho, or any VPS)
#### 4. Start the runner — verify it shows as **Idle** in GitHub



#### **Verify:** Your runner appears in the Runners list with a green dot. - Yes


<img width="1080" height="347" alt="task 3" src="https://github.com/user-attachments/assets/5b8ffa1f-db4e-45ca-9086-b9a286be021b" />


---

## Task 4: Use Your Self-Hosted Runner
#### 1. Create `.github/workflows/self-hosted.yml`
#### 2. Set `runs-on: self-hosted`
#### 3. Add steps that:
   - Print the hostname of the machine (it should be YOUR machine/VM)
   - Print the working directory
   - Create a file and verify it exists on your machine after the run
#### 4. Trigger it and watch it run on your own hardware

<img width="1086" height="536" alt="task 4 1" src="https://github.com/user-attachments/assets/99f2c77b-519f-4657-9546-5e9de47c81b3" />




<img width="908" height="92" alt="task 4 2" src="https://github.com/user-attachments/assets/9a70f0e4-e440-42d4-98b3-1bfad5188c9b" />



<img width="1308" height="212" alt="task 4 3" src="https://github.com/user-attachments/assets/76c79dce-88ec-4d00-9372-72ab7e4087f0" />




#### **Verify:** Check your machine — is the file there?- Yes 

---

## Task 5: Labels
#### 1. Add a **label** to your self-hosted runner (e.g., `my-linux-runner`)
#### 2. Update your workflow to use `runs-on: [self-hosted, my-linux-runner]`
#### 3. Trigger it — does it still pick up the job?

<img width="983" height="67" alt="task 5 1" src="https://github.com/user-attachments/assets/b16550d7-4891-4cdd-95c1-174e8e22d0e1" />



<img width="761" height="142" alt="task 5 2" src="https://github.com/user-attachments/assets/0d5ab3f5-1fac-4775-88a1-9da7f8d972bd" />




<img width="843" height="417" alt="task 5" src="https://github.com/user-attachments/assets/6e24c0dc-14b4-4740-8de4-9f7863725ec1" />


#### Write in your notes: Why are labels useful when you have multiple self-hosted runners?
  - Labels allow you to target specific self-hosted runners when multiple runners are available.

---

## Task 6: GitHub-Hosted vs Self-Hosted
#### Fill this in your notes:

| | GitHub-Hosted | Self-Hosted |
|---|---|---|
| Who manages it? | GitHub | you |
| Cost | 	2,000 free per month | My infra like cloud ,or own |
| Pre-installed tools | Yes | No |
| Good for | Quick test , builds | Custom env, large data, cost savings |
| Security concern | Handle  Github | We need to secure it |

---
