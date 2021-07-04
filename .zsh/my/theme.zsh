# Tune and load theme

# Settings for `pure` prompt
if [[ "$TERM" == "linux" ]]; then
    # simpler arrow for tty
    PURE_PROMPT_SYMBOL=">"
fi
PURE_CMD_MAX_EXEC_TIME=10
zstyle :prompt:pure:prompt:success color cyan
zstyle :prompt:pure:execution_time color 218
zstyle :prompt:pure:git:arrow color green
zstyle :prompt:pure:git:branch color yellow
zstyle :prompt:pure:git:dirty color red

# Load `pure` prompt
zplugin ice pick "async.zsh" src "pure.zsh"
zplugin light sindresorhus/pure
