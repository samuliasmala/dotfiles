#!/bin/bash

DOTFILES=(
    .bashrc
    .bash_aliases
    .gitconfig
    .screenrc
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p "$HOME/.local/bin"

read -p 'Set timezone to Finland? (y/n) ' -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo timedatectl set-timezone Europe/Helsinki
fi

read -p 'Backup current dotfiles? (y/n) ' -n 1 BACKUP
echo ''
if [[ ! $BACKUP =~ ^[Nn]$ ]]; then
  echo 'Current dotfiles are renamed to .bak'
fi

for i in "${DOTFILES[@]}"; do
  read -p "Symlink $i? (y/n) " -n 1
  echo ''
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f "$HOME/$i" ]; then
      if [[ ! $BACKUP =~ ^[Nn]$ ]]; then
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
  mkdir -v "$HOME/.screen" && chmod 700 "$HOME/.screen"
fi

read -p 'Install bash-git-prompt to ~/.local? (y/n) ' -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git clone https://github.com/magicmonty/bash-git-prompt.git $HOME/.local/bash-git-prompt --depth=1
fi

read -p 'Install diff-so-fancy to ~/.local (required for .gitconfig)? (y/n) ' -n 1
echo ''
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git clone git@github.com:so-fancy/diff-so-fancy.git $HOME/.local/diff-so-fancy
  ln -s $HOME/.local/diff-so-fancy/diff-so-fancy $HOME/.local/bin/diff-so-fancy
fi
