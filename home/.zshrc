# vim: fdm=marker fmr={{{,}}} fdl=0
# Author Andreas Louv <andreas@louv.dk>
# This is my personal zsh configuration.
# Use at own risk, NO WARRANTY, to the extent permitted by law.
# Basic Settings ---------------------------------------------------------- {{{

# noclobber: Prevent overwriting of files by redirection
# Can be overridden with '>|'
set -C

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
export LS_COLORS="$(tr $'\n' ':' < $DOTFILES_ROOT/resources/term-colors)"
autoload -U colors && colors

# Make 'cd' push directories so 'cd -N', where 'N' is an integer, can be used
# to navigate back to old directories.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# }}}
# History configuration --------------------------------------------------- {{{

setopt HIST_IGNORE_SPACE
HISTSIZE=1000000000
HISTFILESIZE=1000000000
SAVEHIST=1000000000
HISTFILE="$HOME/.zsh/history"

# }}}
# Convenience mappings ---------------------------------------------------- {{{

bindkey -e

# <C-Z> will call 'fg' when no process is running in the foreground {{{

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER=" fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

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
bindkey -s ',ei' 'vim ~/.i3/config\n'

# Source .zshrc
bindkey -s ',sz' 'source ~/.zshrc\n'

# }}}

# }}}
# Pre command and PS1, PS2, right PS1 ------------------------------------- {{{

# Set this to one to disable git prompt, useful when needing to temporary
# disable the prompt
export NO_GIT_PROMPT=0

precmd () {
  # List most recent changed files when changing directory
  if [ ! "$_OLD_DIR" = "$PWD" ]; then
    ls --color=always -lAht | sed '1d;7q'
    export _OLD_DIR="$PWD"
  fi

  # Set terminal title to current directory
  print -Pn "\e]2;%d\a"

  # Define variables that will be used by PROMPT
  _prompt_date="%{$fg_bold[grey]%}($(date +%r))%{%b%}"
  _prompt_jobs="%{$fg[cyan]%}$( (jobs) | wc -l)"
  _prompt_sudo="$(sudo -n true 2> /dev/null && echo "%{$fg[red]%}\$" || echo "%{$fg[green]%}%%")"

  # Show git information on the right, unless we are in a mounted directory.
  # Usually I mount samba drives, etc which might contain git repos, and the
  # prompt will stall if we are calling git status after each command
  if [ "$NO_GIT_PROMPT" -gt 0 ] || [[ "$PWD" =~ "/mnt"* ]]; then
    _prompt_git="%{$fg[red]%}NO GIT%{%b%}"
  else
    _prompt_git="$(git-linfo)"
  fi
}

# Prompt {{{

# Make '$PROMPT' evaluate '$'
setopt PROMPT_SUBST

# PROMPT relies on 'precmd'
declare -x PROMPT="%{$fg_bold[cyan]%} %~ %{%b%}\$_prompt_date \$_prompt_jobs \$_prompt_sudo %{$reset_color%b%}"
declare -x PROMPT2="%{$fg_bold[red]%}-->%{$reset_color$b%} "
declare -x RPROMPT="\$_prompt_git"

# }}}

# }}}
# Command completion ------------------------------------------------------ {{{

# Enable <tab> completion
autoload -U compinit promptinit
compinit

# Compilation
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

# Write part of command and press <Up>/<Down> complete it though history search
# and bring the cursor to the end of the line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

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
# Aliases ----------------------------------------------------------------- {{{

alias cd..="cd .."
# Suppress annoying directory print when directory is found in '$CDPATH'
alias cd="cd > /dev/null"

# Vim muscle memory
alias :q=" exit"
alias :e="vim"

alias ls='ls --color=auto'
alias l='ls -lAh'
alias ll='ls -lh'

alias grep="grep --color=auto --exclude-dir={.git} --line-number"

# }}}
# Function and includes --------------------------------------------------- {{{

_update_open_suggest() {
  local arg="_files -W '$PWD'; _files -W '${CDPATH//:/"'; _files -W '"}'"
  compdef "$arg" open
}
_update_open_suggest

# After mounting the work development server its nice to be able to use
# 'cd dfd', 'cd bas', ...
work() {
  export CDPATH="/mnt/dksrv206/www/dev:$CDPATH"
  _update_open_suggest
}

# Update PATH list, nice when just installed a program and want to run it
# immediately, but are to lazy to type the full name
u() {
  export PATH="$PATH"
}

d() {
  date +'Week %W, %a %F, %T'
}

if [ -f "$HOME/work/Sitemule/bin/.zshrc" ]; then
  source "$HOME/work/Sitemule/bin/.zshrc"
fi

# Auto Complete the following scripts
compdef _gnu_generic zipSeries

# }}}
