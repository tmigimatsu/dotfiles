#!/bin/bash

set -e

cd "$(dirname "$0")"
git submodule init && git submodule update

# Zsh
mkdir -p .oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git .oh-my-zsh/custom/plugins/zsh-autosuggestions

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# Tmux
cd ~
ln -s dotfiles/.tmux.conf .
ln -s dotfiles/.tmux .

# Shell
if [[ -f .zshrc ]]; then
	mv .zshrc .zshrc.bak
fi
ln -s dotfiles/.zshrc .
if [[ -f .bashrc ]]; then
	mv .bashrc .bashrc.bak
fi
ln -s dotfiles/.bashrc .

# 256 color
#tic -x xterm-256color-italic.terminfo
#tic -x tmux-256color.terminfo

# sudo cp lesspipe.git/lesspipe.sh lesspipe.git/code2color /usr/local/bin
# pip3 install Pygments

sudo apt install clangd-13 clang-format-13 clang-tidy-13
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 13
sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 13
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-13 13
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-13 13
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-13 13
