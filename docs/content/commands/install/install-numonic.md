---
title: install-numonic
---

# NAME

install-numonic - installs numonic for the current operating system

# SYNOPSIS

**install-numonic** <*shell*> [**-d** | **--debug** ] [**-h** | **--help**] [**-nd** | **--no-dependencies**]
[**-q** | **--quiet**]

**install-numonic** **-s** <*shell*> [**-d** | **--debug** ] [**-h** | **--help**] [**-nd** | **--no-dependencies**]
[**-q** | **--quiet**]

**install-numonic** **--shell=**<*shell*> [**-d** | **--debug** ] [**-h** | **--help**]
[**-nd** | **--no-dependencies**] [**-q** | **--quiet**]

# DESCRIPTION

This command is only available when cloning the repository or using **numonic-bootstrap**(1) to acquire a version of the
numonic repository. It is responsible for detecting the platform in use and performing a complete installation of
numonic.

## WHAT HAPPENS

Numonic will install the prerequisites above (unless the `--no-dependencies` flag was set). It will then extract shell
scripts and supporting files (such as themes) to `$HOME/.local/numonic`. Finally, it will create or replace the
following files in the `$HOME` directory:

* .pam_environment
* .profile
* .bash_profile
* .bashrc
* .zprofile
* .zshrc

If you have existing customizations within these startup environment files, they will need to be re-added to the
user bashrc and/or zshrc that numonic loads after it is initialized. This may seem invasive (and it is), but experience
has taught us that the vast majority of bugs we experience is correlated to changes that developers
(or other installers) make to these files with no regard for order. In numonic, any user customizations will always be
loaded *AFTER* numonic is fully initialized. This ensures that these customizations always take precedence. It also
will survive upgrades to numonic.

Use the **edit-bashrc**(1) and **edit-zshrc**(1) commands to add these customizations.

We do [create a backup](https://numonic.sh/commands/backup) of these files every time that numonic is installed or
upgraded. One can also uninstall numonic and restore their environment back to the way it was before numonic was even
introduced via an **uninstall-numonic**(1) command.

## PREREQUISITES

The latest available versions of the following prerequisites will be installed for your distribution by default. If you
wish to skip automatic installation, such as on systems where sudo permissions are not available, you can pass the
**--no-dependencies** flag to the bootstrap / installer. Note that doing this will require suitable versions of these
prerequisites exist. The existence of the dependencies is verified but not versions. This is done to ensure the greatest
compatibility possible within a wide range of secure environments, such as virtual desktops without internet access.

The install (install-aws, install-gcloud, install-azure, etc) scripts may have their own dependencies and will require
internet access. Please consult the [install](https://numonic.sh/commands/install) documentation for more information.

### REQUIRED PREREQUISITES

The following prerequisites are required (and verified) for installation to succeed.

* curl
* find (findutils)
* grep
* jq >= 1.4
* man (man-db)
* unzip
* a [nerd font](https://www.nerdfonts.com) for your terminal program of choice *OR* use our
  [theme](https://numonic.sh/commands/theme)

### OPTIONAL PREREQUISITES

The following optional prerequisites are required for all features, namely external multi-factor authentication (MFA)
devices and git-* commands. These commands are not verified if **--no-dependencies** is set during installation.

* git >= 2.0
* gpg >= 2.0

## OPERATING SYSTEMS

While numonic *should* run on macOS High Sierra or greater and all Linux distributions with either apt, dnf, or yum, we
only validate against a few of the more recent versions of popular ones.

| Name    | Version                             |
| ------- | ----------------------------------- |
| macOS   | 10.15 (Catalina) and 11.0 (Big Sur) |
| windows | 10 and 11 (WSL 2)                   |
| ubuntu  | 20.04 (Focal) and 20.10 (Impish)    |
| fedora  | 34 and 35                           |
| debian  | 10 (Buster) and 11 (Bullseye)       |
| centos  | 8                                   |
| amazon  | Amazon Linux 2                      |

> NOTE: We only test and support distributions that support both amd64 and arm64 (aarch64) as we have many customers
> operating on both. Not all capabilities are tested. If you discover any bugs or wish to add your favorite distro to
> the validated list, please [create an issue](https://github.com/automotiveMastermind/numonic/issues/new/choose).

# OPTIONS

## ARGUMENTS

## \<shell\>, -s \<shell\> --shell=\<shell\>

the name of the shell to use or install, which must be one of 'sh', 'bash', or 'zsh'

## FLAGS

### -d, --debug

print the commands as they are executed (set -x)

### -h, --help

print this help information

### -nd, --no-dependencies

do not install any required dependencies as part of the installation of numonic
if this is set, then the required dependencies will be verified and the installation will fail if any dependency is
unavailable

### -q, --quiet

suppress any output to stdout (any errors will still be printed)

# SEE ALSO

**update-numonic**(1)
