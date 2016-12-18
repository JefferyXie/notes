# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

THEIP=$(hostname --all-ip-addresses | awk '{print $1;}')
GIT_PS1_SHOWDIRTYSTATE=true
# don't need to source since these 2 files are in /etc/profile.d
#source git-prompt.sh
#source git-completion.sh
export PS1="\[\033[01;32m\]\u\[\033[00m\]@\h [$THEIP]\[\033[1;30m\]\$(__git_ps1) \[\033[0;0m\]\w \n>" 
#              \[\033[1;34m\] Start color dark grey.
#                                          \[\033[0;0m\] Stop color.

alias ll='ls -lh --color=auto'

alias dmake='make -rR -j8 --quiet -C/home/jexie/work/debesys show_progress=1'
alias deb='cd /home/jexie/work/debesys'
alias hsm='(cd /home/jexie/work/HsmProxy/bin; ./start.sh ../etc/hsmproxy.properties > /dev/null 2>&1)&'

alias algoconfig='cd /home/jexie/work/debesys/build/x86-64/debug/etc/algo_local/'
alias algoconfigrel='cd /home/jexie/work/debesys/build/x86-64/release/etc/algo_local/'
alias algodebug='cd /home/jexie/work/debesys/build/x86-64/debug/'
alias algolog='cd /home/jexie/work/debesys/build/x86-64/debug/var/log/algo_local/'
alias algologrel='cd /home/jexie/work/debesys/build/x86-64/release/var/log/'
alias algolib='cd /home/jexie/work/debesys/build/x86-64/debug/lib/'
alias algolibrel='cd /home/jexie/work/debesys/build/x86-64/release/lib/'
alias cdalgo='cd /home/jexie/work/debesys/algo/'
alias cdtools='cd /home/jexie/work/debesys/algo/tools/'
alias cdsdk='cd /home/jexie/work/debesys/algo/ttsdk'
alias vialgo='cdalgo; vi'
alias palgo='ps aux | grep algo'
alias phsm='ps aux | grep hsm'
alias ralgo='drun algoserver_exec'

alias cdycm='cd /home/jexie/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm'
alias uconfig-sim='(algoconfig; cp /home/jexie/work/config_backup/algo_local_int_dev_sim/* .)'
alias uconfig-cert='(algoconfig; cp /home/jexie/work/config_backup/algo_local_int_dev_cert/* .)'

export PATH=/home/jexie/work/debesys/the_arsenal/tools/bin/linux:$PATH

# enable scl repository
#source /opt/rh/devtoolset-3/enable
#source /opt/rh/python27/enable

# use vimx which has clipboard enabled
if [ -e /usr/bin/vimx ]; then alias vim='/usr/bin/vimx' vi='/usr/bin/vimx'; fi

export HISTTIMEFORMAT="%F %T "

export JENKINS_USER='jexie'
export JENKINS_TOKEN=71341b07ee2b71d837bd8957d58a5c10
export INTAD_USER='jexie'
export TT_EMAIL="jeffery.xie@tradingtechnologies.com"

export NCURSES_NO_UTF8_ACS=1

# jeffery: for chef setup
export EDITOR=$(which vi)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# jeffery: FZF - enable hidden files search by default
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND='ag --hidden --ignore .git -g ""'

