## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## tar-and-compress
function targz() {
    tar cf - $1 | gzip -9 - > "compressed_${1%.*}.tar.gz"
}

## tar-and-compress in parallel
function targzp() {
    tar -c --use-compression-command='pigz -p 16 --best' -f "compressed_${1%.*}.tar.gz" $1
}

## which
which () {
    (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}

## clear aliases
alias cls=clear
alias clr=' echo -ne "\033c"'

## some more ls aliases
alias ll='ls -alGh'
alias la='ls -A'
alias l='ls -CF'

## Make Bash error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'

## Modified commands
alias diff='colordiff'
alias df='df -h'
alias free='free -m'
alias more=less
alias du='du -ch'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias nano='nano -w'
alias R='R --no-save --no-restore'

## New commands
alias dus='du -sh * | sort -h'
alias hist='history | less'
alias da='date "+%A, %B %d, %Y [%T]"'
# alias ..='cd ..'
alias ping8='ping 8.8.8.8'

## Safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'  # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# thefuck alias
eval $(thefuck --alias)

# Noice is Not Noice alias
alias n=nnn

# colored cat (!! use \cat to get default behaviour)
alias cat=ccat
