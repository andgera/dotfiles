# Starting X server for /dev/tty6
if [ "$TTY" = "/dev/tty6" ]
then
        startx
fi

# start tmux
case "$TERM" in
	linux) tmux;;
esac

# Disable stops all output to the terminal Ctrl+S
stty ixany
stty ixoff -ixon



# Set up the prompt

#PS1='%F{red}%n%F{green}@%m%k %B%F{blue}%(4~|...|)%3~%F{white} %# %b%f%k'
PS1='%F{yellow}job:%F{magenta}%j %F{green}%m%F{blue}@ %k%B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k'
RPROMPT="%F{white}[%F{yellow}%? %y%F{white}]"

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

autoload -U edit-command-line
zle -N edit-command-line
bindkey '' edit-command-line

### Automatically open images:
 if which feh >/dev/null; then
    alias -s {jpg,JPG,jpeg,JPEG,png,PNG,gif,GIF}="feh -FZd"
fi
# ### Automatically open movies:
if which mpv >/dev/null; then
alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,3GP}="mpv"
fi
### Automatically open other known files:
which mupdf >/dev/null && alias -s pdf="mupdf"
which mupdf >/dev/null && alias -s ps="mupdf"
which zathura >/dev/null && alias -s djvu="zathura"

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
setopt HIST_IGNORE_DUPS

# Ctr+X Ctrl+Z, при вводе команды будет автоматически производится поиск
# в истории по первым буквам команды. Нажатие Ctrl+Z
# отключит этот режим.
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on # C-x C-z
bindkey "^Z" predict-off # C-z

# Use modern completion system
autoload -Uz compinit
compinit

autoload -U zcalc

autoload -U colors
colors
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
autoload run-help-git
alias help=run-help

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

if [ -f /usr/bin/grc ]; then
 alias gcc="grc --colour=auto gcc"
 alias free="grc --color=auto free"
 alias ss="grc --colour=auto ss"
 alias nmap="grc --colour=auto nmap"
 alias netstat="grc --colour=auto netstat"
 alias ping="grc --colour=auto ping"
 alias lftp="grc --colour=auto lftp"
 alias traceroute="grc --colour=auto traceroute"
fi

# Для вывода стека директорий cd -<NUM>

DIRSTACKFILE="$HOME/.cache/zsh/dirs"

[[ -d "$HOME/.cache/zsh" ]] || mkdir -p $HOME/.cache/zsh
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Удалить повторяющиеся записи
setopt pushdignoredups
## Это Отменяет +/- операторы.
setopt pushdminus


[[ -s "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -s "/usr/share/doc/fzf/examples/completion.zsh" ]] && source /usr/share/doc/fzf/examples/completion.zsh 
[[ -s "/etc/grc.zsh" ]] && source /etc/grc.zsh
