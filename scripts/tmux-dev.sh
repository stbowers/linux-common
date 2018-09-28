#!/bin/bash

# Assumes already in an instance of tmux, opens three windows
# one with ranger, one with nvim (set up with a socket file for remote control)
# and one with a regular terminal.

tmuxsessionid="$(tmux display-message -p '#{client_session}')"
tmuxwindowid="$(tmux display-message -p '#{window_id}')"
servername="tmuxEditor.$tmuxsessionid.$tmuxwindowid"
nvimsocket="/tmp/$servername.sock"
rangerconfigcmd="set column_ratios 1;set preview_directories false;set preview_files false;set preview_images false;set collapse_preview true;set mouse_enabled false;set padding_right false;set viewmode multipane;set vcs_aware true;set vcs_backend_git enabled"
rangercmd="export TERM=rxvt-unicode-256color; ranger --cmd='chain $rangerconfigcmd'"
tmux send-keys "$rangercmd" Enter
tmux split-window -v 
tmux select-pane -t 1
tmux split-window -h 
vimcmd="$(echo 'export TERM=rxvt-unicode-256color; open_nvim .')"
tmux send-keys "$vimcmd" Enter
# 1 - ranger
# 2 - vim
# 3 - terminal
