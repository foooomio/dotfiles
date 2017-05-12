#!/bin/bash
set -eu

BASEDIR="$(cd $(dirname $0);pwd)"
BACKUPDIR="${HOME}/.backup"
DOTFILES=(
  .bash_profile
  .bashrc
  .bundle/config
  .gemrc
  .git_template/hooks/pre-commit
  .gitconfig
  .inputrc
  .vimrc
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
}

__install_dein() {
  local DEINDIR="${HOME}/.cache/dein"
  mkdir -p "$DEINDIR"
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > "${DEINDIR}/installer.sh"
  bash "${DEINDIR}/installer.sh" "$DEINDIR"
  vim -c q
}

case "${1-}" in
  install|'') __deploy_dotfiles  ;;
  uninstall)  __uninstall        ;;
  vim|dein)   __install_dein     ;;
  *brew)      __install_homebrew ;;
  *)          echo "unknown option: $1" && exit 1 ;;
esac

echo 'Operation completed.'
exit 0
