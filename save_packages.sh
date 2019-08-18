#!/bin/sh

# Creates lists of packages installed on the current system:
# ./pkglist.txt : List of explicitly installed packages that are not dependencies of any other package or foreign (from the AUR)
# ./pkglist_foreign.txt : List of foreign packages (i.e. AUR packages)

# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#List_of_installed_packages
pacman -Qqetn > pkglist.txt
pacman -Qqem > pglist_foreign.txt
