[[ -f ~/.extend.bash_profile ]] && . ~/.extend.bash_profile
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# hub alias (`git`)
if hash hub &> /dev/null; then
    eval "$(hub alias -s)"
fi

# thefuck alias
if hash thefuck &> /dev/null; then
    eval "$(thefuck --alias)"
fi

export PATH="$HOME/.poetry/bin:$PATH"
