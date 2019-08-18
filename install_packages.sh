#!/bin/sh

PACMAN_PACKAGES=$(cat ~/dotfiles/pacman_packages.txt)
AUR_PACKAGES=$(cat ~/dotfiles/aur_packages.txt)
YAY_DEPS="base-devel git sudo go p7zip"

# Install pacman packages, and dependencies for yay (and upgrade existing packages while we're at it)
echo "Installing official packages..."
sudo pacman -Syu $PACMAN_PACKAGES $YAY_DEPS

# Install yay
echo "Installing yay package manager..."
YAY_TMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/yay.git $YAY_TMP_DIR
cd $YAY_TMP_DIR
makepkg -si
rm -rf $YAY_TMP_DIR

# Install aur packages
echo "Installing AUR packages..."
yay -Syu $AUR_PACKAGES

# Install microsoft fonts
FONTS_TMP_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/ttf-ms-win10.git $FONTS_TMP_DIR
echo "Installing Microsoft fonts..."
echo "Looking for './Win10_English_x64.iso'..."
while [ ! -f "Win10_English_x64.iso" ]; do
    read -n 1 -s -r -p  "The Windows installer iso was not found, please make sure the file './Win10_English_x64.iso' exists and then press any key to continue..."
    echo ""
done
cp ./Win10_English_x64.iso $FONTS_TMP_DIR
cd $FONTS_TMP_DIR
7z e Win10_English_x64.iso sources/install.wim
7z e install.wim 1/Windows/{Fonts/"*".{ttf,ttc},System32/Licenses/neutral/"*"/"*"/license.rtf} -ofonts/
makepkg -si
rm -rf $FONTS_TMP_DIR
