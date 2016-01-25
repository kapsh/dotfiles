ZSH_THEME_GIT_PROMPT_PREFIX="(git: "
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT='%{$reset_color%} ${return_status}'

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})[%n@%m] %{$fg_bold[blue]%}%~
%#%{$reset_color%} '
#PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})[%n] %{$fg_bold[blue]%}%~ %#%{$reset_color%} '
RPROMPT='%{$fg[$NCOLOR]%}%p $(git_prompt_info)%{$reset_color%}'

# vim: set filetype=zsh:
