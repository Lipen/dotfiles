[[ $- != *i* ]] && return

if [ -f ~/.extend.bashrc ]; then
    source ~/.extend.bashrc
fi

if [ -r /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Enable auto-cd feature
shopt -s autocd

# Avoid duplicates in bash history
export HISTCONTROL=ignoredups:erasedups
# Big bash history
export HISTSIZE=100000
export HISTFILESIZE=100000
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# I don not know what is going on in this block...
xhost +local:root > /dev/null 2>&1
complete -cf sudo
shopt -s checkwinsize
shopt -s expand_aliases
# ...

my_bash_prompt () {
    local K="\[\033[0;30m\]"
    local R="\[\033[0;31m\]"
    local G="\[\033[0;32m\]"
    local Y="\[\033[0;33m\]"
    local B="\[\033[0;34m\]"
    local M="\[\033[0;35m\]"
    local C="\[\033[0;36m\]"
    local W="\[\033[0;37m\]"

    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    local RESET="\[\033[0m\]"

    local first_line="${EMM}[${EMY}\$(date +%k:%M) ${EMR}:: ${EMG}\u${EMB}@\h ${EMR}:: ${EMC}\w${EMM}]${RESET}"
    local second_line="${EMM}λ${RESET} "

    PS1="${first_line}\n${second_line}"
}

my_bash_prompt
unset my_bash_prompt

export EDITOR='less'
export VISUAL='subl --wait'

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# Noice is Not Noice :: settings
export NNN_COPIER="$HOME/dev/copier.sh"
export NNN_DE_FILE_MANAGER=nautilus

# add <command-not-found> script from 'pkgfile' package
# if [ -f /usr/share/doc/pkgfile/command-not-found.bash ] ; then
#     source /usr/share/doc/pkgfile/command-not-found.bash
# fi

# enable bash completion for 'conda'
# eval "$(register-python-argcomplete conda)"

# enable bash history append from all terminals
# export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# add Java home
# export JAVA_HOME=/usr/lib/jvm/default

# autojump
if [ -f /etc/profile.d/autojump.bash ] ; then
    source /etc/profile.d/autojump.bash
fi

# Miniconda
source ${HOME}/miniconda3/etc/profile.d/conda.sh
conda activate
