
export LD_PRELOAD="/usr/local/lib64/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"

bold=$(tput bold || tput md)
italic=$(tput sitm || tput ZH)
red=$(tput setaf 1)
export STDERRED_ESC_CODE=$(echo -e $italic$red)
unset bold red italic

export STDERRED_BLACKLIST="^(wget|bash|test.*)$"
