################################################################
# Zsh initialisation
################################################################

operating_system=$(uname --operating-system 2>/dev/null || uname)


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

## Keyboard mapping

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

bindkey "^[;3C" forward-word
bindkey "^[;3D" backward-word

#
# Mapping for Mac OS X iterm2
#

# Alt-Backspace mapping
bindkey "^[d" backward-kill-word

# Alt-arrows mapping
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# Cmd-backspace mapping
bindkey "^[^H" backward-kill-line


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


################################################################
# Plugin loading through zgen
################################################################

### Added by Zplugin's installer
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# plugins
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet OMZ::plugins/pip/pip.plugin.zsh
zplugin snippet OMZ::plugins/history/history.plugin.zsh
zplugin snippet OMZ::plugins/fasd/fasd.plugin.zsh
zplugin snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
zplugin light "zsh-users/zsh-completions"
zplugin light "zsh-users/zsh-autosuggestions"
zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light "zsh-users/zsh-syntax-highlighting"
zplugin load "mafredri/zsh-async"

zplugin ice pick"async.zsh" src"pure.zsh";
zplugin light sindresorhus/pure

if [[ "${operating_system}" == "Darwin" ]]; then
  # zplugin light "yannrouillard/bullet-train-oh-my-zsh-theme"

  # Use Gnu tools instead of BSD ones for standard commands
  PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:$PATH"
fi