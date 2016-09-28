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
[ -n "$id" ] && xinput disable "$id"

# I want to use xkb instead of the below. I also want to remap <C-J> -> <Return>
# and <C-I> -> <Tab>. Oh and <C-[> -> <Esc>.
# This should work for all application, while <Control_L> shouldn't be changed
# to another key. 
xmodmap ~/.Xmodmap

exec ssh-agent i3 > /tmp/i3-log 2>&1
