# Day 40 – Your First GitHub Actions Workflow
**Date**: April 27, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-40)

## Task Overview



---

## Challenge Tasks

## Task 1: Set Up
1. Create a new **public** GitHub repository called `github-actions-practice`
2. Clone it locally
3. Create the folder structure: `.github/workflows/`
### [Github-Actions-Practice ](https://github.com/Akash-Ahir/github-actions-practice)<br/>

---

## Task 2: Hello Workflow
Create `.github/workflows/hello.yml` with a workflow that:
1. Triggers on every `push`
```
on:
  push:
```
2. Has one job called `greet`
```
jobs:
  greet:
```

3. Runs on `ubuntu-latest`
```
runs-on: ubuntu-latest
```

4. Has two steps:
   - Step 1: Check out the code using `actions/checkout`
   - Step 2: Print `Hello from GitHub Actions!`

Push it. Go to the **Actions** tab on GitHub and watch it run.

**Verify:** Is it green? Click into the job and read every step -  yes

<img width="1918" height="852" alt="2 1" src="https://github.com/user-attachments/assets/7512d06f-fae7-4ea0-b922-3a3a8c6cdaa9" />


---

## Task 3: Understand the Anatomy
Look at your workflow file and write in your notes what each key does:
- `on: Trigger when will workflow work`
- `jobs: The task to perform `
- `runs-on: The designated runner for the jobs`
- `steps: The sequence of command and action `
- `uses: calls a ready-made action`
- `run: executes a shell command on the runner`
- `name: This is the name of the workflow`

---

## Task 4: Add More Steps
Update `hello.yml` to also:
1. Print the current date and time
```
- name: Print current date and time
  run: date
```

2. Print the name of the branch that triggered the run (hint: GitHub provides this as a variable)
```
- name: Print branch name
  run: echo "Branch name is ${{ github.ref_name }}**
```

3. List the files in the repo
```
- name: List repository files
  run: ls -la
```

4. Print the runner's operating system
```
- name: runner operating system
  run: echo "Runner OS is $RUNNER_OS"
```


Push again — watch the new run.

<img width="1901" height="862" alt="4 1" src="https://github.com/user-attachments/assets/cf493a0e-492b-4baf-bffe-578d71696011" />


---

## Task 5: Break It On Purpose
1. Add a step that runs a command that will **fail** (e.g., `exit 1` or a misspelled command)
2. Push and observe what happens in the Actions tab
3. Fix it and push again

### [Workflow](https://github.com/Akash-Ahir/2026/day-40/.github/workflow/hello.yml)<br/>


<img width="1485" height="728" alt="5 1" src="https://github.com/user-attachments/assets/04a99b30-a966-402a-8862-5a909d1004b8" />

after fixing workflow

<img width="1575" height="393" alt="5 2" src="https://github.com/user-attachments/assets/5390e614-41b0-41a2-a77f-b9bba9f5e3c2" />

---
