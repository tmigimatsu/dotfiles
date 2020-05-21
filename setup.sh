#!/bin/bash

set -e

cd "$(dirname "$0")"
git submodule init && git submodule update
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
mkdir -p .oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git .oh-my-zsh/custom/plugins/zsh-autosuggestions
cd ~
ln -s dotfiles/.tmux.conf .
ln -s dotfiles/.tmux .
ln -s dotfiles/.vimrc .
if [[ -f .bashrc ]]; then
	mv .bashrc .bashrc.bak
fi
ln -s dotfiles/.bashrc .
mkdir .vim
cd .vim
ln -s ../dotfiles/.vim/autoload .
ln -s ../dotfiles/.vim/colors .
ln -s ../dotfiles/.vim/syntax .
mkdir .backup
mkdir .swp
mkdir .undo
