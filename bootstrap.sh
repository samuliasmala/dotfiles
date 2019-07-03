#!/bin/bash

DOTFILES=(
    .bashrc
    .bash_aliases
    .gitconfig
    .screenrc
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -p 'Set timezone to Finland? (y/n) ' -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo timedatectl set-timezone Europe/Helsinki
fi

read -p 'Overwrite current dotfiles? (y/n) ' -n 1 OVERWRITE
echo ''
if [[ ! $OVERWRITE =~ ^[Yy]$ ]]; then
  echo 'Current dotfiles are renamed to .bak'
fi

for i in "${DOTFILES[@]}"; do
  read -p "Symlink $i? (y/n) " -n 1
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$HOME/$i" ]; then
      if [[ $OVERWRITE =~ ^[Nn]$ ]]; then
        mv -v "$HOME/$i" "$HOME/$i.bak"
      else
        rm -v "$HOME/$i"
      fi
    fi
    ln -sv "$SCRIPT_DIR/$i" "$HOME/$i"
  fi
done

read -p "Create local socket directory for screen to $HOME/.screen? (y/n) " -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]] && [ ! -d $HOME/.screen ]; then
  mkdir -v "$HOME/.screen"
fi

read -p 'Install bash-git-prompt? (y/n) ' -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git clone https://github.com/magicmonty/bash-git-prompt.git $HOME/.bash-git-prompt --depth=1
fi

