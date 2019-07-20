# History keeping options

HISTFILE="${ZDOTDIR}/.histfile"
HISTSIZE=10000
SAVEHIST=9000

# Never save to history these commands
HISTORY_IGNORE="(ls|ll|cd)"

# Save timestamps
setopt extended_history

# replace older commands if duplicated
setopt hist_ignore_all_dups

# Independent history in different shells
setopt no_share_history

# Save commands to histfile immediately
setopt inc_append_history
