---
title: code-wait
---

# NAME

code-wait - enables Visual Studio Code to be used as an editor with support for waiting for the editor to be closed
before proceeding.

# SYNOPSIS

**code-wait** [<*args...*>]

# DESCRIPTION

This command is an internal tool used to enable using Visual Studio code as a command line editor. When the `code`
executable is available on the command line, numonic will configure the `EDITOR` environment variable to use this
command. The `EDITOR` environment variable is only set if it is not already set by the user.

If `code` is not available when this command is invoked, then `vi` will be used as the editor.

# OPTIONS

## ARGUMENTS

### \<args\>

the arguments to pass to the editor, such as the path of the file to open
all arguments

# EXAMPLES

## code-wait ~/.gitconfig

opens Visual Studio Code as the editor for the file *~/.gitconfig* and waits for the editor window to be closed before
proceeding

# SEE ALSO

**editor**(1)
