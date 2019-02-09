# My aliases


MY_LS=(ls --color -C -v -p --group-directories-first)
MY_LL=(${MY_LS} -lh)
alias ls="${MY_LS}"
alias ll="${MY_LL}"
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
alias du='du -hsc'
alias df='df -h'
alias ddf='df -l -x tmpfs -x devtmpfs'

(( $+commands[nvim] )) && alias vim=nvim
(( $+commands[colordiff] )) && alias diff=colordiff
(( $+commands[pinfo] )) && alias info=pinfo
(( $+commands[prettyping] )) && alias pping='prettyping --nolegend'

alias grep='grep -T --color=auto --exclude-dir=.git'

function nohup() {
    command nohup >/dev/null "$@"
}

alias play='ansible-playbook'
compdef _ansible-playbook play

# {{{ Exherbo specific

# Correction for these commands doesn't make sense
alias eclectic='nocorrect eclectic'
alias cave='nocorrect noglob cave'

alias mscan='mscan2.rb -i system -l unused'

# }}}

# Stupid terminfo workaround
alias ssh='TERM=xterm-256color ssh'

# Hide window icons from output
alias xprop='xprop -len 1000'

# Wildcards should be passed to these programs literaly
alias locate='noglob locate'
alias find='noglob find'

# Keep this last so that grc can override existing aliases.
grc_aliases="/etc/grc/grc.zsh"
if [[ -f "${grc_aliases}" ]]; then
    source "${grc_aliases}"
    alias ll="grc ${MY_LL}"
fi
unset grc_aliases

unset MY_LS MY_LL

ts2date() {
    date -d "@$1"
}

clean_escape_codes() {
    sed -E "s|\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]||g" "$@"
}

