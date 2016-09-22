" Vundle plugin with plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'wikitopian/hardmode'
Plugin 'kien/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'bling/vim-bufferline'
Plugin 'akhaku/vim-java-unused-imports'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-sensible'
"Plugin ''

call vundle#end()
filetype plugin indent on
" end of Vundle plugin


" use VIM not VI
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey40
hi CursorLine cterm=NONE ctermbg=233 guifg=#121212
set tabstop=4
set shiftwidth=4
set ignorecase
set expandtab
set smartcase
set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
map Q gq

if has('mouse')
  set mouse=a
endif
syntax on
set hlsearch
if has("autocmd")
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

execute pathogen#infect()
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_focus_on_files=1
source ~/.vimrc_projects

set number
set list listchars=tab:→\ ,trail:·

set backupdir=$HOME/.vim/backup
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

map <F3> :noh<CR>
map <F4> :UnusedImports<CR>
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntstic (syntax checker)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:pymode_lint_on_write = 1
let g:syntastic_python_checkers = ['pylint']
set runtimepath^=~/.vim/bundle/ctrlp.vim
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

