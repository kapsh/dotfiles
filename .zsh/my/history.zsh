# History keeping options

HISTFILE="${ZDOTDIR}/.histfile"
HISTSIZE=10000
SAVEHIST=1000

# Never save to history these commands
HISTORY_IGNORE="(ls|ll|cd)"

# Save timestamps
setopt extended_history

# replace older commands if duplicated
setopt hist_ignore_all_dups

# synchronize history in different shells
setopt share_history

