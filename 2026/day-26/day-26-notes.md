# Day 26 – GitHub CLI: Manage GitHub from Your Terminal
**Date**: March 24, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-26)

## Task Overview

Learned about github cli and how to use the GitHub CLI (gh) to manage GitHub directly from the terminal. I practiced creating repos, handling issues and pull requests, and exploring workflows—all without using the browser. This made development faster and showed how tasks can be automated efficiently.


---


## Challenge Tasks

## Task 1: Install and Authenticate
1. Install the GitHub CLI on your machine
2. Authenticate with your GitHub account
3. Verify you're logged in and check which account is active
     <img width="928" height="163" alt="task 1" src="https://github.com/user-attachments/assets/6572e629-5118-44d3-b13c-1ddde6612142" />

5. Answer in your notes: What authentication methods does `gh` support?
  Browser-based, Personal Access Token, SSH certificate.


---

## Task 2: Working with Repositories
1. Create a **new GitHub repo** directly from the terminal — make it public with a README
    <img width="911" height="297" alt="task 2 a" src="https://github.com/user-attachments/assets/addb4a7a-ee3f-4100-bff8-b241eba92032" />


2. Clone a repo using `gh` instead of `git clone`
    <img width="897" height="370" alt="task 2 b" src="https://github.com/user-attachments/assets/e7776ec5-9ee7-46ae-9473-3caf62659ce8" />


3. View details of one of your repos from the terminal
   


4. List all your repositories
     <img width="1917" height="587" alt="task 2 c" src="https://github.com/user-attachments/assets/aa02c52d-3f3c-43f0-81e8-622a9bd93ac5" />

5. Open a repo in your browser directly from the terminal
    <img width="1332" height="336" alt="task 2 d" src="https://github.com/user-attachments/assets/803dc074-3503-4e4d-9624-5e950bb156c7" />


6. Delete the test repo you created (be careful!)
    
---

## Task 3: Issues
1. Create an issue on one of your repos from the terminal — give it a title, body, and a label
2. List all open issues on that repo
3. View a specific issue by its number
4. Close an issue from the terminal
    <img width="1911" height="432" alt="task 3" src="https://github.com/user-attachments/assets/48949a3d-14e0-4db7-afb5-61a03e98b4d9" />


5. Answer in your notes: How could you use `gh issue` in a script or automation?
    gh issue list, gh issue comment, gh issue close


---

## Task 4: Pull Requests
1. Create a branch, make a change, push it, and create a **pull request** entirely from the terminal
    <img width="852" height="627" alt="task 4 a" src="https://github.com/user-attachments/assets/a126c7b5-424e-48ec-a0ec-6977c2fa5d59" />
    



2. List all open PRs on a repo
3. View the details of your PR — check its status, reviewers, and checks
4. Merge your PR from the terminal
    <img width="1786" height="655" alt="task 4 b" src="https://github.com/user-attachments/assets/00ae9c17-91b8-4db9-988f-c2044e1c81ef" />

5. Answer in your notes:
   - What merge methods does `gh pr merge` support?
       merge, squash, rebase, auto
   - How would you review someone else's PR using `gh`?
       gh pr view, gh pr review

---

## Task 5: GitHub Actions & Workflows (Preview)
1. List the workflow runs on any public repo that uses GitHub Actions
2. View the status of a specific workflow run
    <img width="1898" height="578" alt="task 5" src="https://github.com/user-attachments/assets/15781aa5-cbfc-490b-9880-903ffd4eb5d5" />


3. Answer in your notes: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?
    Monitor workflow failures, Retry failed runs


(Don't worry if you haven't learned GitHub Actions yet — this is a preview for upcoming days)

---

## Task 6: Useful `gh` Tricks
Explore and try these — add the ones you find useful to your `git-commands.md`:
1. `gh api` — make raw GitHub API calls from the terminal
    <img width="1196" height="127" alt="task 6" src="https://github.com/user-attachments/assets/f8e22a78-d6f5-4808-a829-cabc5dc07adb" />


2. `gh gist` — create and manage GitHub Gists
3. `gh release` — create and manage releases
4. `gh alias` — create shortcuts for commands you use often
5. `gh search repos` — search GitHub repos from the terminal

    <img width="1657" height="423" alt="task 6 b" src="https://github.com/user-attachments/assets/17a191ad-2fd2-4244-b064-d69393052cfa" />


