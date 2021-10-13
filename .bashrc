# If not running interactively, don't do anything
[ -f ~/dotfiles/private.sh ] && source ~/dotfiles/private.sh
[[ "$-" != *i* ]] && return

#####################
### Shell Options ###
#####################

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Append to the history file, don't overwrite it
shopt -s histappend

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# vi mode
set -o vi

# Ignore case completion
bind "set completion-ignore-case on"

##############
### Colors ###
##############

# export LS_COLORS='di=01;94:ex=00;97'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

###############
### Aliases ###
###############

test -z "$TMUX" && (tmux attach -d || tmux new-session)
return

# h: human readable; A: do not list . and ..; N: print raw entry names
alias ls='ls -hAN --color=always'
alias ll='ls -lhAN --color=always'
# alias ls='ls -hFA --color=always'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias vi='vim'
alias tmux='tmux -2'

[[ ! -f ~/dotfiles/ssh.sh ]] || source ~/dotfiles/ssh.sh

cdl() {
	cd "$*"
	ls
}

mvl() {
	mv "$1" "$2"
	cdl "$2"
}

cpl() {
	cp "$1" "$2"
	cdl "$2"
}

lessc() {
	pygmentize -g -f terminal256 -P style=monokai $1 | less -R
}

tp() {
	tmux set -g prefix C-$1
	tmux unbind C-a
	tmux unbind C-b
	tmux unbind C-q
	tmux bind C-$1 send-prefix
	tmux bind $1 last-window
	tmux bind C-$1 last-window
}

#######################
### System Specific ###
#######################

if [[ `uname` == 'Darwin' ]]; then
	# Add brew paths
	export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

	# Add julia path
	# export PATH="/Applications/Julia-0.5.app/Contents/Resources/julia/bin:$PATH"

	# Add Haskell stack path
	export PATH="$HOME/.local/bin:$PATH"

	# Add Python path
	# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

	# Add source highlighting and binary file compatibility to less
	export LESSOPEN="|lesspipe.sh %s"
	export LESSCOLORIZER='pygmentize'
	export LESS='-XR' # do not clear upon exiting, enable colors
	# alias less=lessc

	# Display color terminal
	export CLICOLOR=1

	# Color grep output
	alias grep='grep --color=auto'

elif [[ `uname` == 'CYGWIN_NT-6.1' ]]; then
	# X11 display environmental variable
	export DISPLAY=:0

	alias vi='vim'
	alias runx='run xwin -multiwindow -noclipboard &'
	alias clear='printf "\033c"'

	open() {
		cygstart "$*"
	}

	set nodoswarning
else
	export PATH="${HOME}/.local/bin:${PATH}"

	# Add source highlighting and binary file compatibility to less
	export LESSOPEN="|lesspipe.sh %s"
	export LESSCOLORIZER='pygmentize'
	export LESS='-XR' # do not clear upon exiting, enable colors

	alias grep='grep --color=always'

	alias afs='kinit && aklog'
fi

###############
### Execute ###
###############

test -z "$TMUX" && (tmux attach -d || tmux new-session)
# if [[ -z "$TMUX" && -n $(pgrep tmux) ]]; then
#     if [[ -n "$SSH_CLIENT" ]]; then
#         tmux set -g prefix C-b
#         tmux unbind C-a
#         tmux bind C-b send-prefix
#         tmux bind b last-window
#         tmux bind C-b last-window
#     else
#         tmux set -g prefix C-a
#         tmux unbind C-b
#         tmux bind C-a send-prefix
#         tmux bind a last-window
#         tmux bind C-a last-window
#     fi
# fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
