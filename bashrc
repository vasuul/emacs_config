
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#export PATH=$PATH:$HOME/fenixOS/bin/bin:$HOME/bochs/internal-debugger/bin
export PATH=$PATH:$HOME/bin

export PAGER=less
export EDITOR=emacs

alias more=less
alias ls="ls --color"

if [ "$TERM" == xterm-color ]; then
    export TERM=xterm
fi

if [ "$TERM" == cygwin ]; then
    export TERM=xterm
fi

# Make ATK be quiet about the accessibility bus
export NO_AT_BRIDGE=1


#  Original prompt that had the time in it.  Figure I dont reall need hte time
#PS1="\[\033[01;33m\][\[\033[01;31m\]\t \[\033[01;36m\]\u@\h:\[\033[01;35m\]\w\[\033[01;33m\]]\[\033[01;32m\]\n\!>\[\033[00m\]"
PS1="\[\033[01;33m\][\[\033[01;36m\]\u@\h:\[\033[01;35m\]\w\[\033[01;33m\]]\[\033[01;32m\]\n\!>\[\033[00m\]"

# User specific aliases and functions
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig/


