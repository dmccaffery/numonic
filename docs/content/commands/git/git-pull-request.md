---
title: git-pull-request
---

# NAME

git-pull-request - prepares a new commit

# SYNOPSIS

**git** **pull-request** <*branch*> [<*upstream*>] [**-p** [<*origin*>] | [**--push**[**=**<*origin*>]] [**-dr** | **--dry-run**] [**-d** | **--debug**] [**-h** | **--help**] [**-i** | **--interactive**]

**git** **pull-request** **-b** <*branch*> [**-u** <*upstream*>] [**-p** [<*origin*>]] [**-dr** | **--dry-run**] [**-d** | **--debug**] [**-h** | **--help**] [**-i** | **--interactive**]

**git** **pull-request** **--branch=**<*branch*> [**--upstream=**<*upstream*>] [**--push**[**=**<*origin*>]] [**-dr** | **--dry-run**] [**-d** | **--debug**] [**-h** | **--help**] [**-i** | **--interactive**]

# DESCRIPTION

This command creates a new commit on the current HEAD branch and performs a rebase of the specified <*branch*> on the
specified <*remote*>, which should bring the current branch up to date for a linear, fast-forward only pull request.

This command is essentially equivalent to the following:

```sh
git add --all
git commit --edit
git fetch --all
git rebase --autosquash --autostash <remote>/<branch> --empty=drop --signoff
git push
```

If the **--interactive** flag is set, then the rebase will be interactive and the caller will need to push the commits
to the origin once the rebase is complete.

# OPTIONS

## \<branch\>, -b \<branch\>, --branch=\<branch\>

name of the branch used to rebase the current branch from the origin
DEFAULT: develop | next | main | master (the first one that exists)

## \<upstream\>, -u \<upstream\>, --upstream=\<upstream\>

name of the upstream used to rebase the current branch
DEFAULT: upstream | origin (the first one that exists)

## -p, -p \<origin\>, --push, --push=\<origin\>

push the newly created commit to the optionally specified origin
DEFAULT: origin

## -i, --interactive

perform an interactive rebase with the upstream remote

## -dr, --dry-run

print the branch, origin, and start point without creating the actual branch

## -h, --help

print this help information

## -d, --debug

print the commands as they are executed (set -x)

# DEFAULTS

If a branch name is not specified, then **main** will be used. If **main** does not exist on the upstream, a fallback to
**master** will be used. We highly recommend renaming **master** branches in projects to **main** as support for the
fallback will be removed in a future version.

If the **--upstream** remote is not specified, then **upstream** will be used. If **upstream** does not exist as a
remote, then **origin** will be used. This is intended to support contributions made using both forks and feature
branches. We recommend using a feature branch even on forks as the git extensions support updating the origin from the
remote for the main branch.

If the **--push** flag is specified without specifying a remote, then **origin** will be used. By default, this command
will not push the newly minted commit to the origin. The use of the **--push** flag is required to enable this
behavior.

# EXAMPLES

## git pull-request

prepare a pull request commit by rebasing the current head on the upstream remote using the main branch

## git pull-request next

## git pull-request -b next

## git pull-request --branch=next

prepare a pull request commit by rebasing the current HEAD on the upstream remote using the next branch

## git pull-request next shared

## git pull-request -b next -u shared

## git pull-request --branch=next --upstream=shared

prepare a pull request commit by rebasing the current HEAD on the shared remote using the next branch

## git pull-request --push

prepare a pull request commit by rebasing the current head on the upstream remote using the main branch; then push the
commits to the origin remote using the current branch name

## git pull-request -u shared -p shared

## git pull-request --upstream=shared --push=shared

prepare a pull request commit by rebasing the current HEAD on the shared remote using the main branch; then push the
commit to the shared remote using the current branch name

# SEE ALSO

**git-commit-all**(1), **git-push**(1)
