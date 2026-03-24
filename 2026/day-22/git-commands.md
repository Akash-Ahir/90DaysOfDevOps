## Setup & Config

show the install git version
```
git --version
```

sets the global username
```
git config --global user.name "AKASH"
```

sets the global user email
```
git config --global user.email "akashahir50@gmail.com"
```
shows git configuration
```
git config --list
```


## Basic Workflow

initilized a new git repo in current dir
```
git init
```

shows the current branch and status
```
git status
```

make a new commit with the commit message
```
git commit -m "meanning ful messsage"
```

staged all modified file
```
git add git-commands.md
```

show commit history
```
git log

```
display the differences between two versions
```
git diff
```

## Branching 
to list the branches
```
git branch
```
To switch and create a new branch
```
git checkout -b
```

to switch between two branches
```
git switch
```

## Remote

to push changes to remote
```
git push
```
to pull changes from remote
```
pull
```
to fetch changes of remote
```
fetch
```
to clone a repository from remote
```
clone
```
to fork a repository from another repo
```
fork
```


## OTHER

to merge commit to other branch
```
git merge
```
to maintain a linear commit history
```
git rebase
```

undo commit
```
git revert
```
remove commit and changes
```
git reset
```

to save work in progress and fix the hot fix
```
git stash
```
to resume the work in progress
```
git stash pop
```
to pick the specific commit 
```
git cherry-pick
```


