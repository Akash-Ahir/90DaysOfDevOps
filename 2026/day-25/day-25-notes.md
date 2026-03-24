# Day 25 – Git Reset vs Revert & Branching Strategies
**Date**: March 22, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-25)

## Task Overview

---

## Challenge Tasks

### Task 1: Git Reset — Hands-On
### 1. Make 3 commits in your practice repo (commit A, B, C)
### 2. Use `git reset --soft` to go back one commit — what happens to the changes?<br/>

<img width="802" height="256" alt="task 1 a " src="https://github.com/user-attachments/assets/b5d36f6b-a1b9-40ab-be38-fa416204e284" /><br/>

### 3. Re-commit, then use `git reset --mixed` to go back one commit — what happens now?

<img width="868" height="443" alt="task 1 b" src="https://github.com/user-attachments/assets/1c079e8e-e275-46e3-a9b4-1a1722efe258" /><br/>

### 4. Re-commit, then use `git reset --hard` to go back one commit — what happens this time?

<img width="833" height="295" alt="task 1 c" src="https://github.com/user-attachments/assets/26659846-517e-40ef-911a-145cb58bd7b4" /><br/>



### 5. Answer in your notes:<br/><br/>
   - What is the difference between `--soft`, `--mixed`, and `--hard`?<br/>
     `--soft` keeps changes staged<br/>
     `--mixed` unstages changes but keeps them<br/>
     `--hard` destroys changes, reverting all files to a previous commit<br/>


   - Which one is destructive and why?<br/>
      `--hard` Because destroys changes, reverting all files to a previous commit<br/>

   - When would you use each one?<br/>
         `--soft` - whenever you want to reset commit but keep changes staged<br/>
         `--mixed` - whenever we want  to unstaged changes but also need to keep it<br/>
         `--hard` - it is used when we want to reset the commit anlso the changes<br/>

   - Should you ever use `git reset` on commits that are already pushed?<br/>
      NO<br/>
---

## Task 2: Git Revert — Hands-On
### 1. Make 3 commits (commit X, Y, Z)
### 2. Revert commit Y (the middle one) — what happens?
### 3. Check `git log` — is commit Y still in the history?


<img width="762" height="323" alt="task 2" src="https://github.com/user-attachments/assets/72cee547-4dd3-4b84-9f1b-ae372a63c6e6" /><br/>



### 4. Answer in your notes:
   - How is `git revert` different from `git reset`?<br/>
      `git revert` -  revert act as an undo for a commit <br/>
      `git reset` -   reset is used to wiped out the commit history and changes<br/>
     
   - Why is revert considered **safer** than reset for shared branches?<br/>
      Because revert only undo commit it will not delet the changes with the commit. <br/>

   - When would you use revert vs reset?<br/>
         `revert` -when you want to undo a commit <br/>
        ` reset`  - when you want to wipedout the commit with their changes<br/>

---

## Task 3: Reset vs Revert — Summary
Create a comparison in your notes:

| | `git reset` | `git revert` |
|---|---|---|
| What it does | Moves branch pointer to a previous commit | Creates a new commit that undoes a previous commit |
| Removes commit from history? | Yes | NO |
| Safe for shared/pushed branches? | NO | Yes |
| When to use | When you want to remove the changes commit | When you want to undo changes and remove changes |




---

## Task 4: Branching Strategies
Research the following branching strategies and document each in your notes with:
- How it works (short description)
- A simple diagram or flow (text-based is fine)
- When/where it's used
- Pros and cons

### 1. **GitFlow** — develop, feature, release, hotfix branches<br/>
   `develop` - The develop branch is for new feature and bug fix its contain the pre production code.<br/>
   `feature` - It's Branches off develop to introduce new features after completion merges back into develop.<br/>
   `release` - Created from develop when preparing for a production deployment. It allows final QA, bug fixes, and documentation, then merges into both main and develop.<br/>
   `hotfix branches` - Created directly from main to immediately fix critical production issues.<br/>
   <img width="786" height="520" alt="image" src="https://github.com/user-attachments/assets/b34d13e3-1fe8-472f-87e5-110111d1e7a1" /><br/>



### Pros - structure is cleared and safe for deployment<br/>
### cons - Due to too many branches it is complex to manage<br/>
### When/where it's used - used for lar corporates teams with large project<br/>
   
### 3. **GitHub Flow** — simple, single main branch + feature branches<br/>
   `single main branch` - A main branch containing only production-ready code that is immediately deployable.<br/>
   `feature branches` -  - Developers create new branches directly from main to work on specific features, fixes, or experiments, isolating work to prevent breaking production. <br/>
    <img width="729" height="547" alt="image" src="https://github.com/user-attachments/assets/f8e6dede-ee1a-4585-8265-9381d24357f5" /><br/>



 ### Pros - Simple and easy to follow and has Fast development<br/>
  ### cons - Not ideal for complex versioning<br/>
  ### When/where it's used - Web apps, startups, continuous deployment environments.<br/>
   
### 5.  **Trunk-Based Development** — everyone commits to main, short-lived branches<br/>
   `main` - A main branch containing only production-ready code<br/>
   `short-lived branches` - Branches are created for specific, small tasks, merged back to the main branch within a few hours or days, and then deleted.<br/>

   <img width="869" height="512" alt="image" src="https://github.com/user-attachments/assets/8bde0cc4-a3d6-4971-a8c7-4040511cdae2" /><br/>



  ### Pros -has very fast integration fewer merge conflicts<br/>
  ### cons - Risky without good practices<br/>
  ### When/where it's used - High-performance teams, DevOps environments.<br/>
   
### 7.  Answer:
   - Which strategy would you use for a startup shipping fast? = GitHub Flow or Trunk-Based Development<br/>
   - Which strategy would you use for a large team with scheduled releases? = GitFlow<br/>
   - Which one does your favorite open-source project use? = GitHub Flow<br/>
   
---

## Task 5: Git Commands Reference Update
### [git-commmands.md](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-22/git-commands.md)
