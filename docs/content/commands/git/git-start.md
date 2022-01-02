---
title: git-start
---

# NAME

git-start - create a new branch with the specified name and tracks the branch in the remote (origin)

# SYNOPSIS

**git** **start** <*branch*> [<*remote*>] [<*start-point*>] [**-d** | **--debug**] [**-dr** | **--dry-run**] [**-h** | **--help**] [**-q** | **--quiet**]

**git** **start** **-b** <*branch*> [**-r** <*remote*>] [**-sp** <*start-point*>]

**git** **start** **--branch=**<*branch*> [**--remote=**<*remote*>] [**--start-point=**<*start-point*>]

# DESCRIPTION

This command creates a new branch with the specified **branch** name. The newly created branch will then be pushed
to the specified **remote**, which is *origin* by default. A **start-point** can also be supplied that can be used
as the *HEAD* for the newly created branch. If a **start-point** is not supplied, then the *HEAD* of the current
branch will be used instead.

If there are any untracked changes on the current working tree, they will be moved to the new branch.

The command essentially performs the following:

```sh
git pull \<remote\>
git switch --force-create \<branch\>
git push --set-upstream \<remote\> \<branch\>
```

# OPTIONS

## ARGUMENTS

### \<branch\>, -b \<branch\>, --branch=\<branch\>

name of the branch to create

### \<remote\>, -r \<remote\>, --remote=\<remote\>

name of the remote where the resulting branch should be tracked

### \<start-point\>, -sp \<start-point\>, --start-point=\<start-point\>

name of a commit at which to start the new branch; see **git-branch**(1) for details. Defaults to **HEAD**

As a special case, you may use **"A...B"** as a shortcut for the merge base of **A** and **B** if their is exactly
one merge base. You can leave out at most one of **A** and **B**, in which case it defaults to **HEAD**.

## FLAGS

### -d, --debug

print the commands as they are executed (set -x)

### -dr, --dry-run

print the branch, remote, and start point without creating the actual branch

### -h, --help

print this help information

### -q, --quiet

suppress any output to stdout (any errors will still be printed)

# EXAMPLES

## git start feat/something-new
## git start -b feat/something-new
## git start --branch=feat/something-new

create a new branch tracked by the **origin** called **feat/something-new** using the **HEAD** of the current branch

## git start feat/something-new upstream
## git start -b feat/something-new -r upstream
## git start --branch=feat/something-new --remote=upstream

create a new branch tracked by the **upstream** called **feat/something-new** using the **HEAD** of the current branch

## git start feat/something-new upstream HEAD~1
## git start -b feat/something-new -r upstream -sp HEAD~1
## git start --branch=feat/something-new --remote=upstream --start-point=HEAD~1

create a new branch tracked by the **upstream** called **feat/something-new** using the previous commit of **HEAD** of
the current branch

## git start --branch feat/something-new --start-point HEAD~1
## git start --branch=feat/something-new --start-point=HEAD~1

create a new branch tracked by the **origin** called **feat/something-new** using the previous commit of **HEAD** of
the current branch

# SEE ALSO

**git-start-feat**(1), **git-start-fix**(1), **git-checkout**(1), **git-switch**(1), **git-push**(1)
