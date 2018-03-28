# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bowers/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add home bin dir to path
export PATH=$PATH:/home/bowers/bin

# Terminal supports 256 colors (for tmux)
export TERM=screen-256color

# Set editor to nvim
export VISUAL="open_nvim"
export EDITOR="$VISUAL"

# Set prompt
autoload -U colors && colors
export PROMPT="%{$fg[white]%}[%(!.%{$fg[red]%}.%{$fg[cyan]%})%n%{$fg[white]%}@%{$fg[green]%}%m%{$fg[white]%}:%~]%(!.%{$fg[red]%}.%{$fg[cyan]%})%(!.!>.>) %{$fg[white]%}"

# alias commands
alias vim=nvim
