set runtimepath^=~/.vim runtimepath+=~/.vim/after runtimepath+=/usr/share/vim/vimfiles
let &packpath = &runtimepath
source ~/.vimrc

" Autocopy in selection buffer
vnoremap <LeftRelease> "*ygv

au VimLeave * set guicursor=a:block-blinkon0
