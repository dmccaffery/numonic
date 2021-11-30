---
title: container-update
---

# NAME

container-update - pulls the latest image layer or manifest for each tag that is locally cached within docker, nerdctl,
and podman

# SYNOPSIS

**container-update** [<*runtime*> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]

**container-update** [**-r** <*runtime> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]

**container-update** [**--runtime=**<*runtime*> ...] [**-d** | **--debug**] [**-h** | **--help**] [**-q** | **--quiet**] [**--** \<args\>]

# DESCRIPTION

This command pulls the latest image layer or manifest for each tag that is locally cached within docker, nerdctl, and
podman. At least one of these must be available on the **PATH** or the command will fail. If more than one are on the
**PATH**, then each will be updated. This is primarily useful for images are up to date locally when referencing vanity
tags.

The command essentially performs the following where \<command\> is `docker`, `nerdctl`, or `podman`:

\<command\> images --filter dangling=false --format \\
 '{{.Repository}}:{{Tag}} | xargs -L1 \<command\> pull

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

the name of the runtime for which to update images
multiple runtimes may be specified
the allowed values are: docker, nerdctl, or podman

###  \<args\>

additional arguments to pass to the underlying runtime cli

These arguments must be specified after a **--** separator at the end of the command.

# EXAMPLES

## container-update

pull the latest image layer or manifest for each tag that is locally cached within docker, nerdctl, and podman

## container-update -d
## container-update --debug

pull the latest image layer or manifest for each tag that is locally cached within docker, nerdctl, and podman while
printing the commands as they are executed

## container-update docker
## container-update -r docker
## container-update --runtime=docker

pull the latest image layer or manifest for each tag that is locally cached within docker using the current context

## container-update docker -- --context=docker-root
## container-update -r docker -- --context=docker-root
## container-update --runtime=docker -- --context=docker-root

pull the latest image layer or manifest for each tag that is locally cached within docker using the `docker-root`
context (this context is an example context)

# SEE ALSO

[**podman-images**(1)](https://docs.podman.io/en/latest/markdown/podman-images.1.html),
[**podman-pull**(1)](https://docs.podman.io/en/latest/markdown/podman-pull.1.html)
