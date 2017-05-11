#
# ~/.bashrc
#

# Prompt
case "$OSTYPE" in
  darwin*)
    export PS1="\$(if [ \$? = 0 ]; then echo \[\033[32m\]; else echo \[\033[31m\]; fi)[\u@\h \w]\$(type -t __git_ps1 >/dev/null && __git_ps1)\n\[\033[33m\] ✘╹◡╹✘\[\033[0m\] < "
    alias ls='ls -FG'
    ;;
  linux*)
    alias ls='ls -hF --color=auto'
    ;;
  cygwin)
    alias ls='ls -hF --color=auto'
    ;;
esac

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
