#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Path
PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH" # basic
PATH="/usr/local/opt/ruby/bin:$PATH"                  # ruby
PATH="/usr/local/opt/openssl/bin:$PATH"               # openssl
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"    # gnu-sed
PATH="/Applications/MacVim.app/Contents/bin:$PATH"    # MacVim
PATH="$HOME/go/bin:$HOME/.cargo/bin:$PATH"            # misc
PATH="$(ruby -e 'print Gem.dir')/bin:$PATH"
export PATH

# rbenv
if [ -d ~/.rbenv ]; then
  eval "$(rbenv init -)"
fi

# History
export HISTSIZE=10000
export HISTCONTROL=ignoreboth

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# bash completion
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# bash_local
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
