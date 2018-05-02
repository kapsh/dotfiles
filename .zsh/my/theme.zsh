# Tune and load theme

if [[ "$TERM" == "linux" ]]; then
    # Consider primitive fonts in tty.
    PURE_PROMPT_SYMBOL=">"
fi
PURE_CMD_MAX_EXEC_TIME=30

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure
