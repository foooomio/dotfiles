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

__uninstall() {
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
  cat "${BASEDIR}/brewlist" | xargs brew install
  sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
  chsh -s /usr/local/bin/bash
}

__install_vim() {
  [[ "$OSTYPE" =~ "darwin" ]] && __install_macvim
  __install_dein
}

__install_macvim() {
  local api='https://api.github.com/repos/splhack/macvim-kaoriya/releases/latest'
  local url="$(curl -s $api | jq -r .assets[0].browser_download_url)"
  echo 'Downloading MacVim-KaoriYa'
  curl -Lo /var/tmp/MacVim-KaoriYa.dmg "$url"
  hdiutil attach -nobrowse -mountpoint /Volumes/MacVim-KaoriYa /var/tmp/MacVim-KaoriYa.dmg
  echo 'Installing MacVim-KaoriYa'
  ditto /Volumes/MacVim-KaoriYa/MacVim.app /Applications
  hdiutil detach /Volumes/MacVim-KaoriYa
}

__install_dein() {
  local DEINDIR="${HOME}/.cache/dein"
  mkdir -p "$DEINDIR"
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${DEINDIR}/installer.sh"
  bash "${DEINDIR}/installer.sh" "$DEINDIR"
  vim -c q
}

__install_anyenv() {
  git clone https://github.com/riywo/anyenv ~/.anyenv
  mkdir -p ~/.anyenv/plugins
  git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
}

case "${1-}" in
  install|'') __deploy_dotfiles  ;;
  uninstall)  __uninstall        ;;
  vim|dein)   __install_vim      ;;
  *brew)      __install_homebrew ;;
  anyenv)     __install_anyenv   ;;
  *)          echo "unknown option: $1" && exit 1 ;;
esac

echo 'Operation completed.'
exit 0
