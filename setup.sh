#!/bin/bash
set -eu

BASEDIR="$(cd $(dirname $0);pwd)"
BACKUPDIR="${HOME}/.backup"
DOTFILES=(
  .bash_profile
  .bashrc
  .bundle/config
  .gemrc
  .gitconfig
  .inputrc
  .vimrc
  .Xmodmap
)

__deploy_dotfiles() {
  local FILE
  for FILE in "${DOTFILES[@]}"; do
    local DIRNAME="$(dirname $FILE)"
    if [ -f "${HOME}/${FILE}" -a ! -L "${HOME}/${FILE}" ]; then
      mkdir -p "${BACKUPDIR}/${DIRNAME}"
      mv -f "${HOME}/${FILE}" "${BACKUPDIR}/${FILE}"
      echo "Created backup in ${BACKUPDIR}/${FILE}"
    fi
    mkdir -p "${HOME}/${DIRNAME}"
    ln -sf "${BASEDIR}/${FILE}" "${HOME}/${FILE}"
  done
}

__revert_dotfiles() {
  local FILE
  for FILE in "${DOTFILES[@]}"; do
    test -L "${HOME}/${FILE}" && unlink "${HOME}/${FILE}"
    if [ -f "${BACKUPDIR}/${FILE}" ]; then
      cp -f "${BACKUPDIR}/${FILE}" "${HOME}/${FILE}"
    fi
  done
}

__install_homebrew() {
  echo 'Before installing Homebrew, execute `xcode-select --install`'
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install $(< brewlist)
  sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
}

__install_macvim() {
  local dmg='/var/tmp/MacVim.dmg'
  local api='https://api.github.com/repos/macvim-dev/macvim/releases/latest'
  local url="$(curl -s $api | jq -r .assets[0].browser_download_url)"
  echo "Downloading $url"
  curl -Lo "$dmg" "$url"
  hdiutil attach -nobrowse -mountpoint /Volumes/MacVim "$dmg"
  echo "Installing $dmg"
  ditto /Volumes/MacVim/MacVim.app /Applications/MacVim.app
  hdiutil detach /Volumes/MacVim
}

__install_dein() {
  local DEINDIR="${HOME}/.cache/dein"
  mkdir -p "$DEINDIR"
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${DEINDIR}/installer.sh"
  bash "${DEINDIR}/installer.sh" "$DEINDIR"
  vim -c q
}

case "${1-}" in
  install)    __deploy_dotfiles  ;;
  uninstall)  __revert_dotfiles  ;;
  dein)       __install_dein     ;;
  macvim)     __install_macvim   ;;
  *brew)      __install_homebrew ;;
  help|'')    echo "command: install|uninstall|dein|macvim|homebrew" && exit 0 ;;
  *)          echo "unknown option: $1" && exit 1 ;;
esac

echo 'Operation completed.'
exit 0
