export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"

## Powerlevel9k configuration

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs status command_execution_time load time)

# 193 = darkseagreen1a

# prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\u03BB%f "

# context
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='blue'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND='red'
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND='black'
POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND='red'
POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND='black'
# dir
POWERLEVEL9K_DIR_PATH_SEPARATOR=" \uE0B1 "
typeset POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,DEFAULT,ETC}_FOREGROUND='black'
typeset POWERLEVEL9K_DIR_{HOME,HOME_SUBFOLDER,DEFAULT,ETC}_BACKGROUND='blue'
# dir_writable
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='white'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='red'
# vcs
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='193'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'

# background_jobs
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='yellow'
# status
POWERLEVEL9K_STATUS_OK_FOREGROUND='green'
POWERLEVEL9K_STATUS_OK_BACKGROUND='black'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='yellow'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='red'
# command_execution_time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='white'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
# load
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND='white'  # green
POWERLEVEL9K_LOAD_WARNING_FOREGROUND='yellow'
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND='red'
typeset POWERLEVEL9K_LOAD_{NORMAL,WARNING,CRITICAL}_BACKGROUND='black'
# time
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_TIME_FOREGROUND='white'
POWERLEVEL9K_TIME_BACKGROUND='black'

## ZSH configuration

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

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
    git
    gitfast
    github
    fasd
    cp
    copyfile
    copydir
    copybuffer
    history
    colored-man-pages
    man
    sudo
    zsh_reload
    you-should-use
    # some say that these two must be last
    fast-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

## User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH="/usr/local/man:$MANPATH"
export LESS="-F -X $LESS"
export YSU_MESSAGE_POSITION="after"

include () {
    [[ -f "$1" ]] && source "$1"
}

# Source aliases
include ~/.aliases

# Setup dircolors
if hash dircolors &> /dev/null; then
    [[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

# Bind ctrl+space to accept auto-completion
bindkey '^ ' autosuggest-accept

# Push current command
bindkey '^Q' push-input

# Setup Miniconda
if [ -d "$HOME/miniconda3" ]; then
    source ~/miniconda3/etc/profile.d/conda.sh
    conda activate base

    # Enable conda completion (see https://github.com/esc/conda-zsh-completion)
    fpath+=$ZSH_CUSTOM/stuff/conda-zsh-completion
    compinit
    zstyle ':completion::complete:*' use-cache 1
    zstyle ":conda_zsh_completion:*" use-groups true
else
    echo 'miniconda not found!'
fi
