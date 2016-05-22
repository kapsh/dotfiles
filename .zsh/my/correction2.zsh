if [[ "$ENABLE_CORRECTION" == "true" ]]; then
    alias cave='nocorrect noglob cave'
    alias cave-resolve='nocorrect noglob cave-resolve'
    compdef cave-resolve=cave
    alias cave-remove='nocorrect noglob cave-remove'
    compdef cave-purge=cave
    alias git='nocorrect git'
fi

