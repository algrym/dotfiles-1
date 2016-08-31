if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# When running 'startx' the current directory is inherited by the X-session and
# therefore each opened terminal emulator will start in said directory.
cd ~

xmodmap ~/.Xmodmap
exec ssh-agent i3 > /tmp/i3-log 2>&1
