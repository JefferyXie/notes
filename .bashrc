# .bashrc

alias mnspace='sudo mount -t vboxsf -o uid=0,gid=981,umask=007,fmode=660 Space /media/sf_space'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

THEIP=$(hostname --all-ip-addresses | awk '{print $1;}')
REALUSER=$(who am i | awk '{print $1;}')
GIT_PS1_SHOWDIRTYSTATE=true
# source these 2 files if you don't wanna put them in /etc/profile.d
source ~/.git-prompt.sh
source ~/.git-completion.sh
export PS1="\[\033[01;32m\]$REALUSER\[\033[00m\]@\h [$THEIP]\[\033[1;30m\]\$(__git_ps1) \[\033[0;0m\]\w \n>" 
#export PS1="\[\033[01;32m\]\u\[\033[00m\]@\h [$THEIP]\[\033[1;30m\]\$(__git_ps1) \[\033[0;0m\]\w \n>" 
#              \[\033[1;34m\] Start color dark grey.
#                                          \[\033[0;0m\] Stop color.

alias ll='ls -lh --color=auto'

alias cdycm='cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm'

# jeffery: enable scl repository
#source /opt/rh/devtoolset-3/enable

# jeffery: use vimx which has clipboard enabled
if [ -e /usr/bin/vimx ]; then alias vim='/usr/bin/vimx' vi='/usr/bin/vimx'; fi
# Or, use compiled vim in my home directory
#alias vim='/home/jxie/.local/bin/vim' vi='/home/jxie/.local/bin/vim'

# jeffery: history command's timestamp
export HISTTIMEFORMAT="%F %T "

export NCURSES_NO_UTF8_ACS=1

# jeffery: for chef setup
export EDITOR=$(which vi)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# jeffery: FZF - enable hidden files search by default
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g ""'

# to update tmux's pane title with latest command
# http://stackoverflow.com/questions/14356857/how-to-show-current-command-in-tmux-pane-title
case ${TERM} in
    screen*)
        # user command to change default pane title on demand
        function title { TMUX_PANE_TITLE="$*"; }

        # function that performs the title update (invoked as PROMPT_COMMAND)
        function update_title { printf "\033]2;%s\033\\" "${1:-$TMUX_PANE_TITLE}"; }

        # default pane title is the name of the current process (i.e. 'bash')
        TMUX_PANE_TITLE=$(ps -o comm $$ | tail -1)

        # Reset title to the default before displaying the command prompt
        PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'update_title'

        # Update title before executing a command: set it to the command
        trap 'update_title "$BASH_COMMAND"' DEBUG
        ;;
esac

