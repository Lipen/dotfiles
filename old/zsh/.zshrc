# zmodload zsh/zprof

export ZSH=$HOME/.oh-my-zsh

# emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# # Setup direnv
# emulate zsh -c "$(direnv hook zsh)"

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
    fzf-fasd
    fzf-tab
    git
    gitfast
    github
    history
    man
    nix-shell
    poetry
    sudo
    virtualenv
    you-should-use
    # zsh-autocomplete
    zsh-completions
    zsh-interactive-cd
    zsh_reload
    # some say that these two must be last
    fast-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

## User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin:$HOME/.poetry/bin:$HOME/.cargo/bin
export MANPATH="/usr/local/man:$MANPATH"
export LESS="-F -X $LESS"
export YSU_MESSAGE_POSITION="after"
export EDITOR=subl
export VISUAL=subl

include () {
    [[ -f "$1" ]] && source "$1"
}

# Setup dircolors
if command -v dircolors &> /dev/null; then
    [[ -f ~/.dir_colors ]] && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
fi

# Setup fzf
export FZF_DEFAULT_OPTS="
    --prompt='> '
    --pointer='▶'
    --marker='✓'
    --height=80%
    --layout=reverse
    --preview-window ':hidden'
    --bind 'ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
    --bind 'ctrl-e:execute(echo {+} | xargs subl)'
    --bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
    --bind '?:toggle-preview'
"
export FZF_CTRL_R_OPTS="
    --exit-0
    --preview 'echo {}'
    --preview-window 'down:3:wrap:hidden'
"
export FZF_CTRL_T_OPTS="
    --exit-0
    --preview
        'if [ -d {} ]; then
            tree -C --dirsfirst {} | less;
        elif [ -f {} ]; then
            case {} in
                *.gz | *.tgz | *.zip | *.tar | *.jar | *.rar )
                    als {} || file {} ;;
                *)
                    bat --color=always --wrap=character --terminal-width=\$(bc <<< "\$COLUMNS*0.7/1-4") {} || cat {} ;;
            esac ;
        else
            file {};
        fi'
    --preview-window 'right:70%:wrap:hidden'
"
export FZF_ALT_C_OPTS="
    --exit-0
    --preview 'tree -C --dirsfirst -L 1 {} | less'
    --preview-window 'right:70%:hidden'
"
export FZF_FASD_OPTS="--prompt='fasd_cd> '"
export FZF_DEFAULT_COMMAND='fd --type f'

# Use fd for listing path candidates
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Fuzzy-find in history and run
fzf-history-widget-accept() {
    fzf-history-widget
    zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# fasd+fzf
unalias z
unset z
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

# fzf file fuzzy-search
# bindkey '^ ' fzf-file-widget

# fzf-tab: Disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false

# fzf-tab: Use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input

# fzf-tab: Some boilerplate code to define the variable `extract` which will be used later
local extract="
# trim input(what you select)
local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# get ctxt for current completion(some thing before or after the current word)
local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# real path
local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
realpath=\${(Qe)~realpath}
"

# fzf-tab: Give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap

# fzf-tab: Give a preview of directory by `exa` when completing `cd`
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'

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

# Setup nnn plugins
if [ -d "$HOME/.config/nnn/plugins" ]; then
    export PATH="$PATH:$HOME/.config/nnn/plugins"
    # export NNN_OPENER=nuke
    export NNN_PLUG='f:finder;z:fzopen;t:treeview;c:fzcd;j:autojump;p:-_less -iR -+F $nnn*'
fi

# Setup Nix
if [ -e /home/azuregos/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/azuregos/.nix-profile/etc/profile.d/nix.sh
fi

# Setup home-manager
# if [ -d $HOME/.nix-defexpr/channels ]; then
#     export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
# fi


# Source aliases (better to do it after all setup)
include ~/.aliases

# Disable beep
unsetopt BEEP


# zprof
