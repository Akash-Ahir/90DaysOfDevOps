# Day 48 – GitHub Actions Project: End-to-End CI/CD Pipeline
**Date**: May 14, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-48)


## Task
You've learned workflows, triggers, secrets, Docker builds, reusable workflows, and advanced events. Today you **put it all together** in one project — a complete, production-style CI/CD pipeline that builds, tests, and deploys using everything you've learned from Day 40 to Day 47.

This is your GitHub Actions capstone.

---

## Challenge Tasks

## Task 1: Set Up the Project Repo
1. Create a new repo called `github-actions-capstone` (or use your existing `github-actions-practice`)
2. Add a simple app — pick any one:
   - A Python Flask/FastAPI app with one endpoint
   - A Node.js Express app with one endpoint
   - Your Dockerized app from Day 36
3. Add a `Dockerfile` and a basic test (even a script that curls the health endpoint counts)
4. Add a `README.md` with a project description

---

## Task 2: Reusable Workflow — Build & Test
Create `.github/workflows/reusable-build-test.yml`:
1. Trigger: `workflow_call`
2. Inputs: `python_version` (or `node_version`), `run_tests` (boolean, default: true)
3. Steps:
   - Check out code
   - Set up the language runtime
   - Install dependencies
   - Run tests (only if `run_tests` is true)
   - Set output: `test_result` with value `passed` or `failed`

This workflow does NOT deploy — it only builds and tests.

#### [reusable-build-test.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/tree/main/.github/workflows/reusable-build-test.yml)<br/>




---

## Task 3: Reusable Workflow — Docker Build & Push
Create `.github/workflows/reusable-docker.yml`:
1. Trigger: `workflow_call`
2. Inputs: `image_name` (string), `tag` (string)
3. Secrets: `docker_username`, `docker_token`
4. Steps:
   - Check out code
   - Log in to Docker Hub
   - Build and push the image with the given tag
   - Set output: `image_url` with the full image path
  
#### [reusable-docker.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/tree/main/.github/workflows/reusable-docker.yml)<br/>


---

## Task 4: PR Pipeline
Create `.github/workflows/pr-pipeline.yml`:
1. Trigger: `pull_request` to `main` (types: `opened`, `synchronize`)
2. Call the reusable build-test workflow:
   - Run tests: `true`
3. Add a standalone job `pr-comment` that:
   - Runs after the build-test job
   - Prints a summary: "PR checks passed for branch: `<branch>`"
4. Do **NOT** build or push Docker images on PRs

**Verify:** Open a PR — does it run tests only (no Docker push)? - yes


#### [pr-pipeline.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/tree/main/.github/workflows/pr-pipeline.yml)<br/>

<img width="352" height="477" alt="task 4 1" src="https://github.com/user-attachments/assets/222f595e-2083-48b4-a27e-c2882569a395" /><br/>

<img width="527" height="320" alt="task 4 2" src="https://github.com/user-attachments/assets/ccafd10e-c295-4325-8472-43d9f4ef6322" /><br/>

<img width="682" height="362" alt="task 4 3" src="https://github.com/user-attachments/assets/a4da2894-c885-4fbe-bb1e-7740a9ecb310" /><br/>



---

## Task 5: Main Branch Pipeline
Create `.github/workflows/main-pipeline.yml`:
1. Trigger: `push` to `main`
2. Job 1: Call the reusable build-test workflow
3. Job 2 (depends on Job 1): Call the reusable Docker workflow
   - Tag: `latest` and `sha-<short-commit-hash>`
4. Job 3 (depends on Job 2): `deploy` job that:
   - Prints "Deploying image: `<image_url>` to production"
   - Uses `environment: production` (set this up in repo Settings → Environments)
   - Requires manual approval if you've set up environment protection rules

**Verify:** Merge a PR to `main` — does it run tests → build Docker → deploy in sequence?


#### [main-pipeline.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/tree/main/.github/workflows/main-pipeline.yml)<br/>

<img width="1532" height="506" alt="task 5 1" src="https://github.com/user-attachments/assets/d2a40c95-81c7-4047-8a3b-47eeb71c9552" /><br/>

<img width="1011" height="352" alt="task 5 2" src="https://github.com/user-attachments/assets/15dfb06e-ac4e-4f08-8d02-06082c5381f7" /><br/>

<img width="517" height="311" alt="task 5 3" src="https://github.com/user-attachments/assets/356037b6-b1f0-4d1b-8a39-53c1e1eaef87" /><br/>






---

### Task 6: Scheduled Health Check
Create `.github/workflows/health-check.yml`:
1. Trigger: `schedule` with cron `'0 */12 * * *'` (every 12 hours) + `workflow_dispatch` for manual testing
2. Steps:
   - Pull your latest Docker image
   - Run the container in detached mode
   - Wait 5 seconds, then curl the health endpoint
   - Print pass/fail based on the response
   - Stop and remove the container
3. Add a step that creates a summary using `$GITHUB_STEP_SUMMARY`:
   ```bash
   echo "## Health Check Report" >> $GITHUB_STEP_SUMMARY
   echo "- Image: myapp:latest" >> $GITHUB_STEP_SUMMARY
   echo "- Status: PASSED" >> $GITHUB_STEP_SUMMARY
   echo "- Time: $(date)" >> $GITHUB_STEP_SUMMARY
   ```


   #### [health-check.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/tree/main/.github/workflows/health-check.yml)<br/>

   <img width="332" height="240" alt="task 6 1" src="https://github.com/user-attachments/assets/0adbd075-09e8-4888-988b-924aecc118ed" /><br/>

   <img width="442" height="221" alt="image" src="https://github.com/user-attachments/assets/1d99c451-0539-4c16-94fe-5751605e5306" /><br/>

 





---

### Task 7: Add Badges & Documentation
1. Add status badges for all your workflows to the repo `README.md`
2. Add a **pipeline architecture diagram** in your notes — draw (or describe) the flow:
   ```
   PR opened → build & test → PR checks pass
   Merge to main → build & test → Docker build & push → deploy
   Every 12 hours → health check
   ```

 #### [README.md](https://github.com/Akash-Ahir/CICD-Capstone-Project/README.md)<br/>
    
 <img width="506" height="275" alt="task 6 3" src="https://github.com/user-attachments/assets/c102e3e3-5258-4834-8d60-38fe89948903" /><br/>

---

## Brownie Points: Add Security to Your Pipeline
Want to go above and beyond? Add a **DevSecOps** step to your main pipeline:
1. Add `aquasecurity/trivy-action` after the Docker build step to scan your image for vulnerabilities
2. Fail the pipeline if any **CRITICAL** severity CVE is found
3. Upload the scan report as an artifact

<img width="667" height="332" alt="task brownie" src="https://github.com/user-attachments/assets/1ea43177-51c9-49bc-9308-36b18a98b868" /><br/>



---

