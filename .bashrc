#
# ~/.bashrc
#

stty stop undef
stty start undef

export EDITOR=vim

case "$OSTYPE" in
  darwin*)
    ps=' \[\033[33m\]✘╹◡╹✘\[\033[0m\] <'
    alias ls='ls -FG'
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
    ;;
  linux*|cygwin)
    ps='$'
    alias ls='ls -hF --color=auto'
    ;;
esac

# Prompt
! type -t __git_ps1 >/dev/null && test -f ~/bin/git-prompt.sh && . ~/bin/git-prompt.sh
export PS1="\$(if [ \$? = 0 ]; then echo \[\033[32m\]; else echo \[\033[31m\]; fi)[\u@\h \w]\[\033[1;31m\]\$(type -t __git_ps1 >/dev/null && __git_ps1)\[\033[0m\]\n$ps "

# Aliases
alias ll='ls -Al'
alias la='ls -A'
alias ..='cd ..'
alias rmdir='rm -rf'

alias tree='tree -CF'
alias grep='grep --color=auto'
alias diff='git diff --no-index -u'

alias h='fc -l'
alias hs='fc -l 1 | grep'
alias l=less
alias ag='ag --color-path="1;36"'
alias be='bundle exec'

alias ga='git add'
alias gaa='git add .'
alias gaaa='git add . --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git checkout'
alias gcm='git commit -m'
alias gd='git diff'
alias gda='git diff HEAD'
alias gdc='git diff --cached'
alias gl='git log'
alias gs='git status'
alias glg='git log --graph --oneline --decorate --all'

composer() {
  local command="$1" && shift
  local opt options="" dir="$PWD"
  while [ -n "$dir" ]; do
    [ -f "$dir/composer.json" ] && break
    [ "$dir" = "/" ] && dir="." && break
    dir="$(dirname $dir)"
  done
  for opt in "$@"; do
    [ -e "$PWD/$opt" ] && opt="$PWD/$opt"
    options+="$opt "
  done
  "$(which composer)" $command $options --working-dir="$dir"
}
