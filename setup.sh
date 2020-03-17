git submodule init && git submodule update
git clone https://github.com/zsh-users/zsh-autocomplete.git .oh-my-zsh/custom/plugins
cd ~
ln -s dotfiles/.tmux.conf .
ln -s dotfiles/.tmux .
ln -s dotfiles/.vimrc .
mkdir .vim
cd .vim
ln -s ../dotfiles/.vim/autoload .
ln -s ../dotfiles/.vim/colors .
ln -s ../dotfiles/.vim/syntax .
mkdir .backup
mkdir .swp
mkdir .undo
