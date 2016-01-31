
if [[ "$TERM" == "xterm-termite" ]]; then
	# Workaround for using termite with old systems
	export TERM="xterm"
	# Set current dir (for opening new tab)
	. /etc/profile.d/vte.sh
	__vte_osc7

fi
