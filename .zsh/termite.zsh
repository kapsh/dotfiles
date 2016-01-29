# Workaround for using termite with old systems

if [[ "$TERM" == "xterm-termite" ]]; then
	export TERM="xterm"
fi
