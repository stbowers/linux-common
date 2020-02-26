# Linux Common Files

This repository contains common files (configuration, scripts, etc) for my Linux installations.

Generally this repository is cloned to ~/common, and configuration files reference that path.

## Setup

1. Clone
```
$ git clone https://www.github.com/stbowers/linux-common ~/common
```
2. Run setup script (See below for details of what this script does)
```
$ ~/common/scripts/setup_common.sh
```

## Setup Script

The setup script (`scripts/setup_common.sh`) does the following:
- Install's packages using pacman (to skip use --no-install)
- Sets up a common directory structure (see below)
- 

The script may need root access to the system (for installing packages and modifying system-wide configuration).
At these times it will use the `sudo` command, which may ask for a password.

## Directory Structure

The configuration files use a fairly standard directory structure, and expect a few directories to be present on the machine:

| Directory      | Description                                                      |
|----------------|------------------------------------------------------------------|
| /usr/local     | "Local" (i.e. machine-dependent) applications, libraries, etc    |
| /usr/local/bin | System-wide machine-dependent binaries, scripts, etc             |
| /etc           | System-wide configuration files                                  |
| ~/             | User's home directory (i.e. `/home/sean/`)                       |
| ~/common       | Common files between installations (this repository)             |
| ~/.local       | User-local files - somewhat mimics the structure of `/usr/local` |
| ~/.local/bin   | User-specific binaries (scripts, downloaded apps, etc)           |
| ~/.config      | User configuration files                                         |

## System-local Files

There are a few configuration files and scripts that are expected to exist but which are not a part of this repository, because they are machine dependent.
These files include:

- /usr/local/bin/default_displays.sh: Sets up the default layout/configuration of screens through xrandr
