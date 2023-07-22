#!/bin/bash

set -e

# nvim
cd ~
mkdir -p .config/nvim
ln -s ../../dotfiles/init.vim .config/nvim/init.vim
ln -s dotfiles/init.vim .nvimrc

cd .local/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
ln -s nvim.appimage nvim
ln -s nvim.appimage vim
curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install libfuse2

# Vim
# ln -s dotfiles/.vimrc .
# mkdir .vim
# cd .vim
# ln -s ../dotfiles/.vim/autoload .
# ln -s ../dotfiles/.vim/colors .
# ln -s ../dotfiles/.vim/syntax .
# mkdir .backup
# mkdir .swp
# mkdir .undo

# Neovim
# Install npm, go on linux
# npm config set prefix ~/.local
