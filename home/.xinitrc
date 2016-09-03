if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# When running 'startx' the current directory is inherited by the X-session and
# therefore each opened terminal emulator will start in said directory.
cd ~

# A naive way to disable the TouchPad
id=$(xinput list | sed -n '/TouchPad/{s/.*=\([[:digit:]]*\).*/\1/p;q}')
[ "$id" -gt 0 ] && xinput disable "$id"

xmodmap ~/.Xmodmap
exec ssh-agent i3 > /tmp/i3-log 2>&1
