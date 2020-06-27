# zmodload zsh/zprof

export ZSH=$HOME/.oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## ZSH configuration

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

plugins=(
    asdf
    autoupdate
    colored-man-pages
    conda-zsh-completion
    copybuffer
    copydir
    copyfile
    cp
    fasd
    fzf
    git
    gitfast
    github
    history
    man
    poetry
    sudo
    virtualenv
    you-should-use
    # zsh-autocomplete
    zsh-completions
    zsh_reload
    # some say that these two must be last
    fast-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

## User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin:$HOME/.poetry/bin
export MANPATH="/usr/local/man:$MANPATH"
export LESS="-F -X $LESS"
export YSU_MESSAGE_POSITION="after"

include () {
    [[ -f "$1" ]] && source "$1"
}

# Source aliases
include ~/.aliases

# Setup dircolors
if command -v dircolors &> /dev/null; then
    [[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

# fzf file fuzzy-search
bindkey '^ ' fzf-file-widget

# Push current command
bindkey '^q' push-line-or-edit

# Setup Miniconda
if [ -d "$HOME/miniconda3" ]; then
    source ~/miniconda3/etc/profile.d/conda.sh
    conda activate base
else
    echo 'miniconda not found!'
fi

# Setup conda completion (see https://github.com/esc/conda-zsh-completion)
zstyle ':completion::complete:*' use-cache 1
zstyle ":conda_zsh_completion:*" use-groups true

# Makefile autocompletion (See https://github.com/zsh-users/zsh-completions/issues/541)
# zstyle ':completion:*:make:*:targets' call-command true # outputs all possible results for make targets
# zstyle ':completion:*:make:*' tag-order targets
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format '%B%d%b'

# Setup zsh-autocomplete
# zstyle ':autocomplete:*' groups 'always'
# zstyle ':autocomplete:tab:*' completion 'select'
# zstyle ':autocomplete:(slash|space):*' magic 'off'

# # Setup pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#     eval "$(pyenv init -)"
#     eval "$(pyenv virtualenv-init -)"
# fi

# Setup thefuck
eval $(thefuck --alias)

# Disable beep
unsetopt BEEP


# zprof
