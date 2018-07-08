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
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" My plugins

" Nice start screen
Plugin 'mhinz/vim-startify'

" Toggling boolean values
Plugin 'Toggle'

" Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/nerdcommenter'

" A better JSON for Vim
Plugin 'elzr/vim-json'

" Next generation completion framework after neocomplcache
Plugin 'Shougo/deoplete.nvim'

" A Vim alignment plugin
Plugin 'junegunn/vim-easy-align'

" Undo tree
Plugin 'sjl/gundo.vim'

" ansi escape sequences concealed, but highlighted as specified.
Plugin 'powerman/vim-plugin-AnsiEsc'

" automatically detecting indent settings
Plugin 'ciaranm/detectindent'

" Show differences for recovered files
Plugin 'chrisbra/Recover.vim'

" Highlight multiple search results
Plugin 'vim-scripts/MultipleSearch'

" transparent pasting into vim. (i.e. no more :set paste!)
Plugin 'ConradIrwin/vim-bracketed-paste'

" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
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

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" JSON
" Prevent hiding of quotes
let g:vim_json_syntax_conceal = 0

" Startify
" Disable fortunes
let g:startify_custom_header = ''
" Increase MRU count
let g:startify_files_number = 20

" Deoplete
let g:deoplete#enable_at_startup = 1

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

colorscheme desert

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

" F4 for show menu
if !has("gui_running")
    :source $VIMRUNTIME/menu.vim
    :set wildmenu
    :set cpoptions-=<
    :set wildcharm=<C-Z>
    :map <F4> :emenu <C-Z>
endif

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

" {{{ Russian layout
set keymap=russian-jcukenwin

" Default layout: en
set iminsert=0
set imsearch=0

" For some reason doesn't set cursor color but without this <C-6> doesn't switch input language.
function MyKeyMapHighlight()
    if &iminsert == 0
        hi lCursor ctermbg=DarkBlue guibg=DarkBlue
    else
        hi lCursor ctermbg=DarkGreen guibg=DarkGreen
    endif
endfunction

" Init colors on start
call MyKeyMapHighlight()

" Set colors when changing buffers
au WinEnter * :call MyKeyMapHighlight()

" Bind keymap switching to C-6 in all modes
cmap <silent> <C-^> <C-^>
imap <silent> <C-^> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-^> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-^> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
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

"}}}

"{{{ Exherbo-specific stuff

" Values for exheres template.
let g:exheres_author_name = "Alexander Kapshuna <kapsh@kap.sh>"

" Ignore options and version spec when sorting.
command -range SortPackages <line1>,<line2>sort ri /[^[]\+/

"}}}

