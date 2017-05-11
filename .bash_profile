#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# anyenv
if [ -d ~/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

# Path
PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH" # basic
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"    # gnu-sed
PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"  # MacVim
PATH="/usr/local/heroku/bin:$PATH"                    # heroku
export PATH

# History
shopt -s histappend
export HISTSIZE=10000
export HISTCONTROL=ignoreboth
export PROMPT_COMMAND="history -a; history -n"

# bash completion
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# bash_local
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
