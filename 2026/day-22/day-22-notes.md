# Day 22 – Introduction to Git: Your First Repository

**Date**: March 19, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-22)

## Task Overview

Today marks the beginning of your Git journey. Git is the backbone of modern DevOps — every tool, pipeline, and workflow revolves around version control. Before diving into advanced concepts, you need to get comfortable with the basics by doing.

---

## Challenge Tasks

### Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration


<img width="877" height="201" alt="task 1 output" src="https://github.com/user-attachments/assets/3d262480-5482-49b5-ba17-cff02fdcb36b" /><br/>


---

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside


<img width="822" height="608" alt="task 2 output" src="https://github.com/user-attachments/assets/963a893c-f9cd-4ad4-8237-23e460b21338" /><br/>


---

### Task 3: Create Your Git Commands Reference
1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
3. For each command, write:
   - What it does (1 line)
   - An example of how to use it
  
### [git-commands.md](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-20/script/log_analyzer.sh](https://github.com/akashahir50/90DaysOfDevOps/blob/master/2026/day-22/git-commands.md)

---

### Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history


<img width="1030" height="610" alt="task 4 output" src="https://github.com/user-attachments/assets/e020e29c-1e62-4edd-a043-be5b12266e6c" /><br/>


---

### Task 5: Make More Changes and Build History
1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format


<img width="881" height="622" alt="task 5 output" src="https://github.com/user-attachments/assets/36e2ae34-96f3-4e0e-a3fd-44c176427e4b" /><br/>

---

### Task 6: Understand the Git Workflow

1. What is the difference between `git add` and `git commit`?
  * git add- its use to add untracked file to staged
  * git commit- commits those staged file into a repo with a meaningful message


2. What does the **staging area** do? Why doesn't Git just commit directly?

      ANSWER: The staging area lets you prepare exactly what you want to commit It gives you control so you can commit only part of your changes and avoid unnecessary files /changes.

3. What information does `git log` show you?
`git log`- it shows the commit history

4. What is the `.git/` folder and what happens if you delete it?
`.git/`- its store all the git data including commit history, configuration, Bracnches and etc. If we delete .git folder then this all data will be deleted and that directory is no longer git repository. 

5. What is the difference between a **working directory**, **staging area**, and **repository**?
`Working directory`: your actual files on disk that you edit.
`where you prepare`: changes before committing.
`Repository`: where Git stores .

---
