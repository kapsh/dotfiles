
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}[⎇  %{$reset_color%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

local return_status="%{$reset_color%}(%{$fg_bold[red]%}%(?..%?)%{$reset_color%})"

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})[%n@%m] %{$fg_bold[blue]%}%~
%#%{$reset_color%} '
RPROMPT='%{$fg[$NCOLOR]%}%p $(git_prompt_info)%{$reset_color%}'

# vim: set filetype=zsh:
