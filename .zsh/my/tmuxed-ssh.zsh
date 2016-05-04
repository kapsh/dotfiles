
# If inside SSH session and not already inside tmux
if [[ -n "$SSH_CLIENT" && -z "$TMUX" ]]; then
    if [[ -x "`which tmux`" ]]; then
        # Start new session or attach to existing
        tmux new -s 'ssh-client' -A
    fi
fi

