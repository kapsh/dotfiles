# My aliases

alias L=less
alias H=head
alias T=tail
alias S=sort

_my_ls=(ls --color -C -v -p --group-directories-first)
alias ls="${_my_ls[*]}"
alias ll="${_my_ls[*]} -lh"
compdef _ls ll
unset _my_ls

alias md='nocorrect mkdir -pv'

mkcd() {
    md "$1" && cd "$1"
}

cdls() {
    cd "$1" && ls
}

# TODO fix completion here
compdef _cd cdls
compdef _mkdir md mkcd

alias cp='cp -a'

alias -g ...='../..'
alias -g ....='../../..'

alias rm='rm -Ir'
alias scp='scp -r -o Compression=no'

alias free='free -th'
alias du='du -hsc'
alias dfh='df -h -l -x tmpfs -x devtmpfs -x efivarfs'

(( $+commands[colordiff] )) && alias diff=colordiff
(( $+commands[pinfo] )) && alias info=pinfo
(( $+commands[prettyping] )) && alias pping='prettyping --nolegend'

alias grep='grep -T --color=auto --exclude-dir=.git'

nohup() {
    command nohup >/dev/null "$@" &
}

# Hide window icons from output
alias xprop='xprop -len 1000'

# Keep this last so that grc can override existing aliases.
grc_aliases="/etc/grc/grc.zsh"
if [[ -f "${grc_aliases}" ]]; then
    source "${grc_aliases}"
    alias ll="grc ${MY_LL}"
fi
unset grc_aliases

unset MY_LS MY_LL

ts2date() {
    local ts="${1:?}"
    date -d "@${ts::10}"
}

clean_escape_codes() {
    sed -E "s|\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]||g" "$@"
}

view_tsv() {
    column -t -s "	" "$@"
}

copypath() {
    realpath "$@" | tr -d "\n" | clipcopy
}
