# Day 46 – Reusable Workflows & Composite Actions
**Date**: May 5, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-46)

---

## Task Overview

In this task, I learned how to make GitHub Actions workflows reusable using `workflow_call` to avoid repeating the same steps. I also explored passing inputs, secrets, and outputs between workflows, and created a composite action to reuse steps inside a job. This helps in building cleaner and more maintainable CI/CD pipelines.



---


## Challenge Tasks

## Task 1: Understand `workflow_call`
Before writing any code, research and answer in your notes:
1. What is a **reusable workflow**?
  - It’s a workflow you define once and reuse across different workflows instead of writing the same steps again and again.

3. What is the `workflow_call` trigger?
  - `workflow_call` is a trigger that allows a `workflow` to be invoked by another workflow.
    
3. How is calling a reusable workflow different from using a regular action (`uses:`)?
  - `uses` is used to call an action, while `workflow_call` is used to call an entire workflow that can include multiple jobs and steps.

4. Where must a reusable workflow file live?
  - `./.github/worflows`

---

## Task 2: Create Your First Reusable Workflow
Create `.github/workflows/reusable-build.yml`:
1. Set the trigger to `workflow_call`
2. Add an `inputs:` section with:
   - `app_name` (string, required)
   - `environment` (string, required, default: `staging`)
3. Add a `secrets:` section with:
   - `docker_token` (required)
4. Create a job that:
   - Checks out the code
   - Prints `Building <app_name> for <environment>`
   - Prints `Docker token is set: true` (never print the actual secret)

**Verify:** This file alone won't run — it needs a caller. That's next.
#### [reusable-build.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/reusable-build.yml)<br/>


  <img width="958" height="455" alt="task 2" src="https://github.com/user-attachments/assets/585f8b17-393b-4d3d-93fb-55f50103a293" /><br/>


---

## Task 3: Create a Caller Workflow
Create `.github/workflows/call-build.yml`:
1. Trigger on push to `main`
2. Add a job that uses your reusable workflow:
   ```yaml
   jobs:
     build:
       uses: ./.github/workflows/reusable-build.yml
       with:
         app_name: "my-web-app"
         environment: "production"
       secrets:
         docker_token: ${{ secrets.DOCKER_TOKEN }}
   ```
3. Push to `main` and watch it run



**Verify:** In the Actions tab, do you see the caller triggering the reusable workflow? Click into the job — can you see the inputs printed?- yes

#### [call-build.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/workflows/call-build.yml)<br/>


  <img width="813" height="477" alt="task 3" src="https://github.com/user-attachments/assets/e8f3f277-86ad-41c2-b3e5-54dbb6fb2128" /><br/>


---

## Task 4: Add Outputs to the Reusable Workflow
Extend `reusable-build.yml`:
1. Add an `outputs:` section that exposes a `build_version` value
2. Inside the job, generate a version string (e.g., `v1.0-<short-sha>`) and set it as output
3. In your caller workflow, add a second job that:
   - Depends on the build job (`needs:`)
   - Reads and prints the `build_version` output

**Verify:** Does the second job print the version from the reusable workflow?

  <img width="793" height="442" alt="task 4" src="https://github.com/user-attachments/assets/b97b367a-dc8b-4a0c-9131-c8fc171cd4f3" /><br/>


---

## Task 5: Create a Composite Action
Create a **custom composite action** in your repo at `.github/actions/setup-and-greet/action.yml`:
1. Define inputs: `name` and `language` (default: `en`)
2. Add steps that:
   - Print a greeting in the specified language
   - Print the current date and runner OS
   - Set an output called `greeted` with value `true`
3. Use the composite action in a new workflow with `uses: ./.github/actions/setup-and-greet`

**Verify:** Does your custom action run and print the greeting?

#### [action.yml](https://github.com/Akash-Ahir/github-actions-practice/blob/main/.github/actions/setup-and-greet/action.yml)<br/>


  <img width="758" height="642" alt="task 5" src="https://github.com/user-attachments/assets/85869149-cbd4-425b-8679-e4511fcf4154" /><br/>


---

## Task 6: Reusable Workflow vs Composite Action
Fill this in your notes:

| | Reusable Workflow | Composite Action |
|---|---|---|
| Triggered by | `workflow_call` | `uses:` in a step |
| Can contain jobs? | yes | no |
| Can contain multiple steps? | yes | yes |
| Lives where? | ./.github/workflows/ | ./.github/actions/ |
| Can accept secrets directly? | yes | no |
| Best for | reusable jobbs  | reusable steps |

---
