# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

GIT_PS1_SHOWDIRTYSTATE=true
source ~/.git-prompt.sh
source ~/.git-completion.sh
export PS1="\u@\h \[\033[1;30m\]\$(__git_ps1) \[\033[0;0m\]\w \n>" 
#              \[\033[1;34m\] Start color dark grey.
#                                          \[\033[0;0m\] Stop color.

alias ll='ls -lh --color=auto'

alias cdycm='cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm'

# jeffery: enable scl repository
source /opt/rh/devtoolset-3/enable
#source /opt/rh/python27/enable

# jeffery: use vimx which has clipboard enabled
if [ -e /usr/bin/vimx ]; then alias vim='/usr/bin/vimx' vi='/usr/bin/vimx'; fi

# jeffery: history command's timestamp
export HISTTIMEFORMAT="%F %T "

export NCURSES_NO_UTF8_ACS=1

# jeffery: for chef setup
export EDITOR=$(which vi)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# jeffery: FZF - enable hidden files search by default
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g ""'

