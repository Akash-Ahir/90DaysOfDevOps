# Day 49 – DevSecOps: Add Security to Your CI/CD Pipeline
**Date**: May 31, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-49)


## Task Overview
You can build and deploy automatically. But what if your Docker image has a known vulnerability? What if someone accidentally commits a password? Today you learn **DevSecOps** — adding simple, automated security checks to your pipeline so problems are caught **before** they reach production.

Don't worry — this isn't a security course. You're just adding a few smart steps to the pipeline you already built.

---



## Challenge Tasks

### Task 1: Scan Your Docker Image for Vulnerabilities
Your Docker image might use a base image with known security issues. Let's find out.

Add this step to your main branch pipeline (after Docker build, before deploy):
```yaml
- name: Scan Docker Image for Vulnerabilities
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'your-username/your-app:latest'
    format: 'table'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'
```

What this does:
- `trivy` scans your Docker image for known CVEs (Common Vulnerabilities and Exposures)
- `format: 'table'` prints a readable table in the logs
- `exit-code: '1'` means **fail the pipeline** if CRITICAL or HIGH vulnerabilities are found
- If it passes, your image is clean — proceed to push and deploy

Push and check the Actions tab. Read the scan output.

<img width="797" height="262" alt="task1" src="https://github.com/user-attachments/assets/6ca7bebf-4856-47e0-bc78-aefc1c2ee2f9" /><br/>


**Verify:** Can you see the vulnerability table in the logs? Did it pass or fail? 
- scan passed

---

### Task 2: Enable GitHub's Built-in Secret Scanning
GitHub can automatically detect if someone pushes a secret (API key, token, password) to your repo.

1. Go to your repo → Settings → **Code security and analysis**
2. Enable **Secret scanning**
3. If available, also enable **Push protection** — this blocks the push entirely if a secret is detected

That's it — no workflow changes needed. GitHub does this automatically.

<img width="955" height="167" alt="task 2" src="https://github.com/user-attachments/assets/9c7cb89e-3560-45cb-ba43-4a9dbf352721" /><br/>


Write in your notes:
- What is the difference between secret scanning and push protection?
  Secret scanning- Secret scanning detects secrets that already exist in the repository and raises alerts
  push protection- Push protection blocks a push if GitHub detects a supported secret before it reaches the repository.


---

### Task 3: Scan Dependencies for Known Vulnerabilities
If your app uses packages (pip, npm, etc.), those packages might have known vulnerabilities.

Add this to your **PR pipeline** (not the main pipeline):
```yaml
- name: Check Dependencies for Vulnerabilities
  uses: actions/dependency-review-action@v4
  with:
    fail-on-severity: critical
```

This checks any **new** dependencies added in the PR against a vulnerability database. If a dependency has a critical CVE, the PR check fails.

Test it:
1. Open a PR that adds a package to your app
2. Check the Actions tab — did the dependency review run?-yes

<img width="1317" height="545" alt="dependencies review error" src="https://github.com/user-attachments/assets/4544442d-2f53-4467-9447-2e44b7ee21c5" /><br/>


**Verify:** Does the dependency review show up as a check on your PR?

---

### Task 4: Add Permissions to Your Workflows
By default, workflows get broad permissions. Lock them down.

Add this block near the top of your workflow files (after `on:`):
```yaml
permissions:
  contents: read
```

If a workflow needs to comment on PRs, add:
```yaml
permissions:
  contents: read
  pull-requests: write
```

Update at least 2 of your existing workflow files with a `permissions` block.

Write in your notes: Why is it a good practice to limit workflow permissions? What could go wrong if a compromised action has write access to your repo?
 - If a compromised GitHub Action had unnecessary write access, it could change repository contents, modify workflows, or abuse the automation pipeline.

---

### Task 5: See the Full Secure Pipeline
Look at what your pipeline does now:

```
PR FLOW:
-------
PR opened
 → Build & Test
 → Dependency Review (NEW)
 → Secret Scan (Gitleaks)
 → SAST (Semgrep)
 → SCA (OWASP Dependency Check)
 → PR checks pass/fail


MAIN BRANCH FLOW:
----------------
Push to main
 → Build Maven App
 → Docker Build
 → Trivy Image Scan (FAIL on HIGH/CRITICAL)
 → Push to ECR
 → Deploy to EC2
 → DAST (OWASP ZAP)


ALWAYS ACTIVE:
-------------
 → GitHub Secret Scanning
 → Push Protection for Secrets
```

Draw this diagram in your notes. You just built a **DevSecOps pipeline** — security is now part of your automation, not an afterthought.

   #### [pr-pipeline.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/blob/main/.github/workflows/pr-pipeline.yml)<br/>
   <img width="786" height="281" alt="prpipeline" src="https://github.com/user-attachments/assets/e5dc0f1b-08fb-43df-a368-af5e7c71c0d7" />
   #### [main-pipeline.yml](https://github.com/Akash-Ahir/CICD-Capstone-Project/blob/main/.github/workflows/main-pipeline.yml)<br/>
   <img width="1270" height="233" alt="mainpipeline" src="https://github.com/user-attachments/assets/5e4dbe9d-9849-4b74-8a41-bccec0a94fbc" />

   


---

