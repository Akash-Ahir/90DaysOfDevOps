# Day 22 – Introduction to Git: Your First Repository
**Date**: March 19, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-23)

## Task Overview


## Challenge Tasks

### Task 1: Understanding Branches

1. What is a branch in Git?

ANSWER: A branch is a parallel workspace. You can create a copy of the project to test the idea. If it fails, you delete the branch. The main project stay safe.



2. Why do we use branches instead of committing everything to `main`?

ANSWER: If we direct commited to main branch then if the feature or idea has some error or failed then the main project get affected onces our testing and verification gets done and everything works greate then we merged it with main 



3. What is `HEAD` in Git?

ANSWER: HEAD is a pointer to the current branch you're working on. Whenever we switch to the different branch the pointer pointed to that branch.




4. What happens to your files when you switch branches?

ANSWER: Git automatically switches your working files to match the branch's state

---

### Task 2: Branching Commands — Hands-On
In your `devops-git-practice` repo, perform the following:
1. List all branches in your repo
2. Create a new branch called `feature-1`
3. Switch to `feature-1`
4. Create a new branch and switch to it in a single command — call it `feature-2`
5. Try using `git switch` to move between branches — how is it different from `git checkout`?
6. Make a commit on `feature-1` that does **not** exist on `main`
7. Switch back to `main` — verify that the commit from `feature-1` is not there
8. Delete a branch you no longer need
9. Add all branching commands to your `git-commands.md`

---

### Task 3: Push to GitHub
1. Create a **new repository** on GitHub (do NOT initialize it with a README)
2. Connect your local `devops-git-practice` repo to the GitHub remote
3. Push your `main` branch to GitHub
4. Push `feature-1` branch to GitHub
5. Verify both branches are visible on GitHub
6. Answer in your notes: What is the difference between `origin` and `upstream`?

---

### Task 4: Pull from GitHub
1. Make a change to a file **directly on GitHub** (use the GitHub editor)
2. Pull that change to your local repo
3. Answer in your notes: What is the difference between `git fetch` and `git pull`?

---

### Task 5: Clone vs Fork
1. **Clone** any public repository from GitHub to your local machine
2. **Fork** the same repository on GitHub, then clone your fork
3. Answer in your notes:
   - What is the difference between clone and fork?
   - When would you clone vs fork?
   - After forking, how do you keep your fork in sync with the original repo?

---
