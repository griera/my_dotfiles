#!/bin/bash

# Disables PC speaker beep
xset -b

# Toggle to switch between us and es keyboard layout using Ctrl+Alt
setxkbmap -option 'grp:switch,grp:ctrl_alt_toggle' us,es

# Switch Caps Lock with Esc
setxkbmap -option 'caps:swapescape'

# Starts i3-wm
exec i3
