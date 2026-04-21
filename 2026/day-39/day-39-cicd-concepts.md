# Day 39 – What is CI/CD?
**Date**: April 19, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-39)


## Task
Before writing a single pipeline, understand **why CI/CD exists** and what it actually does.

Today is a research and diagram day — no pipelines yet. Get the concepts right first.

---

## Expected Output
- A markdown file: `day-39-cicd-concepts.md`
- A pipeline diagram (hand-drawn or text-based)

---

## Challenge Tasks

## Task 1: The Problem
Think about a team of 5 developers all pushing code to the same repo manually deploying to production.

Write in your notes:
1. What can go wrong?
   Environment mismatches - Production fails because of untracked differences in OS, libs, or configs.
   Conflicts and overwrites - One developer changes get lost when another pushes simultaneously.
   Human errors - Forgetting steps like restarting services or updating configs causes downtime.

3. What does "it works on my machine" mean and why is it a real problem?
   This happens when local setups your Ubuntu Docker environment differ from serverse like Python 3.11 locally but 3.9 in production, or missing Redis port forwards.

4. How many times a day can a team safely deploy manually?
   Maybe 1-2 per day 
---

## Task 2: CI vs CD
Research and write short definitions (2-3 lines each):
1. **Continuous Integration** — what happens, how often, what it catches
    What happens: Developers push small code changes multiple times daily. Automated system immediately builds entire app + runs all tests
    How often: After every push or pull request
    What it catches: Integration bugs, dependency conflicts, broken builds.
   
3. **Continuous Delivery** — how it's different from CI, what "delivery" means
    Continous integration stops at tests passed. Continous Delivery automates full packaging + deploy to staging environment.
    Delivery means: Docker image built, tagged, pushed to registry, deployed to staging always ready for production with one click manualy.

5. **Continuous Deployment** — how it differs from Delivery, when teams use it
    How it differs: No manual approval needed every test pass auto deploys to production immediately.


   
Write one real-world example for each.

---

### Task 3: Pipeline Anatomy
A pipeline has these parts — write what each one does:
- **Trigger** — what starts the pipeline
   This is what start the pipeline 
   •  Push- trigger when someone pushes commit to a repository branch or tag
   •  Pull Request- Trigger when a PR is opened
   •  Workflow_dispatch- Allows you to manually trigger a workflow through the github ui
   •  schedual- Trigger at spevcific times using cron syntax
  
- **Stage** — a logical phase (build, test, deploy)
  •  It`s a Grouped phases like "build", "test", "deploy" run sequentially or parallel.
  
- **Job**
  •  a unit of work inside a stage
  •  it is a set of one or more steps that execute on a same runner.
  
- **Step**
  •  a single command or action inside a job
  •  it is a individual task inside the jobs execute sequentially on the same runner
  
- **Runner**
  •  The machine that executes the job
  •  every job need a runner 
     
- **Artifact**
  •  output produced by a job
  •  Job outputs saved for later like Docker image tar or test reports.


---

### Task 4: Draw a Pipeline
Draw a CI/CD pipeline for this scenario:
> A developer pushes code to GitHub. The app is tested, built into a Docker image, and deployed to a staging server.

Include at least 3 stages. Hand-drawn and photographed is perfectly fine.

---

### Task 5: Explore in the Wild
1. Open any popular open-source repo on GitHub (Kubernetes, React, FastAPI — pick one you know)
2. Find their `.github/workflows/` folder
3. Open one workflow YAML file
4. Write in your notes:
   - What triggers it?
   - How many jobs does it have?
   - What does it do? (best guess)

---

## Hints
- CI/CD is a practice, not just a tool
- GitHub Actions, Jenkins, GitLab CI, CircleCI — all are tools that implement CI/CD
- A pipeline failing is not a problem — it's CI/CD doing its job

---

## Documentation
Create `day-39-cicd-concepts.md` with:
- Your CI vs CD vs CD definitions
- Pipeline anatomy notes
- Your pipeline diagram
- What you found in the open-source repo

---

## Submission
1. Add your `day-39-cicd-concepts.md` to `2026/day-39/`
2. Commit and push to your fork

---

## Learn in Public
Share your pipeline diagram on LinkedIn — even a rough hand-drawn one gets engagement.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

Happy Learning!
**TrainWithShubham**
