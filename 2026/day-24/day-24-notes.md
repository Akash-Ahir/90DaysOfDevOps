# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick
**Date**: March 21, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-24)


## Task Overview
Today I explored advanced Git concepts and how they are used in real workflows. I learned how to combine changes using merge and rebase, manage unfinished work with stash, and apply specific commits using cherry-pick. This helped me understand how to handle code history and work more efficiently in real projects.
---

## Challenge Tasks

## Task 1: Git Merge — Hands-On
1. Create a new branch `feature-login` from `main`, add a couple of commits to it
2. Switch back to `main` and merge `feature-login` into `main`
3. Observe the merge — did Git do a **fast-forward** merge or a **merge commit**?<br/>
   -its a fast-forward<br/>
      <img width="808" height="208" alt="task1 a " src="https://github.com/user-attachments/assets/9e3bb344-b29d-4627-aa35-23224fedb8ef" />

4. Now create another branch `feature-signup`, add commits to it — but also add a commit to `main` before merging
5. Merge `feature-signup` into `main` — what happens this time?<br/>
   -Merge commit<br/>

      <img width="850" height="307" alt="task1 b" src="https://github.com/user-attachments/assets/240fa582-97df-4413-a886-16bba2468be1" />

6. Answer in your notes:
   - What is a fast-forward merge?
      its simple move forward if no changes happen and merge a branch without creating commit   

   - When does Git create a merge commit instead?
      When main has new commits Git creates a special commit with 2 parents to preserve both histories Creates diamond in git log graph  

   - What is a merge conflict? (try creating one intentionally by editing the same line in both branches)
       When same file lines are changed differently in both branches. it give conflict
---

## Task 2: Git Rebase — Hands-On
1. Create a branch `feature-dashboard` from `main`, add 2-3 commits
2. While on `main`, add a new commit (so `main` moves ahead)
3. Switch to `feature-dashboard` and rebase it onto `main`
4. Observe your `git log --oneline --graph --all` — how does the history look compared to a merge?

      <img width="1015" height="380" alt="task2 " src="https://github.com/user-attachments/assets/f1a5b2a2-a851-4cef-9043-f43ede3d9a9c" />

5. Answer in your notes:
   - What does rebase actually do to your commits?
     its takes the commit from one branch and reapplies them on the top of another branch rewritting the commit history.<br/>
     
   - How is the history different from a merge?
     rebase: Creates a clean, linear, simplified history
     merge: Preserves the exact, non-linear history of when branches were combined
     
   - Why should you **never rebase commits that have been pushed and shared** with others?
      Rewrites history/SHAs. Others who pulled your branch get conflicts.  

   - When would you use rebase vs merge?
      rebase-Updating local feature branches with main before merging.
      merge-Integrating public/shared branches feature to main
---

## Task 3: Squash Commit vs Merge Commit
1. Create a branch `feature-profile`, add 4-5 small commits (typo fix, formatting, etc.)
2. Merge it into `main` using `--squash` — what happens?

      <img width="947" height="457" alt="task3 a" src="https://github.com/user-attachments/assets/5bdf85fd-b6a3-4ab2-bd1a-a36fc96fef8d" />

3. Check `git log` — how many commits were added to `main`?
4. Now create another branch `feature-settings`, add a few commits
5. Merge it into `main` **without** `--squash` (regular merge) — compare the history

      <img width="898" height="262" alt="task3 b" src="https://github.com/user-attachments/assets/2d42f77e-408f-410a-9b47-ffc1196fc69b" />

6. Answer in your notes:
   - What does squash merging do?
      it takes multiple commit and combine it into one big commit make commit history clean.  

   - When would you use squash merge vs regular merge?
      if we fix some small error like typo and formatting we sould use squash else regular   

   - What is the trade-off of squashing?
      its removes the detailed commit history and make a single commit tracking is hard  


---

## Task 4: Git Stash — Hands-On
1. Start making changes to a file but **do not commit**
2. Now imagine you need to urgently switch to another branch — try switching. What happens?
3. Use `git stash` to save your work-in-progress
4. Switch to another branch, do some work, switch back
5. Apply your stashed changes using `git stash pop`
6. Try stashing multiple times and list all stashes
7. Try applying a specific stash from the list
8. Answer in your notes:
   - What is the difference between `git stash pop` and `git stash apply`?
      `git stash pop`- Apply + delete from stash list
      `git stash apply`-  Apply but keep in stash list

   - When would you use stash in a real-world workflow?
     if some hotfix which need to be fixed urgently at that time i use it and switch to fix that problem and once it get done i come back and run pop and resume my work
  

      <img width="828" height="302" alt="task4" src="https://github.com/user-attachments/assets/d98b598f-6e66-4f2b-8484-561730efc0c5" />


---

## Task 5: Cherry Picking
1. Create a branch `feature-hotfix`, make 3 commits with different changes
2. Switch to `main`
3. Cherry-pick **only the second commit** from `feature-hotfix` onto `main`
4. Verify with `git log` that only that one commit was applied
5. Answer in your notes:
   - What does cherry-pick do?
     cherry picking is picking of one specific commmit from other branch and copy it to your lets say production branch

     
   - When would you use cherry-pick in a real project?
     when i need to copies a specific commit from one branch to current branch 


   - What can go wrong with cherry-picking?
     it may create a duplicate commit and it may create a conflict


      <img width="966" height="207" alt="task5" src="https://github.com/user-attachments/assets/b81d4182-2527-483e-b9b6-69c1a8192cd4" />

---
