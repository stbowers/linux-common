#!/bin/bash

echo "Please follow the instructions on https://wiki.archlinux.org/index.php/Installation_guide up to and including the step 'Connect to the internet'"

read -r -p "Continue script? [Y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        echo "Installing Arch Linux..."
        ;;
    *)
        echo "Exiting..."
        exit
        ;;
esac
