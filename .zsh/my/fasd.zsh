
local fasd_cache="${ZSH_CACHE_DIR}/fasd-init"

if (( $+commands[fasd] )); then
    if ! [[ -e "${fasd_cache}" ]]; then
        fasd --init auto > "${fasd_cache}"
    fi
    source "${fasd_cache}"
    bindkey '^X^F' fasd-complete
fi

