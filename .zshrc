# start tmux
case "$TERM" in
	linux) tmux;;
esac

# Disable stops all output to the terminal Ctrl+S
stty ixany
stty ixoff -ixon



# Set up the prompt

PS1='%F{red}%n%F{green}@%m%k %B%F{blue}%(4~|...|)%3~%F{white} %# %b%f%k'

setopt histignorealldups sharehistory

# Search path for the cd command
cdpath=(.. ~ ~/tmp ~/git)

# Auto cd
setopt autocd

# Globing
setopt extendedglob

# C-R history
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

bindkey "^[OB" down-line-or-search
bindkey "OA" up-line-or-search
bindkey "^[OC" forward-char
bindkey "^[OD" backward-char
bindkey "^[OF" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^?" backward-delete-char

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# Automatic Typo Correction
setopt correctall

# Add color comands and etc ...
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

#
setopt menucomplete
zstyle ':completion:*' menu select=2 _complete _ignored _approximate

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

manpath=($HOME/.man /usr/share/man /usr/local/man /usr/local/share/man /usr/X11R6/man /opt/man)
export MANPATH


#export MANPATH=$HOME/.man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/X11R6/man:/opt/man
export HELPDIR=/usr/share/zsh/help
autoload -Uz run-help
export PAGER=most
export USER_AGENT="Firefox/51.0 (Windows; U; Windows NT 5.1;ru-RU;rv:50.9.1.3) Gecko/51.0 Firefox/51.0 (.NET CLR 3.5.30729)"
export EDITOR=vim
export LYNX_CFG=~/.lynx/lynx.cfg
export WWW_HOME=https://duckduckgo.com/



# My alias
# shellcheck disable=SC2015 disable=SC2015
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# shellcheck disable=SC1090 disable=SC1091
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# shellcheck disable=SC1090 disable=SC1091
if [ -f "$HOME/.bash_functions" ]; then
    . $HOME/.bash_functions
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH=":.:$HOME/bin:/usr/games:/sbin:/usr/sbin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
