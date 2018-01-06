
################################################################
# Zsh initialisation
################################################################

operating_system=$(uname --operating-system)


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
setopt appendhistory

# Alt-Backspace mapping
bindkey "^[d" backward-kill-word
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

bindkey "^[;3C" forward-word
bindkey "^[;3D" backward-word

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

[[ ! -f "${HOME}/.zshrc.local" ]] || source "${HOME}/.zshrc.local"


################################################################
# Plugin loading through zgen
################################################################

if [[ ! -d ~/.zplug ]];then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug ~/.zplug
fi

export ZPLUG_HOME="${HOME}/.zplug"
source "$ZPLUG_HOME/init.zsh"

# plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if [[ "${operating_system}" == "Darwin" ]]; then
  zplug "plugins/brew", from:oh-my-zsh
fi

zplug "yannrouillard/bullet-train-oh-my-zsh-theme", from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
