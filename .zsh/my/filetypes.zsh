# Suffix aliases

_browser='google-chrome'
_office='soffice'

alias -s {txt, log}=less
alias -s {md}=mdless
alias -s {doc, docx, odt}="$_office"
alias -s {xls, xlsx, ods}="$_office"
alias -s {pdf, html, htm}="$_browser"

unset _browser _office
