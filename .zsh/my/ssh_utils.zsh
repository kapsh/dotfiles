
ssh-retry() {
    : "${@:?args required}"

    local timeout="3s"
    while ! command ssh "$@"; do
        echo "Retrying in ${timeout}..." >&2
        sleep "${timeout}"
    done
}

tssh() {
    : "${@:?args required}"

    ssh-retry -t "${@}" \
        "tmux -u new -A -s ssh-${USER}"
}

alias ssh=ssh-retry

# TODO completion does not work
compdef _ssh ssh-retry=ssh tssh=ssh

