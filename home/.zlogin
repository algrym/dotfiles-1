# vim: fdm=marker fmr={{{,}}} fdl=0
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration. 
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Environment Variables --------------------------------------------------- {{{

export DOTFILES_ROOT="$HOME/work/dotfiles"

# i3-terminal, needs to be at the top before startx is called, otherwide the
#   terminal will not explicit be set to termite
declare -x TERMINAL=termite

# Default Editor
declare -x VISUAL=vim
declare -x EDITOR="$VISUAL"
declare -x SITEMULE_EDITOR="$VISUAL"

# Default Pager
declare -x LESS=' -RSNCi '
declare -x PAGER=less

# Use Vim as man pager
export MANPAGER="/bin/sh -c \"col -b | vim +'set ft=man' -\""

# reddit-wallaper
declare -x REDDIT_WALLPAPER_OUTPUT="$HOME/Pictures/Wallpapers"
declare -x REDDIT_WALLPAPER_CACHE=1
declare -x REDDIT_WALLPAPER_ALWAYS_NEW=1

# Used by clipbored
declare -x CLIPBORED_X_SELECTION='clipboard';

declare -x LC_ALL=en_US.UTF-8
declare -x LANG="$LC_ALL"
declare -x LANGUAGE="$LC_ALL"

declare -x NODE_PATH="/usr/lib/node_modules/"

# The PATH list need to be set before startx is called, this will make
# 'i3' and therefore 'dmenu_run' run with the proper path
path+=(
  "$HOME/.clipbored"
  "$HOME/bin"
  "$HOME/work/zipSeries/bin"
  "$HOME/work/charinfo"
  "$DOTFILES_ROOT/bin"
  "$HOME/work/reddit-wallpaper"
  "$HOME/work/lockscreen"
  "$HOME/work/git-linfo"
  "$HOME/work/git-multi-status"
  "$HOME/.gem/ruby/2.3.0/bin"
)
export PATH

# }}}
# Start X and map keys ---------------------------------------------------- {{{

# Auto start i3wm if tty1 (<Alt-S-F1>)
if [ "$TTY" = "/dev/tty1" ]; then
  startx
fi

# }}}
