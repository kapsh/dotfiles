# Based on https://github.com/ael-code/zsh-colored-man-pages

# termcap
# ke       make the keypad send digits
# ks       make the keypad send commands
# mb       start blink
# md       start bold
# me       turn off bold, blink and underline
# se       stop standout
# so       start standout (reverse video)
# ue       stop underline
# us       start underline
# vb       emit visual bell

man() {
    command env \
        LESS_TERMCAP_mb=$'\e[1;34m' \
        LESS_TERMCAP_md=$'\e[1;34m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;43;30m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
        PAGER="${commands[less]:-$PAGER}" \
        man "$@"
}
