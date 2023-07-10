#
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# History
export HISTSIZE=10000
export HISTCONTROL=ignoreboth

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CACHE_HOME"
mkdir -p "$XDG_DATA_HOME"

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# bash_local
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
