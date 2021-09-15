## Setup fzf.
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

# fzf: Use fd for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# fzf: Use fd to generate the list for directory completion.
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fzf: Fuzzy-find in history and run.
fzf-history-widget-accept() {
    fzf-history-widget
    zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept


## fasd+fzf
# unalias z
# unset z
z() {
    [ $# -gt 0 ] && fasd_cd -d "$*" && return
    local dir
    dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}


## fzf-tab: Give a preview of directory by `exa` when completing `cd`
zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always $realpath'
