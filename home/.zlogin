# vim: fdm=marker fmr={{{,}}} fdl=0
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration.
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Environment Variables {{{

export DOTFILES_ROOT="$HOME/work/dotfiles"

# i3-terminal, needs to be at the top before startx is called, otherwide the
#   terminal will not explicit be set to termite
declare -x TERMINAL=termite

# Default Editor
declare -x VISUAL=vim
declare -x EDITOR="$VISUAL"

# Default Pager
# declare -x LESS=' -RSNCi '
# declare -x PAGER=less

# Use Vim as man pager. The substitution part is to avoid POSIX man pages from
# having an annoying multibyte dash (U+2212 MINUS SIGN).
# export MANPAGER="/bin/sh -c \"col -b | sed 's/−/-/g' | vim +'set ft=man' -\""

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
  "$HOME/work/bin/bin"
  "$HOME/.git-radar"
  "$HOME/work/git-multi-status"
  "$HOME/.gem/ruby/2.3.0/bin"
)
export PATH

# }}}
# Source .zshrc {{{

source ~/.zshrc

# }}}
