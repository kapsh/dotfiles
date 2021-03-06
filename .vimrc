scriptencoding utf-8
" ^^ Please leave the above line at the start of the file.
" vim: textwidth=100: expandtab: tabstop=4: shiftwidth=4:

"{{{ Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" My plugins

" Nice start screen
Plugin 'mhinz/vim-startify'

" Status bar
Plugin 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"}}}

"{{{ Plugin specific settings

" Airline
" Always show status bar for all windows
set laststatus=2
" Enable colors support
set t_Co=256
" Display current input language
let g:airline_detect_iminsert = 1
" Enable using of pretty symbols
let g:airline_powerline_fonts = 1
let g:airline#extensions#keymap#enabled = 0

" Startify
" Disable fortunes
let g:startify_custom_header = ''
" Increase MRU count
let g:startify_files_number = 20

"}}}

"{{{ Special directories and files
" Create backups
set backupdir=$HOME/.vim-runtime/backups
set backup
" Location for .swp files
set directory=$HOME/.vim-runtime/swaps
" Persistent undo files
set undodir=$HOME/.vim-runtime/undodir
set undofile
" viminfo location
if has('nvim')
    set shada+=n~/.vim-runtime/.shada
else
    set viminfo+=n~/.vim-runtime/.viminfo
endif
"}}}

"{{{ Opening and saving options

" File types and formats
set fileencodings=ucs-bom,utf-8,cp1251 " Try to detect this encodings
set fileformats=unix,dos,mac                " Support filetypes in this order
set endofline                               " Ensure the last line of the file has an EOL on it
set nobomb                                  " Turn off the byte order mark

" Strip trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

"}}}

"{{{ UI options

set showcmd   " Show (partial) command in status line.
set showmatch " Show matching brackets.
set hidden    " Hide buffers when they are abandoned
set mouse=a   " Enable mouse usage (all modes)

" {-markers are used to specify folds
set foldmethod=marker

" 100-symbols warning guide
set colorcolumn=100
highlight ColorColumn ctermbg=7 guibg=#bebebe
" Don't break long lines
set textwidth=0
" Wrap long text
set wrap

set lazyredraw  " Don't redraw the screen during macros

" Line numbers
set number
set numberwidth=3
" number column for the text of wrapped lines:
set cpoptions+=n
" Colors
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE

" List mode options
set listchars=tab:▸·,eol:¬,precedes:«,extends:»
nmap <leader>l :set list!<CR>

"}}}

"{{{ Edit options

" Convert tabs to spaces
set expandtab
" Tab and indent size - 4 spaces
set shiftwidth=4
set tabstop=4

" Autoindent
set autoindent
set smartindent

" Searching
set wrapscan             " Searches wrap around when reaching EOF
set incsearch            " Incremental search
set ignorecase smartcase " Ignore the case when searching unless uppercase letters are used

set backspace=indent,eol,start  " Backspace unindents, joins lines and over start of insert

set nostartofline  " Stop moving the cursor to the first non-space character in lines

" Disable autostarting new line after comment with another comment
autocmd FileType * setlocal formatoptions-=cro

"}}}

"{{{ Sort this out

" Space to reset search highilghts
nmap <silent> <space> :nohlsearch<CR>

" Check syntax on write for shell scripts
autocmd BufWritePost  *.bash,*.sh,*.ebuild :!bash -n %
autocmd BufWritePost  *.zsh :!zsh -n %

" Maximum number of tabs on opening
set tabpagemax=100

" Search selected text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Jump to last position in file
au BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
\ |   exe "normal! g`\""
\ | endif

" Case insensitive completion in command line
set wildignorecase

"}}}

"{{{ Exherbo-specific stuff

" Values for exheres template.
let g:exheres_author_name = "Alexander Kapshuna <kapsh@kap.sh>"

" Ignore options and version spec when sorting.
command -range SortPackages <line1>,<line2>sort ri /[^[]\+/

"}}}

