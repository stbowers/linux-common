#!/bin/sh

# Install programs
printf "Checking for aur helper... "
if [[ -e /usr/bin/yay ]]; then
	AUR_HELPER="yay -Syu"
	printf "Found (/usr/bin/yay)\n"
else
	printf "Not found. Please install yay.\n"
	exit
fi

echo "Installing tools..."
PACMAN_PACKAGES="i3-gaps i3blocks dunst vim neovim python-neovim tmux"
AUR_PACKAGES="compton-tryone-git"
sudo pacman -Syu --needed $PACMAN_PACKAGES
yay -Syu --needed $AUR_PACKAGES

# Set up scripts
git clone https://github.com/stbowers/linux-scripts ~/.local/scripts

# ---------- Set up xorg configuration ----------
echo "Configuring Xorg..."

# Move existing .Xresources to ~/.local/etc if it exists
mkdir -p ~/.local/etc
if [ -e ~/.Xresources ]; then
	mv ~/.Xresources ~/.local/etc
else
	touch ~/.local/etc/.Xresources
fi

# Create new .Xresources file that includes the local settings and common settings
echo "#include \"$HOME/configuration/xorg/.Xresources\"" > ~/.Xresources
echo "#include \"$HOME/.local/etc/.Xresources\"" >> ~/.Xresources

# Replace .xinitrc (if it exists) with a link to the new xinitrc
[[ -e ~/.xinitrc ]] && rm -f ~/.xinitrc
ln -s ~/configuration/xorg/.xinitrc ~/.xinitrc

# ---------- Set up i3 configuration ----------
echo "Configuring i3..."
[[ -e ~/.config/i3 ]] && rm -rf ~/.config/i3
ln -s ~/configuration/i3 ~/.config/i3

echo "Configuring compton..."
[[ -e ~/.config/compton ]] && rm -rf ~/.config/compton
ln -s ~/configuration/compton ~/.config/compton

echo "Configuring dunst..."
[[ -e ~/.config/dunst ]] && rm -rf ~/.config/dunst
ln -s ~/configuration/dunst ~/.config/dunst

# ---------- Set up zsh configuration ----------
echo "Configuring zsh..."

# If a local .zshrc file exists, move it to ~/.local/etc/.zshrc (or create it if not)
if [ -e ~/.zshrc ]; then
	mv ~/.zshrc ~/.local/etc
else
	touch ~/.local/etc/.zshrc
fi

echo "source ~/configuration/zsh/.zshrc" > ~/.zshrc
echo "source ~/.local/etc/.zshrc" >> ~/.zshrc

# ---------- Set up vim configuration ----------
echo "Configuring vim..."
[[ -e ~/.vimrc ]] && rm -rf ~/.vimrc
ln -s ~/configuration/vim/.vimrc ~/.vimrc

echo "Configuring nvim..."
[[ -e ~/.config/nvim ]] && rm -rf ~/.config/nvim
ln -s ~/configuration/nvim ~/.config/nvim

# ---------- Set up tmux configuration ----------
echo "Configuring tmux..."
[[ -e ~/.tmux.conf ]] && rm -rf ~/.tmux.conf
ln -s ~/configuration/tmux/.tmux.conf ~/.tmux.conf

# Set up tmux
