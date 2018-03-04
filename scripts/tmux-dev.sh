#!/bin/bash

tmuxsessionid="$(tmux display-message -p '#{client_session}')"
tmuxwindowid="$(tmux display-message -p '#{window_id}')"
servername="tmuxEditor.$tmuxsessionid.$tmuxwindowid"
rangerconfigcmd1="map ef eval if 'TMUX' in os.environ.keys(): fm.execute_console('shell vim --servername $servername --remote-tab ' + fm.thisfile.basename + '')"
rangerconfigcmd2="set column_ratios 1;set preview_directories false;set preview_files false;set preview_images false;set collapse_preview true;set mouse_enabled false;set padding_right false;set viewmode multipane;set vcs_aware true;set vcs_backend_git enabled"
rangerconfigcmd="chain $rangerconfigcmd1;$rangerconfigcmd2"
rangercmd="$(echo 'export TERM=screen-256color; ranger --cmd="'$rangerconfigcmd'" --cmd="set column_ratios 1"')"
tmux send-keys "$rangercmd" Enter
tmux split-window -v 
tmux select-pane -t 1
tmux split-window -h 
vimcmd="$(echo 'export TERM=screen-256color; vim --servername' $servername)"
tmux send-keys "$vimcmd" Enter
# 1 - ranger
# 2 - vim
# 3 - terminal
