# vim: fdm=marker fmr={{{,}}} fdl=0
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration.
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Basic Settings {{{

# zsh souces .zshrc before .zlogin, I do NOT like that!
if [ -z "$DOTFILES_ROOT" ]; then
  return
fi


# noclobber: Prevent overwriting of files by redirection
# Can be overridden with '>|'
set -C

export TERM=xterm-256color

# Root zshell directory, used to store history, etc...
mkdir -p "$HOME/.zsh"

# Make key maps expire after 1 second, instead of the default 400 ms
export KEYTIMEOUT=100

# 'cd' will now also look in the 'work' directory this will make commands like
# 'cd dotfiles' work from everywhere.
export CDPATH="$HOME/work"

# Set BROWSER
if [ -n "$DISPLAY" ]; then
  export BROWSER=chromium
fi

# Termite is not by default recognized properly, so it's needed to have a
# hard coded LS_COLORS variable
export LS_COLORS="$(tr $'\n' ':' < "$DOTFILES_ROOT"/resources/term-colors)"
autoload -U colors && colors

# Make 'cd' push directories so 'cd -N', where 'N' is an integer, can be used
# to navigate back to old directories.
setopt auto_pushd pushd_ignore_dups pushdminus

# Make <C-w> be more intuitive
WORDCHARS=''

# }}}
# History configuration {{{

setopt HIST_IGNORE_SPACE
HISTSIZE=1000000000
HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="$HOME/.zsh/history"

# }}}
# Convenience mappings {{{

bindkey -e

# <C-Z> will call 'fg' when no process is running in the foreground {{{

fancy-ctrl-z () {
  if [ "${#BUFFER}" -eq 0 ]; then
    if [ "$(jobs | wc -l)" -gt 0 ]; then
      fg
      zle accept-line
    fi
  else
    zle push-input
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# }}}
# <C-X><C-E> will edit current command in editor {{{

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# }}}
# Working with GIT {{{

bindkey -s ',ga' 'git add -p\n'
bindkey -s ',gc' 'git commit -v\n'
bindkey -s ',gC' 'git commit --amend -v\n'
bindkey -s ',gp' 'git pull\n'
bindkey -s ',gP' 'git push\n'
bindkey -s ',gs' 'git status\n'

# }}}
# Quick editing {{{

bindkey -s ',ev' 'vim ~/.vim/vimrc\n'
bindkey -s ',ez' 'vim ~/.zshrc\n'
bindkey -s ',eg' 'vim ~/.gitconfig\n'
bindkey -s ',es' 'vim ~/.vim/spell.utf-8.add\n'
bindkey -s ',ei' 'vim ~/.config/i3/config\n'

# Source .zshrc
bindkey -s ',sz' 'source ~/.zshrc\n'

# }}}

# }}}
# Pre command and PS1, PS2, right PS1 {{{

precmd () {
  # List most recent changed files when changing directory
  if [ ! "$_OLDDIR" = "$PWD" ]; then
    ls --color=always -lAht | sed '1d;7q'
  fi

  export _OLDDIR="$PWD"

  # Set terminal title to current directory
  print -Pn "\e]2;%d\a"
}

# Prompt {{{

# Make '$PROMPT' evaluate '$'
setopt PROMPT_SUBST

_prompt_jobs() {
  echo "%{$fg[yellow]%}$(jobs | awk '/^\[/{c++}; END {if (c) print " " c}')"
}
_prompt_sudo() {
  echo "$(sudo -n true 2> /dev/null && echo "%{$fg[red]%}#" || echo "%{$fg[green]%}\$")"
}
_prompt_git() {
  # Show git information on the right, unless we are in a mounted directory.
  # Usually I mount samba drives which might contain git repos, and the
  # prompt will stall if we are calling git status after each command
  if git rev-parse --is-inside-work-tree &> /dev/null; then
    if [[ "$PWD" =~ "/mnt"* ]]; then
      echo "%{$fg[red]%}NO GIT%{%b%}"
    else
      echo "$(git-radar --zsh --fetch)"
      return 0
    fi
  fi
  return 1
}
_prompt_user() {
  echo " %{$fg[blue]%}%n%{%b%}@%{$fg[blue]%}%M%{%b%} [%{$fg_bold[red]%}%?%{%b%}]"
}
declare -x PROMPT="%{$fg_bold[yellow]%} %~%{%b%}\$(_prompt_jobs) \$(_prompt_sudo) %{$reset_color%b%}"
declare -x PROMPT2="%{$fg_bold[red]%}-->%{$reset_color$b%} "
declare -x RPROMPT="\$(_prompt_git || _prompt_user)"

# }}}

# }}}
# Command completion {{{

# Don't complain about unmatched globs, do as a POSIX shell and print the glob
# literal:
unsetopt nomatch

# Enable <tab> completion
autoload -U compinit promptinit
compinit

# Compilation
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# Make <Tab> complete word left of cursor instead word under cursor:
# sud|ls /etc/blah -> <Tab> -> sudols /etc/blah
#    ^ Cursor
bindkey '^I' expand-or-complete-prefix

# One day I want to bind <C-N> and <C-P> as <down> and <up> arrow keys on X
# level. But first I need to figure out who applications already using them, eg.
# vim in insert mode uses them to suggest text. This would need to be mapped.
# For now just disable them stupid arrow keys
# Unbind arrow keys
bindkey -r '^[[A' # Up
bindkey -r '^[[B' # Down
bindkey -r '^[[C' # Right
bindkey -r '^[[D' # Left

# Write part of command and press <C-P>/<C-N> complete it though history search
# and bring the cursor to the end of the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Enable <S-Tab> to reverse navigation though suggestions
bindkey '^[[Z' reverse-menu-complete

# Color coding suggested directories, files, executable, ...
zstyle ':completion:*' list-colors ''

# Highlight currently selection suggestion
zstyle ':completion:*:*:*:*:*' menu select

# When completing the 'kill' command all running processes will be shown, not
# only sub processes
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Color coding suggestions for the 'kill' command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Enable case-insesensitive completing
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Complete for vpnc
compdef '_files -W /etc/vpnc' vpnc

# }}}
# Aliases {{{

alias cd..="cd .."
# Suppress annoying directory print when directory is found in '$CDPATH'
alias cd="cd > /dev/null"

alias ls='ls --color=auto'
alias l='ls -lAh'

alias grep="grep --color=auto --exclude-dir={.git}"

# }}}
# Function and includes {{{

# After mounting the work development server its nice to be able to use
# 'cd dfd', 'cd bas', ...
work() {
  export CDPATH="/mnt/dksrv206/www/dev:$CDPATH"
}

# Update PATH list, nice when just installed a program and want to run it
# immediately, but are to lazy to type the full name
u() {
  export PATH="$PATH"
}

d() {
  date +'Week %W, %a %F, %T'
}

export SITEMULE_CTAGS=1

if [ -f "$HOME/work/Sitemule/util/.zshrc" ]; then
  source "$HOME/work/Sitemule/util/.zshrc"
fi

if [ -f "$HOME/work/extensions/util/.zshrc" ]; then
  source "$HOME/work/extensions/util/.zshrc"
fi

# Auto Complete the following scripts
compdef _gnu_generic zipSeries

compdef "_files -W '${PATH//:/"'; _files -W '"}'" cdbin vibin catbin

# }}}
