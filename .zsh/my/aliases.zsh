# My aliases

alias ls='ls --color=auto -v -p --group-directories-first '
alias ll='ls -lh'
compdef _ls ll

alias md='nocorrect mkdir -pv'

function mkcd() {
    md "$1" && cd "$1"
}

function cdls() {
    cd "$1" && ls
}

# TODO fix completion here
compdef _cd cdls
compdef _mkdir md mkcd

alias cp='cp -a'

function cph() {
    cp "$@" .
}

alias -g ...='../..'
alias -g ....='../../..'

alias rm='rm -Ir'
alias scp='scp -r'

alias free='free -th'
alias du='du -hst'
alias df='df -h'
alias ddf='df -l -x tmpfs -x devtmpfs'

(( $+commands[nvim] )) && alias vim=nvim
(( $+commands[colordiff] )) && alias diff=colordiff

alias grep='grep --color=auto --exclude-dir={.git}'

function nohup() {
    command nohup >/dev/null "$@"
}

alias play='ansible-playbook'
compdef _ansible-playbook play

# Correction for these commands doesn't make sense
alias eclectic='nocorrect eclectic'
alias cave='nocorrect noglob cave'

