# Changing/making/removing directory

unalias md
unalias mkdir
alias mkdir='nocorrect mkdir -p -v'
alias md='mkdir'
alias d='dirs -v | head -10'


# mkdir & cd to it
function mkcd() {
    if [[ -n "$1" ]]; then
        mkdir -p -v "$1" && cd "$1";
    else
        echo 'mkcd: missing name'
    fi
}

function cdls() {
    if [[ -n "$1" ]]; then
        cd "$1" && ls;
    else
        echo 'cdls: missing name'
    fi
}
