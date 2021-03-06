################################################################
# Useful functions
################################################################

function guess_os () {
  [[ ! -f "/etc/debian_version" ]] || { echo "debian"; return; }
  [[ ! "$(uname)" == "Darwin" ]] || { echo "darwin"; return; }
  echo "unknown"
}

function binary_exist () {
  local binary="$1"
  command -v "${binary}" &>/dev/null || return 1
}

################################################################
# Zsh initialisation
################################################################

operating_system=$(guess_os)
os_zshrc=".zshrc.${operating_system}"

! [[ -f "${os_zshrc}" ]] || source "${os_zshrc}"


################################################################
# Configuration
################################################################

## Terminal configuration
export TERM=xterm-256color
alias ls="ls --color"

## Shell configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000000000000000000
SAVEHIST=${HISTSIZE}
setopt inc_append_history
setopt share_history
setopt HIST_FIND_NO_DUPS

## Keyboard mapping

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

bindkey "^[;3C" forward-word
bindkey "^[;3D" backward-word

#
# Bash-like behavior
#

# Ctrl-U kill to current cursor instead of killing whole line
bindkey \^U backward-kill-line

# Split words on path delimieter by redefining WORDCHARS without '/'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Fast Directory jumping
[[ ! -f "${Z_LOCATION}" ]] || source "${Z_LOCATION}"

#
# FZF configuration
#

[[ ! -f "${FZF_ZSH_KEYBINDINGS}" ]] || source "${FZF_ZSH_KEYBINDINGS}"

export FZF_CTRL_R_OPTS='--height 80%'

if binary_exist "${FD_BINARY}"; then
  _fzf_compgen_path() {
    "${FD_BINARY}" --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    "${FD_BINARY}" --type d --hidden --follow --exclude ".git" . "$1"
  }
fi


#
# Git configuration
#
for candidate in diff-so-fancy colordiff cat; do
  if binary_exist "${candidate}"; then
    GIT_PAGER="${candidate} | less --tabs=4 -RFX"
    break
  fi
done
export GIT_PAGER


! binary_exist "exa" || alias ls=exa

alias l="ls"
alias ll="ls -l"

! binary_exist "bat" || alias cat=bat


## Theme configuration

# Powerline
BULLETTRAIN_PROMPT_SEGMENTS_ORDER=(time rvm virtualenv nvm context dir git bg_jobs status)

BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_SHOW_PROMPT_CHAR=false

BULLETTRAIN_DIR_BG="240"             # gray4
BULLETTRAIN_DIR_FG="250"             # gray9
BULLETTRAIN_DIR_CUR_FOLDER_FG="252"  # gray10
BULLETTRAIN_DIR_POWERLINE_STYLE=true

BULLETTRAIN_GIT_BG="236"             # gray2
BULLETTRAIN_GIT_FG="250"             # gray9

BULLETTRAIN_STATUS_ERROR_BG="52"     # darkestred
BULLETTRAIN_STATUS_FG="231"          # white
BULLETTRAIN_STATUS_EXIT_SHOW=true

BULLETTRAIN_BG_JOBS_FG="220"         # brightyellow
BULLETTRAIN_BG_JOBS_BG="166"         # mediumorange

BULLETTRAIN_CONTEXT_SHOW="true"
BULLETTRAIN_CONTEXT_BG="31"          # darkblue
BULLETTRAIN_CONTEXT_FG="231"         # white

BULLETTRAIN_IS_SSH_CLIENT=${SSH_CONNECTION+true}

# Pure
PURE_GIT_UNTRACKED_DIRTY=0
PURE_GIT_PULL=0
PURE_PROMPT_SYMBOL=">"

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'

[[ ! -f "${HOME}/.zshrc.local" ]] || source "${HOME}/.zshrc.local"

export ZSH_CACHE_DIR="${HOME}/.zsh-cache/"

################################################################
# Plugin loading through zgen
################################################################

source ~/.zplugin/bin/zplugin.zsh

fasd_cache="$HOME/.fasd-init-cache"

# plugins
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light "zsh-users/zsh-autosuggestions"
zplugin snippet OMZ::plugins/fasd/fasd.plugin.zsh

zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh

zplugin light "zsh-users/zsh-completions"

zplugin load "mafredri/zsh-async"
zplugin ice pick"async.zsh" src"pure.zsh";
zplugin light sindresorhus/pure

autoload -Uz compinit
compinit

zplugin cdreplay -q

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
