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



<img width="1163" height="575" alt="task 2 a" src="https://github.com/user-attachments/assets/5aaff0fe-95f1-46c5-a318-d11a0cdcab1d" /><br/>


<img width="752" height="197" alt="task 2 b" src="https://github.com/user-attachments/assets/29a0317b-58f1-4547-8dff-24015da680ba" />



---

### Task 3: Push to GitHub
1. Create a **new repository** on GitHub (do NOT initialize it with a README)
2. Connect your local `devops-git-practice` repo to the GitHub remote
3. Push your `main` branch to GitHub
4. Push `feature-1` branch to GitHub
5. Verify both branches are visible on GitHub
6. Answer in your notes: What is the difference between `origin` and `upstream`?

	`origin`-The default name Git assigns to the repository you cloned from<br/>
   `upstream`-A conventional name for the original repository from which the project was forked. You usually do not have push access to this repository.<br/>

<img width="897" height="571" alt="task 3" src="https://github.com/user-attachments/assets/4a35b4ed-5a71-444b-a85a-f5597ee9fcab" /><br/>


<img width="917" height="300" alt="task 3 b" src="https://github.com/user-attachments/assets/8c4d3d09-8d8d-4bac-83a0-019aaa2a7c31" />



---

### Task 4: Pull from GitHub
1. Make a change to a file **directly on GitHub** (use the GitHub editor)
2. Pull that change to your local repo
3. Answer in your notes: What is the difference between `git fetch` and `git pull`?<br/>

      `git fetch`-downloads changes from the remote repository but does not apply them to your local working branch, offering a safe way to review updates.<br/>
      
      `git pull`- download the changes and also simultaneously merged them into branch<br/>

<img width="818" height="498" alt="task 4 a" src="https://github.com/user-attachments/assets/34dc6ae6-ffdf-4eeb-94da-d23adcbd8b94" />


---

### Task 5: Clone vs Fork
1. **Clone** any public repository from GitHub to your local machine<br/>
2. **Fork** the same repository on GitHub, then clone your fork<br/>
3. Answer in your notes:<br/>
   - What is the difference between clone and fork?
      `clone`- copiying remote repository to our local machine<br/>
      `fork`-copiying others public repository into our github account<br/>
   - When would you clone vs fork?<br/>
       `clone`- When you want to use/contribute to a repo you have access to<br/>
       `fork`- When contributing to someone else's repo <br/>
   - After forking, how do you keep your fork in sync with the original repo?<br/>
     ANSWER: There is a option on github available in repository to synk fork.<br/>
  
<img width="1022" height="296" alt="task 5" src="https://github.com/user-attachments/assets/488fe121-43b9-4e95-9f58-3dba6cf6025c" /><br/>


<img width="996" height="158" alt="task 5b" src="https://github.com/user-attachments/assets/d1a74f0b-be25-41b6-b629-737ca22e5c61" />



---
