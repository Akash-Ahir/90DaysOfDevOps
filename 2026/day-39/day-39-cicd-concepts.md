# Day 39 – What is CI/CD?
**Date**: April 19, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-39)


## Task
Before writing a single pipeline, understand **why CI/CD exists** and what it actually does.

Today is a research and diagram day — no pipelines yet. Get the concepts right first.


---

## Challenge Tasks

## Task 1: The Problem

Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

Write in your notes:
1. What can go wrong?<br/>
   Environment mismatches - Production fails because of untracked differences in OS, libs, or configs.<br/>
   Conflicts and overwrites - One developer changes get lost when another pushes simultaneously.<br/>
   Human errors - Forgetting steps like restarting services or updating configs causes downtime.<br/>

3. What does "it works on my machine" mean and why is it a real problem?<br/>
   This happens when local setups your Ubuntu Docker environment differ from serverse like Python 3.11 locally but 3.9 in production, or missing Redis port forwards.

4. How many times a day can a team safely deploy manually?<br/>
   Maybe 1-2 per day 
---

## Task 2: CI vs CD
Research and write short definitions (2-3 lines each):
1. **Continuous Integration** — what happens, how often, what it catches<br/>
    What happens: Developers push small code changes multiple times daily. Automated system immediately builds entire app + runs all tests<br/>
    How often: After every push or pull request<br/>
    What it catches: Integration bugs, dependency conflicts, broken builds.<br/>
   
3. **Continuous Delivery** — how it's different from CI, what "delivery" means<br/>
    Continous integration stops at tests passed. Continous Delivery automates full packaging + deploy to staging environment.<br/>
    Delivery means: Docker image built, tagged, pushed to registry, deployed to staging always ready for production with one click manualy.<br/>

5. **Continuous Deployment** — how it differs from Delivery, when teams use it<br/>
    How it differs: No manual approval needed every test pass auto deploys to production immediately.<br/>


   


---

### Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:
- **Trigger** — what starts the pipeline<br/>
   This is what start the pipeline <br/>
   •  Push- trigger when someone pushes commit to a repository branch or tag<br/>
   •  Pull Request- Trigger when a PR is opened<br/>
   •  Workflow_dispatch- Allows you to manually trigger a workflow through the github ui<br/>
   •  schedual- Trigger at spevcific times using cron syntax<br/>
  
- **Stage** — a logical phase (build, test, deploy)<br/>
  •  It`s a Grouped phases like "build", "test", "deploy" run sequentially or parallel.<br/>
  
- **Job**<br/>
  •  a unit of work inside a stage<br/>
  •  it is a set of one or more steps that execute on a same runner.<br/>
  
- **Step**<br/>
  •  a single command or action inside a job<br/>
  •  it is a individual task inside the jobs execute sequentially on the same runner<br/>
  
- **Runner**<br/>
  •  The machine that executes the job<br/>
  •  every job need a runner <br/>
     
- **Artifact**<br/>
  •  output produced by a job<br/>
  •  Job outputs saved for later like Docker image tar or test reports.<br/>


---

### Task 4: Draw a Pipeline
Draw a CI/CD pipeline for this scenario:<br/>
> A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.<br/>

Include at least 3 stages. Hand-drawn and photographed is perfectly fine.<br/>


<img width="1636" height="898" alt="llll" src="https://github.com/user-attachments/assets/2181ba57-39a2-48e3-b152-efa0f80e2183" /><br/>

---

### Task 5: Explore in the Wild<br/>
1. Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
2. Find their `.github/workflows/` folder
3. Open one workflow YAML file
4. Write in your notes:

### [FASTAPI-WORKFLOW](https://github.com/fastapi/fastapi/blob/master/.github/workflows/build-docs.yml)<br/>

   - What triggers it?<br/>
      - Whenever push to master branch<br/>
      - Wheneversomeone pushes new commit to Pull request<br/>
        
   - How many jobs does it have?<br/>
        4 jobs [changes, langs, build-docs, docs-all-green]<br/>
     
   - What does it do? (best guess)<br/>
      changes- Tracked the changes of Documentaion file<br/>
      langs- Detect languages to build<br/>
      Builds- the documentation site for each language<br/>
      docs-all-green- check the pipeline is successed or not <br/>
      

---

