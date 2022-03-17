#!/bin/bash

os=$(uname)
arq=$(uname -m)
apps_arch="vim"

if [ -e /usr/bin/pacman ]; then
    sudo pacman -Sy
    sudo pacman -S $apps_arch 
fi

