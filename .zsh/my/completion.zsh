
# Better completion for killall
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $(whoami)|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false

# Completions for cave wrappers
compdef _cave_cmd_search cave-search
compdef _cave_cmd_resume cave-resume
compdef _cave_cmd_resolve cave-resolve
compdef _cave_cmd_resolve cave-remove
compdef _cave_cmd_resolve cave-purge
compdef _cave_cmd_resolve cave-update-system
compdef _cave_cmd_resolve cave-update-world
compdef _cave_cmd_fix-linkage cave-fix-linkage
# Workaround: break lazy loading of subcommands
autoload +XUz _cave
_cave 2>/dev/null
