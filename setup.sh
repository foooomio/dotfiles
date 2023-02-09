#!/bin/bash
set -eu

BASEDIR="$(cd "$(dirname "$0")";pwd)"
BACKUPDIR="${HOME}/.backup"
DOTFILES=(
  .bash_profile
  .bashrc
  .bundle/config
  .config/git/config
  .config/git/ignore
  .gemrc
  .inputrc
  .vimrc
  .Xmodmap
)

__deploy_dotfiles() {
  local FILE DIRNAME
  for FILE in "${DOTFILES[@]}"; do
    DIRNAME="$(dirname "$FILE")"
    if [[ -f "${HOME}/${FILE}" && ! -L "${HOME}/${FILE}" ]]; then
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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install $(< brewlist)
}

__install_macvim() {
  local dmg api url
  dmg="/var/tmp/MacVim.dmg"
  api="https://api.github.com/repos/macvim-dev/macvim/releases/latest"
  url="$(curl -fsSL $api | jq -r '.assets[] | select(.name == "MacVim.dmg").browser_download_url')"
  echo "Downloading $url"
  curl -Lo "$dmg" "$url"
  hdiutil attach -nobrowse -mountpoint /Volumes/MacVim "$dmg"
  echo "Installing $dmg"
  ditto /Volumes/MacVim/MacVim.app /Applications/MacVim.app
  hdiutil detach /Volumes/MacVim
}

__install_dein() {
  local DEINDIR
  DEINDIR="${HOME}/.cache/dein"
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

echo "Operation completed."
exit 0
