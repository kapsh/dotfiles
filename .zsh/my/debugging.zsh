
# Improve 'set -x' mode for scripts
# http://wiki.bash-hackers.org/scripting/debuggingtips#making_xtrace_more_useful
export PS4='[$(basename ${BASH_SOURCE}):${LINENO}] ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
