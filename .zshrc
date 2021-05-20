# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
[ -f ~/dotfiles/private.sh ] && source ~/dotfiles/private.sh

# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	fzf
	osx
	zsh-autosuggestions
	zsh_reload
)
# git clone https://github.com/zsh-users/zsh-autosuggestions.git
# .oh-my-zsh/custom/plugins/zsh-autosuggestions

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##############
### Colors ###
##############

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

PROMPT='%{[01;32m%}%n@%m%{[0m%}:%{[01;34m%}%~%{[0m%}$ '

autoload -Uz vcs_info
precmd_functions+=( vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '(%b)'

###############
### Aliases ###
###############

# Vim mode
bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey '^\' edit-command-line

# No match glob expansion
setopt nonomatch

# h: human readable; A: do not list . and ..; N: print raw entry names
alias ls='ls -hAN --color=always'
alias ll='ls -lhAN --color=always'

# Color grep output
alias grep='grep --color=auto'

alias omg='sudo $(history -p !!)'

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

tp() {
	tmux set -g prefix C-$1
	tmux unbind C-a
	tmux unbind C-b
	tmux unbind C-q
	tmux bind C-$1 send-prefix
	tmux bind $1 last-window
	tmux bind C-$1 last-window
}

conda_init() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# <<< conda initialize <<<
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
	if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

	# Add source highlighting and binary file compatibility to less
	export LESSOPEN="|lesspipe.sh %s"
	export LESSCOLORIZER='pygmentize'
	export LESS='-XR' # do not clear upon exiting, enable colors

	# Display color terminal
	export CLICOLOR=1

else
	export PATH="${HOME}/.local/bin:${PATH}"

	# Add source highlighting and binary file compatibility to less
	export LESSOPEN="|lesspipe.sh %s"
	export LESSCOLORIZER='pygmentize'
	export LESS='-XR' # do not clear upon exiting, enable colors

	alias grep='grep --color=auto'

	# alias afs='kinit -R || kinit -l 3d -r 30d takatoki@CS.STANFORD.EDU'
	alias afs='kinit && aklog && krenew -K 60 -t'
	alias kerb='k5start -U -f /etc/krb5.keytab -ab -K 60 -- aklog'
fi

###############
### Execute ###
###############

if [[ -z $TMUX ]]; then
	if [[ -n $SSH_CLIENT ]]; then
		tp b
	fi
	if [[ -z $(pgrep tmux) ]]; then
		tmux new-session
	elif [[ -z $(tmux list-clients) ]]; then
		tmux attach -d
	fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
