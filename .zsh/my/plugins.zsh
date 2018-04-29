# Third-party plugins

# Cherry-pick some part from oh-my-zsh
function lazy_omz() {
    snippet="${1:?location expected}"
    zplugin ice wait"0" silent "$@[2,-1]"
    zplugin snippet OMZ::"$snippet"
}

function lazy_plugin() {
    plugin="${1:?location expected}"
    zplugin ice wait"0" silent "$@[2,-1]"
    zplugin light "${plugin}"
}

# Bring back background job with ^Z
lazy_omz plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh

#  completion for pip
lazy_omz plugins/pip/pip.plugin.zsh
lazy_omz plugins/pip/_pip

# Navigate directory history with Alt+arrows
lazy_omz plugins/dirhistory/dirhistory.plugin.zsh

# Persistent directory history
dirstack_file="$ZDOTDIR/.dirstack"
lazy_omz plugins/dirpersist/dirpersist.plugin.zsh

# Shortcuts for rsync
lazy_omz plugins/rsync/rsync.plugin.zsh
lazy_omz plugins/cp/cp.plugin.zsh

# Clipboard utilities
lazy_omz lib/clipboard.zsh
lazy_omz plugins/copybuffer/copybuffer.plugin.zsh
lazy_omz plugins/copydir/copydir.plugin.zsh

# mark/jump directories
lazy_omz plugins/jump/jump.plugin.zsh

# Archive management
lazy_omz plugins/extract/extract.plugin.zsh
lazy_omz plugins/extract/_extract silent

# nmap shortcuts
lazy_omz plugins/nmap/nmap.plugin.zsh

# Other plugins

lazy_plugin RobSis/zsh-reentry-hook

lazy_plugin Tarrasch/zsh-bd

lazy_plugin ael-code/zsh-colored-man-pages

# TODO doesn't work?
lazy_plugin gangleri/pipenv

lazy_plugin hcgraf/zsh-sudo

lazy_plugin mollifier/cd-gitroot

lazy_plugin oz/safe-paste

lazy_plugin t413/zsh-background-notify

lazy_plugin zsh-users/zsh-completions

unfunction lazy_omz lazy_plugin

zplugin ice lucid wait"0" as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras
source "${ZPLGM[PLUGINS_DIR]}/tj---git-extras/etc/git-extras-completion.zsh"

