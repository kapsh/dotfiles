
alias cp='nocorrect cp --interactive --recursive --preserve=all'
alias mv='nocorrect mv --verbose --interactive'

# CoPy Here
function cph() {
    cp $@ .
}

alias rm='nocorrect rm -Ir'

alias du='du --human-readable --total --summarize'
alias df='df --human-readable'
alias ddf='df -x rootfs -x cifs -x tmpfs -x aufs -x devtmpfs | grep -v loop'

alias nohup='nohup > /dev/null $1'

alias killall="killall --verbose"

# Human-readable megabytes + total line
alias free="free -t -m"

alias myip="curl ip.appspot.com"

[[ "$(whence colordiff)" ]] && alias diff='colordiff'

alias svim="vim -u ~/.svimrc"

if [[ "$ENABLE_CORRECTION" == "true" ]]; then
    alias cave='nocorrect noglob cave'
    alias cave-resolve='nocorrect noglob cave-resolve'
    alias cave-remove='nocorrect noglob cave-remove'
    alias git='nocorrect git'
fi

alias scp='scp -r'

alias play='ansible-playbook'
compdef _ansible-playbook play

function vim() {
    for (( i=0; i<5; i++ )); do
        print -P "%B%F{red}WRONG!"
    done
    sleep 1s
    command vim "$@"
}
