---
title: container-gc
---

# NAME

container-gc - garbage collects all, containers, volumes, and images that are not currently in use within docker,
nerdctl, and podman

# SYNOPSIS

**container-gc** [<*runtime*> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]

**container-gc** [**-r** <*runtime> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]

**container-gc** [**--runtime=**<*runtime*> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]


# DESCRIPTION

This command will prune all containers and dangling volumes and images for nerdctl, podman, and docker. At least one of
these must be available on the **PATH** or the command will fail. If multiple commands are available on the **PATH**,
then each of them will be pruned.

The command essentially performs the following where \<command\> is `nerdctl`, `podman` or `docker`:

\<command\> container prune --force
\<command\> volume prune --force
\<command\> image prune --force

Any arguments passed after a **--** separator will be passed to the underlying runtimes.

# OPTIONS

## FLAGS

### -d, --debug

print the commands as they are executed (set -x)

### -h, --help

print this help information

### -q, --quiet

suppress any output to stdout (any errors will still be printed)

## ARGUMENTS

### \<runtime\>, -r \<runtime\>, --runtime=\<runtime\>

the name of the runtime to garbage collect
multiple runtimes may be specified
the allowed values are: docker, nerdctl, or podman

###  \<args\>

additional arguments to pass to the underlying runtime cli

These arguments must be specified after a **--** separator at the end of the command.

# EXAMPLES

## container-gc

garbage collect nerdctl, podman, and docker, if available

## container-gc -d
## container-gc --debug

garbage collect nerdctl, podman, and docker, if available, while printing the commands as they are executed

## container-gc docker
## container-gc -r docker
## container-gc --runtime=docker

garbage collect the docker runtime using the current context

## container-gc docker -- --context=docker-root
## container-gc -r docker -- --context=docker-root
## container-gc --runtime=docker -- --context=docker-root

garbage collect the docker runtime using the `docker-root` context (this context is an example context)

# SEE ALSO

[**podman-container-prune**(1)](https://docs.podman.io/en/latest/markdown/podman-container-prune.1.html),
[**sh**(1)](https://man.openbsd.org/sh.1)
