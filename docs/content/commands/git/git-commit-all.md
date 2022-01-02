---
title: git-commit-all
---

# NAME

git-commit-all - create a commit including all new, removed, or modified files within the working tree

# SYNOPSIS

**git** **commit-all** [**-m** \<message\>] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**]
**git** **commit-all** [**--message=**\<message\>] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**]

# DESCRIPTION

This command updates the index using all content found within the working tree excluding those defined in a
**.gitignore** file. If a tty is available, then the commit will be opened in an editor regardless of whether or not
a message is specified. This is designed to support review, especially since all commit-related numonic commands include
a sign-off.

This command is essentially equivalent to:

```sh
git add --all
git commit --edit --signoff --message=\<message\>
```

# OPTIONS

## FLAGS

### -d, --debug

print the commands as they are executed (set -x)

### -h, --help

print this help information

### -q, --quiet

suppress any output to stdout (any errors will still be printed)

## ARGUMENTS

### -m \<message\>, --message=\<message\>

the message of the commit

# EXAMPLES

## git commit-all

track all files within the repository, excluding those defined in the .gitignore

## git commit-all -d
## git commit-all --debug

track all files within the repository, excluding those defined in the .gitignore and print the underlying git commands
as they are executed

# SEE ALSO

**git-commit**(1), **git-add**(1), **gitignore**(5)
