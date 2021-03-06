# dotfiles

## Installation
```
./setup.sh
```

## Vim

### If building from source
```
./configure --prefix="/afs/cs.stanford.edu/u/takatoki/.local" --with-features=huge --enable-multibyte --enable-python3interp --with-python3-config-dir=$(python-config --configdir) --enable-rubyinterp --enable-perlinterp --enable-cscope --enable-fail-if-missing
make
make install
```

YCM and Vim must be compiled with the same python version.

Install https://github.com/junegunn/vim-plug

## Less Colorization
```
brew install lesspipe
pip install Pygments
```

To get lesspipe.sh to pass in arguments to pygmentize, edit ```/usr/local/bin/code2color```:

Line 3258:
```
    if ($ENV{LESSCOLORIZER} eq 'pygmentize') {
      # do not call pygmentize with - and use option -g
      @ARGV = grep {$_ ne '-'} @ARGV;
      my ($name,$path,$ext) = fileparse(@ARGV[0],qr/\.[^.\s\W]{0,5}/);
      if ($ext eq '.txt') {
          exit;
      }
      # unshift @ARGV, '-g';
      @ARGV_MONOKAI = ('-g', '-f', 'terminal256', '-P', 'style=monokai');
      push @ARGV_MONOKAI, @ARGV;
      @ARGV = @ARGV_MONOKAI;
    }
```
