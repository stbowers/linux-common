# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sean/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Add home bin dir to path
export PATH=$PATH:~/bin:~/.local/bin

# Terminal is urxvt
export TERM=xterm-256color

# Set editor to nvim
export VISUAL="nvim"
export EDITOR="$VISUAL"

# Set prompt
source ~/scripts/powerline-prompt.sh

# Auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# alias commands
alias vim=nvim
alias ls="ls --color=auto"
alias ll="ls -la"
alias l.="ls -d .*"

# SSH agent (gpg)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# If we're on /dev/tty1, start an x session, otherwise start a tmux session
if [ $TTY = "/dev/tty1" ]; then
    startx
else
    # If we're not already in a TMUX session, attach to one.
    # If there are no available TMUX sessions, one will be created
    [[ -z $TMUX ]] && tmux attach
fi
