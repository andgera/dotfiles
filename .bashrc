case $- in
    *i*) ;;
      *) return;;
esac

case "$TERM" in
 'xterm') TERM=xterm-256color;;
 'screen') TERM=screen-256color;;
 'Eterm') TERM=Eterm-256color;;
esac

[ -z "$PS1" ] && return

# HISTCONTROL - представляет из себя список опций, разделенных двоеточиями.
# Они контролируют каким образом список команд сохраняется в истории.
#
#   Опция        Описание
#   ignorespace  не сохранять строки начинающиеся с символа <пробел>
#   ignoredups   не сохранять строки, совпадающие с последней выполненной командой
#   ignoreboth   использовать обе опции 'ignorespace' и 'ignoredups'
#   erasedups    удалять ВСЕ дубликаты команд с истории

export HISTCONTROL=ignoreboth:erasedups
export HISTFILE=~/.bash_history
export HISTFILESIZE=100000
export HISTSIZE=30000
export HISTIGNORE="ls:cd:pwd:mc"
export HISTTIMEFORMAT='%F %T '

shopt -s histappend
PROMPT_COMMAND='history -a'

shopt -s dotglob
export GLOBIGNORE=".:.."

shopt -s cdspell
export QT_NO_GLIB=1

#Сохранять все строки многострочной команды в одной записи списка истории

shopt -s cmdhist

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# shellcheck disable=SC2086,SC1090
if [ -f "$HOME/.bash_aliases" ]; then
    . $HOME/.bash_aliases
fi

# shellcheck disable=SC2086,SC1090
if [ -f "$HOME/.bash_functions" ]; then
    . $HOME/.bash_functions
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

export PS1='\[\033[01;35m\] ▶ $(($(echo $TMUX_PANE | sed s/%//g)+1)) \[\033[01;31m\]\u\[\033[01;32m\]@\h\[\033[01;34m\] \W \$\[\033[00m\] '
export PS2='\[\e[0;1m\]\[\e[33;1m\] ∥── contune └──┤▶ \[\e[0;1m\]\[\033[0m\] '

if [ -d ~/bin ] ; then
PATH=:.:~/bin:~/.local/bin:/sbin/:/usr/sbin/:"${PATH}"
export PATH
fi

export USER_AGENT="Firefox/51.0 (Windows; U; Windows NT 5.1;ru-RU;rv:50.9.1.3) Gecko/51.0 Firefox/51.0 (.NET CLR 3.5.30729)"
export EDITOR=vim
export LYNX_CFG=~/.lynx/lynx.cfg
export WWW_HOME=https://duckduckgo.com/

# Исправит опечатки при переходе в каладог cd /etc/sambba перейдет в /etc/samba
shopt -s cdspell

export PAGER=/usr/bin/less

#set -o vi
#bind "\C-o":operate-and-get-next
export MANPATH=$HOME/.man:/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/X11R6/man:/opt/man

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
