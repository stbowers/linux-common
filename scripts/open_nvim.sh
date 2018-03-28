#!/bin/bash

# vars hold flags passed to script and files passed to script
nvrflags=""
files=""

# Loop arguments
while (( "$#" ))
do
    # if args starts with -, add it as a flag to nvr
    if [[ $1 == -* ]]
    then
        # add the argument if it's not --
        # some programs call EDITOR as ${EDITOR} -- file
        # I don't know why, there's probably a reason, but this
        # script can't handle that syntax, so remove the --
        if [[ ! $1 == -- ]]
        then
            nvrflags="$nvrflags $1"
        fi
    else
        # If arg doesn't start with -, assume a file
        # If file exists, add it to the file list
        if [[ -e $1 ]]
        then
            files="$files $1"
        else
            echo "File not found: $1"
        fi
    fi
    
    # Shift args over, next arg is now $1
    shift
done

# if $TMUX is a set variable, we are in a tmux session
if [[ -v TMUX ]]
then
    # In TMUX session, look for an open editor for this window
    tmuxsessionid="$(tmux display-message -p '#{client_session}')"
    tmuxwindowid="$(tmux display-message -p '#{window_id}')"
    servername="tmuxEditor.$tmuxsessionid.$tmuxwindowid"
    nvimsocket="/tmp/$servername.sock"
    if [[ -S $nvimsocket ]]
    then
        # A socket exists for an instance of nvim for this tmux window
        # open the files in a new tab of that instance
        if [[ -z $nvrflags ]]
        then
            # If no flags were specified, open the files in a new tab
            # Or if no files were given, just open a new tab
            NVIM_LISTEN_ADDRESS=$nvimsocket nvr --remote-send "<esc>:tabnew | args $files | vertical all<enter>"
        else
            # If flags were specified, open the files with the flags
            NVIM_LISTEN_ADDRESS=$nvimsocket nvr $nvrflags $files
        fi
    else
        # tmux is open, but no open nvim instance was found for this tmux window
        # open nvr with $nvimsocket so that future calls will find this instance of nvim to use
        # open files with v splits or using nvrflags
        if [[ -z $nvrflags ]]
        then
            # If no flags were specified, open in v splits
            # Or if also no files were specified, just open nvim
            if [[ -z $files ]]
            then
                nvr --servername $nvimsocket -s
            else
                nvr --servername $nvimsocket -s -O $files
            fi
        else
            # if flags were specified, use them
            nvr --servername $nvimsocket -s $nvrflags $files
        fi
    fi
else
    # Not in tmux session, open files with v splits
    # open nvr with a random server name, so that it doesn't conflict with any open nvim instances
    # open files with v splits or using nvrflags
    if [[ -z $nvrflags ]]
    then
        # If no flags were specified, open in v splits
        # or if also no files were specified, just open nvim
        if [[ -z $files ]]
        then
            nvr --servername "/tmp/nvr.$RANDOM" -s
        else
            nvr --servername "/tmp/nvr.$RANDOM" -s -O $files
        fi
    else
        # if flags were specified, use them
        nvr --servername "/tmp/nvr.$RANDOM" -s $nvrflags $files
    fi
fi
