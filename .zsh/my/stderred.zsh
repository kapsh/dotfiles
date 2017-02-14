
lib_path="/usr/local/lib64/libstderred.so"

if [[ -x "${lib_path}" ]]; then

    export LD_PRELOAD="${lib_path}${LD_PRELOAD:+:$LD_PRELOAD}"

    bold=$(tput bold || tput md)
    italic=$(tput sitm || tput ZH)
    red=$(tput setaf 1)
    export STDERRED_ESC_CODE=$(echo -e $red)
    unset bold red italic

    export STDERRED_BLACKLIST="^(screen|wget|bash|sh|python.*|test.*)$"

fi
