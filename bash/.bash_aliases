## ls dircolors
if hash dircolors &> /dev/null; then
    [[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

## tar-and-compress
function targz() {
    tar cf - $1 | gzip -9 - > "compressed_${1%.*}.tar.gz"
}

## tar-and-compress in parallel
if hash pigz &>/dev/null; then
    function targzp() {
        tar -c --use-compression-command='pigz -p 16 --best' -f "compressed_${1%.*}.tar.gz" $1
    }
fi

## pretty which alias
which () {
    (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}

## clear aliases
alias cls='clear'
alias clr=' echo -ne "\033c"'

## ls aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -alGh'
alias la='ls -A'
alias l='ls -CF'

## Make Bash error tolerant
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'

## Modified commands
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less -R'
alias diff='colordiff'
alias df='df -h'
alias free='free -m'
alias more=less
alias du='du -h --max-depth=1 --apparent-size 2>/dev/null'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias nano='nano -w'
alias R='R --no-save --no-restore'

## New commands
alias dus='du | sort -h'
alias dusl='du | sort -rh | less'
alias hist='history | less'
alias da='date "+%A, %B %d, %Y [%T]"'
alias ping8='ping 8.8.8.8'
alias ping1='ping 1.1.1.1'
# alias ..='cd ..'

## Safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'  # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

## Noice is Not Noice alias
if hash nnn &> /dev/null; then
    alias n='nnn'
fi

## colored cat alias (!! use \cat to get default behaviour)
if hash ccat &> /dev/null; then
    alias cat='ccat -G Plaintext="white" -G Punctuation="darkteal" -G Keyword="fuscia" -G Decimal="blue" -G Type="blue" -G Comment="darkgrey"'
fi

## ranger with autocd to visited location alias
if hash ranger &> /dev/null; then
    function ranger-cd {
        tempfile="$(mktemp -t tmp.XXXXXX)"
        ranger --choosedir="$tempfile" "${@:-$(pwd)}"
        test -f "$tempfile" &&
        if [ "$(\cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
            cd -- "$(\cat "$tempfile")"
        fi
        rm -f -- "$tempfile"
    }
    alias r='ranger-cd'
fi

## highlight and show via less
if hash highlight &> /dev/null; then
    function hl {
        highlight -O xterm256 $* | \less -R
    }
fi

## goto config
function z {
    cd ~/.config/"$1"
}

## gradlew alias (https://github.com/dougborg/gdub)
if hash gw &> /dev/null; then
    alias gradle='gw'
fi

## hub alias (https://github.com/github/hub)
if hash hub &> /dev/null; then
    alias git='hub'
fi
