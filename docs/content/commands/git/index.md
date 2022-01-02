---
man_name: numonic-git
man_section: 7
---

# NAME

numonic-git - a collection of extensions for the git cli that make it easier to work with forks and pull requests

# SYNOPSIS

numonic-git

# DESCRIPTION

Numonic includes a large collection of extensions to the git cli that make operating with forks and pull requests even
easier. These extensions are available via the git cli itself and can be aliased for even shorter names, if you so
choose. They are also tied into the git help system. For example, `man git-fork-clone` or `git fork-clone --help` will
both pull up the manual for the `fork-clone` extension.

# AVAILABLE COMMANDS

## WORKFLOW

* [**git-fork-clone**(1)](git-fork-clone)
* [**git-start**(1)](git-start)
* [**git-pull-request**(1)](git-pull-request)
* [**git-done**(1)](git-done)
* [**git-fork-done**(1)](git-fork-done)

## COMMIT AND IDEATE

* [**git-commit-all**(1)](git-start)
* [**git-commit-amend**(1)](git-commit-amend)
* [**git-commit-mark**(1)](git-commit-mark)
* [**git-commit-restore**(1)](git-commit-restore)
* [**git-commit-save**(1)](git-commit-save)
* [**git-commit-undo**(1)](git-commit-undo)
* [**git-commit-wip**(1)](git-commit-wip)
* [**git-reset-head**(1)](git-reset-head)

## STAYING IN SYNC

* [**git-delete-gone**(1)](git-delete-gone)
* [**git-delete-merged**(1)](git-delete-merged)
* [**git-done**(1)](git-done)
* [**git-remote-prune**(1)](git-remote-prune)
* [**git-update**(1)](git-update)

## CONFIGURATION

* [**git-edit-config**(1)](git-edit-config)

# ALIASES

The above commands are built as extensions to the git cli and participate with the help system based on manual pages.
They are intentionally long and descriptive to avoid clobbering existing aliases and are intended to (hopefully) avoid
any collisions with any future updates to the git command structure itself.

If you would like to enable short-form aliases for these commands, you can do so as follows (for example):

```sh
git config --global alias.cm='commit-all'
git config --global alias.fd='fork-done'
```

Alternatively, you can edit the configuration in an editor and add aliases:

```sh
git edit-config
# OR
git config --global --edit
```

The following is an example set of aliases that may be useful:

```toml
[alias]
  ec = 'edit-config'
  fc = 'fork-clone'
  cob = 'start'
  pr = 'pull-request'
  fd = 'fork-done'
```

# GETTING HELP

All git command extensions are available as manual pages, which can be retrieved the same way as any other git command.
For instance:

```sh
man git-pull-request
# OR
git pull-request --help
```

Tab completion is available for the commands themselves but not for command arguments. This is an area where we hope to
improve over time.

# EXAMPLES

## STANDARD WORKFLOW WHEN USING FORKS

```sh
# create a directory with the name of the upstream git organization
mkdir -p ~/Repos/automotivemastermind
cd ~/Repos/automotivemastermind

# clone your fork of the upstream repository
# this will clone the fork as the origin and also configure the upstream remote based on the name of the current
# directory (automotivemastermind)
git fork-clone https://github.com/dmccaffery/numonic
cd numonic

# create a feature/fix branch
# this will create the branch locally, switch to that branch, and immediately push a copy to the origin (your fork)
git start feat/some-feature

# after making changes, you can commit as usual as often as you like
git commit

# setup for a pull request
# this will fetch the latest from the upstream default branch and rebase your commits including sign-off this ensures
# that any merge conflicts can be resolved locally before opening the pull request and also ensures that all commits are
# signed
git pull-request

# move to the default branch and merge (--fast-forward) the upstream to the origin so you can start working on the next
# feature or fix -- any branches that have been successfully merged into the upstream will be removed from both the
# local copy and the origin and any branches that no longer exist on the origin will also be removed locally -- this
# keeps the fork in perfect sync with the upstream (except for those branches where pull requests are still pending)
git done
```

# SEE ALSO

[**git-fork-clone**(1)](git-fork-clone),
[**git-start**(1)](git-start),
[**git-pull-request**(1)](git-pull-request),
[**git-fork-done**(1)](git-fork-done),
[**git-commit-all**(1)](git-start),
[**git-commit-amend**(1)](git-commit-amend),
[**git-commit-mark**(1)](git-commit-mark),
[**git-commit-restore**(1)](git-commit-restore),
[**git-commit-save**(1)](git-commit-save),
[**git-commit-undo**(1)](git-commit-undo),
[**git-commit-wip**(1)](git-commit-wip),
[**git-reset-head**(1)](git-reset-head),
[**git-delete-gone**(1)](git-delete-gone),
[**git-delete-merged**(1)](git-delete-merged),
[**git-remote-prune**(1)](git-remote-prune),
[**git-done**(1)](git-done),
[**git-update**(1)](git-update),
[**git-edit-config**(1)](git-edit-config)
