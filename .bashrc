#
# ~/.bashrc
#

stty stop undef
stty start undef
shopt -s dotglob
shopt -s extglob
shopt -s globstar

export EDITOR=vim
export PAGER=less
export LESS='-iMQR'
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Prompt
! type -t __git_ps1 >/dev/null && test -f ~/bin/git-prompt.sh && . ~/bin/git-prompt.sh
export PS1="\$(if [ \$? = 0 ]; then echo \[\033[32m\]; else echo \[\033[31m\]; fi)[\u@\h \w]\[\033[1;31m\]\$(type -t __git_ps1 >/dev/null && __git_ps1)\[\033[0m\]\n\$ "

# Aliases
alias ls='ls -hF --color=auto'
alias ll='ls -Al'
alias la='ls -A'
alias ..='cd ..'
alias rmdir='rm -rf'

alias tree='tree -aCF -I ".git|node_modules"'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=auto'
alias diff='git diff --no-index -u'

alias h='history | grep'
alias hl='history | less'
alias l=less
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

man() {
  LESS_TERMCAP_mb=$'\e[1;36m'   \
  LESS_TERMCAP_md=$'\e[1;31m'   \
  LESS_TERMCAP_me=$'\e[0m'      \
  LESS_TERMCAP_so=$'\e[0;30;43m'\
  LESS_TERMCAP_se=$'\e[0m'      \
  LESS_TERMCAP_us=$'\e[4;32m'   \
  LESS_TERMCAP_ue=$'\e[0m'      \
  command man "$@"
}

