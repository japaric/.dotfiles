#!/bin/sh

# Xinit
xinit_directory=/etc/X11/xinit/xinitrc.d
if [ -d $xinit_directory ] ; then
  for file in $xinit_directory/* ; do
    [ -x "$file" ] && . "$file"
  done
fi

# layout
setxkbmap -layout dvorak

# replace caps_lock with esc
setxkbmap -option caps:escape

# Xmodmap
xmodmap_file=$HOME/.Xmodmap
if [ -e $xmodmap_file ]; then
  xmodmap $xmodmap_file
fi

# launch window manager
numlockx on &
PATH="${PATH}:${HOME}/.multirust/toolchains/nightly/cargo/bin" sxhkd &
unclutter &
exec bspwm
