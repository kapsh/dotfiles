
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



