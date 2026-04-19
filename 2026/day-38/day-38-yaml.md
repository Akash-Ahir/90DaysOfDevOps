# Day 38 – YAML Basics
**Date**: April 18, 2026  
**Repository**: [90DaysOfDevOps](https://github.com/akashahir50/90DaysOfDevOps/tree/master/2026/day-38)

## Task Overview 
Before writing a single CI/CD pipeline, you need to get comfortable with **YAML** — the language every pipeline is written in.


---

## Challenge Tasks

## Task 1: Key-Value Pairs
Create `person.yaml` that describes yourself with:
- `name`
- `role`
- `experience_years`
- `learning` (a boolean)

**Verify:** Run `cat person.yaml` — does it look clean? No tabs? -Yes

<img width="995" height="692" alt="task 1 1" src="https://github.com/user-attachments/assets/ff5b3f7d-c960-49b8-9a15-311648fa0c20" />


---

## Task 2: Lists
Add to `person.yaml`:
- `tools` — a list of 5 DevOps tools you know or are learning
- `hobbies` — a list using the inline format `[item1, item2]`

Write in your notes: What are the two ways to write a list in YAML?
  1) # Block style
   tools:
    - Docker
    - Kubernetes
    - Linux
    - Terraform
    - Git/Github

  2) # Inline 
   hobbies: [Exploring places, Learning]



<img width="992" height="655" alt="task 2 1" src="https://github.com/user-attachments/assets/01a3f146-8423-4781-8d8f-8a7931c6fbf2" />

---

## Task 3: Nested Objects
Create `server.yaml` that describes a server:
- `server` with nested keys: `name`, `ip`, `port`
- `database` with nested keys: `host`, `name`, `credentials` (nested further: `user`, `password`)


<img width="1086" height="637" alt="task 3 2" src="https://github.com/user-attachments/assets/50a26c55-3251-4376-ba50-9e9d6b43b934" />

<br/>

**Verify:** Try adding a tab instead of spaces — what happens when you validate it? 
  - Gives wrong indentation error <br/>


<img width="1022" height="671" alt="task 3 1" src="https://github.com/user-attachments/assets/d43d410f-2468-4b46-9be7-deb5c5c19307" />


---

## Task 4: Multi-line Strings
In `server.yaml`, add a `startup_script` field using:
1. The `|` block style (preserves newlines)
2. The `>` fold style (folds into one line)

<img width="1012" height="668" alt="task 4 1" src="https://github.com/user-attachments/assets/01c55d00-8085-4e9f-97ef-83636e0d17d4" />


Write in your notes: When would you use `|` vs `>`?
  `|` - Use when formatting matters (scripts, commands, exact output)
  `>` - Use when you want cleaner, wrapped text without line breaks
  
---

## Task 5: Validate Your YAML
1. Install `yamllint` or use an online validator
2. Validate both your YAML files

<img width="626" height="302" alt="task 5 1" src="https://github.com/user-attachments/assets/8973ddaa-4cca-489e-9b98-9d7f3e819621" />


<img width="701" height="447" alt="task 5 2" src="https://github.com/user-attachments/assets/1e13ed4e-0515-432d-b37b-91ee522d8e77" />


3. Intentionally break the indentation — what error do you get?

<img width="1043" height="528" alt="task 5 3" src="https://github.com/user-attachments/assets/6f9fbd55-8499-4e02-a407-347199e16e04" />

4. Fix it and validate again

---

## Task 6: Spot the Difference
Read both blocks and write what's wrong with the second one:

```yaml
# Block 1 - correct
name: devops
tools:
  - docker
  - kubernetes
```

```yaml
# Block 2 - broken
name: devops
tools:
- docker
  - kubernetes
```
The second block has incorrect indentation. - docker is not properly aligned under tools, causing a YAML parsing error.

---


## Documentation
### What I Learned
  - YAML does not support tabs — only spaces
  - Indentation must be consistent (usually 2 spaces per level)
  - Lists can be written in block style or inline style
    

