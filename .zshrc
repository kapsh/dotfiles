
# TODO try https://github.com/clvv/fasd
# TODO add grc
# TODO add git-extras

ZDOTDIR="${HOME}/.zsh"
MY_ZSH="${ZDOTDIR}/my"
ZSH_CACHE_DIR="${ZDOTDIR}/.cache"  # Used by plugins from oh-my-zsh

source "${MY_ZSH}/tmuxed-ssh.zsh"

# Common environment variables
export PATH="${HOME}/bin:${PATH}"
PYTHONSTARTUP="${HOME}/.python_startup.py"

# zplugin init
local -A ZPLGM
ZPLGM[HOME_DIR]="${ZDOTDIR}/.zplugin"
ZPLGM[BIN_DIR]="${ZPLGM[HOME_DIR]}/zplugin"
source "${ZPLGM[BIN_DIR]}/zplugin.zsh"

zplugin snippet "${MY_ZSH}/filetypes.zsh"

# Theme
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure
PURE_CMD_MAX_EXEC_TIME=60

# Should be loaded before completion list-colors
zplugin ice atclone"dircolors -b LS_COLORS > colors.zsh" atpull'%atclone' pick"colors.zsh"
zplugin light trapd00r/LS_COLORS

# TODO sort out completion and correction options

zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' expand suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+r:|[._-]=** r:|=**' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '$HOME/.zshrc'

# Use caching so that commands like apt and dpkg complete are useble
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "${ZSH_CACHE_DIR}"

autoload -Uz compinit
compinit

setopt extendedglob nomatch
unsetopt beep notify

# allow comments when interactive
setopt interactive_comments

# send CONT after disown
setopt auto_continue

# job notification with pid
setopt long_list_jobs

# required for using menuselect
zmodload -i zsh/complist
# maybe rewrite smth manyally in future
zplugin snippet OMZ::lib/key-bindings.zsh
# Pick item but stay in menu
bindkey -M menuselect "+" accept-and-menu-complete

# http://wiki.bash-hackers.org/scripting/debuggingtips#making_xtrace_more_useful
#export PS4='[$(basename ${BASH_SOURCE}):${LINENO}] ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

setopt autocd auto_pushd pushd_ignore_dups pushdminus

WORDCHARS="${WORDCHARS//[\/.]}"
autoload -U select-word-style
select-word-style normal

setopt correct_all

# insert matches immediately
setopt menu_complete

# insert full path to command after =command<tab>
setopt equals

zplugin snippet "${MY_ZSH}/aliases.zsh"
zplugin snippet "${MY_ZSH}/history.zsh"
zplugin snippet "${MY_ZSH}/plugins.zsh"

zplugin ice atinit"zpcompinit"
zplugin light zdharma/fast-syntax-highlighting

