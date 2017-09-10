[[ $- != *i* ]] && return

# if [ -f ~/.extend.bashrc ]; then
#     source ~/.extend.bashrc
# fi

# Enable auto-cd feature
shopt -s autocd

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

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

    PS1="${EMM}[${EMY}\$(date +%k:%M) ${EMR}:: ${EMG}\u${EMB}@\h ${EMR}:: ${EMC}\w${EMM}]${RESET}\n${EMM}λ:${RESET} "
}

my_bash_prompt
unset my_bash_prompt


if [ -r /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# added by Miniconda3 4.3.21 installer
export PATH="/home/magnaron/miniconda3/bin:$PATH"

# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi

export VISUAL='subl --wait'

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# add <command-not-found> script from 'pkgfile' package
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ] ; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi

# enable bash completion for 'conda'
# eval "$(register-python-argcomplete conda)"
