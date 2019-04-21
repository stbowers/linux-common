#!/bin/sh

__powerline_prompt() {
    
    # Sets the foreground color while printing some text
    # usage: with_fg color text
    # example: with_fg red "Hello, World!"
    with_fg() {
        echo "%{%F{$1}%}$2%{%f%}"
    }

    # Sets the background color while printing some text
    # usage: with_bg color text
    # example: with_bg red "Hello, World!"
    with_bg() {
        echo "%{%K{$1}%}$2%{%k%}"
    }

    # Choses which text to use based on a condition
    # example: with_condition ! admin user
    with_condition() {
        echo "%($1.$2.$3)"
    }

    # Powerline symbols
    PL_RA=$(printf "\ue0b0")
    PL_GIT=$(printf "\ue0a0")

    # Prompt
    # Return code - white on black
    RETURN_CODE="%?"
    echo -n "$(with_fg white "$(with_bg black "$RETURN_CODE")")"
    # Time - white on magenta
    TIME="$PL_RA$(with_fg white "%D{%L:%M}")"
    echo -n "$(with_bg magenta "$(with_fg black "$TIME")")"
    # User@Host - if root: black on red, if user: black on cyan
    USER="$PL_RA$(with_fg black "%n@%m")"
    echo -n "$(with_fg magenta "$(with_condition ! "$(with_bg red "$USER")" "$(with_bg cyan "$USER")")")"
    # Git branch - black on yellow
    echo -n "$(with_bg yellow "$(with_condition ! "$(with_fg red "$PL_RA")" "$(with_fg cyan "$PL_RA")")")"
    echo -n "$(with_bg yellow "$(with_fg black "${PL_GIT}$(echo '${vcs_info_msg_0_}')")")"
    # Path - black on magenta
    echo -n "$(with_bg green "$(with_fg yellow $PL_RA)$(with_fg black "%~")")"
    # End
    echo -n "$(with_fg green $PL_RA)"
}

autoload -U colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%b"
precmd() {
    vcs_info
}
setopt prompt_subst
export PROMPT="$(__powerline_prompt) "
unset __powerline_prompt
