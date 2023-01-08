#!/usr/bin/env sh
# https://github.com/shvedes/dotfiles

# main applications
pgerp -x easyeffects   2> /dev/null || easyeffects  --gapplication-service &
# pgerp -x redshift      2> /dev/null || redshift     -P -O 4500 & 
pgrep -x polybar       2> /dev/null || $HOME/.local/bin/bspwm/launch_poly.sh &
#pgerp -x polybar       2> /dev/null || polybar      -q -r -c $HOME/.config/polybar/main.ini &
pgerp -x dunst         2> /dev/null || dunst        &
pgerp -x sxhkd         2> /dev/null || sxhkd        &
pgrep -x greenclip     2> /dev/null || greenclip daemon &
pgrep -x picom         2> /dev/null || picom --experimental-backends &
pgrep -x btm           2> /dev/null || /bin/alacritty -t BTM -e  btm &
pgerp -x tty-clock     2> /dev/null ||/bin/alacritty -t clock  -e tty-clock -s -c -C 5 &

xrandr                --output eDP --mode 1920x1200
feh                   --bg-fill ~/.wallpapers/29.png & 
# brightnessctl         -q s 4
redshift              -P -O 4500 &
betterlockscreen      -q -u  ~/.wallpapers/29.png
xsetroot              -cursor_name left_ptr &

# start autolock session script
$HOME/.local/bin/scripts/autolock &


