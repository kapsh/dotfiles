# Wrappers around ssh command

alias ssh="TERM=xterm-256color ssh-retry"

ssh-retry() {
    if [[ $# == 0 ]]; then
        echo "ssh: arguments missing" >&2
        return 1
    fi

    local timeout="3s"
    while ! command ssh "$@"; do
        echo "Retrying in ${timeout}..." >&2
        sleep "${timeout}"
    done
}

tssh() {
    if [[ $# == 0 ]]; then
        echo "tssh: arguments missing" >&2
        return 1
    fi

    ssh -t "${@}" \
        "tmux new -A -s 'ssh-client'"
}

# TODO completion does not work
compdef _ssh ssh-retry=ssh tssh=ssh

