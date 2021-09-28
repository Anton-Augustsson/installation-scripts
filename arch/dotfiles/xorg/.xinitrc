#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard Layout
setxkbmap se &

# Compositor
picom -f &

# Statusbar
#/home/$USER/dwm-bar/dwm_bar.sh &
/home/$USER/.config/dwm_bar/dwm_bar.sh &

# Wallpaper
xwallpaper --zoom ~/.config/wallpaper.$(ls ~/.config | grep "wallpaper" | sed 's/wallpaper.//') 

# Keyboard shortcuts sxhkd
pgrep sxhkd || sxhkd &

# Start emacs server
#emacs --daemon &

# keymaps
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap 
xmodmap -e 'clear lock'

# Start dwm
exec dwm
