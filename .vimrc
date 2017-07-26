" -------- Encoding UTF-8  -------- "
scriptencoding utf-8
set encoding=utf-8

" ----- Vundle plugin with plugins ----- "
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" - Import Plugins - "
let vim_plugins_file=$HOME.'/.vim_plugins'
if filereadable(vim_plugins_file)
    source ~/.vim_plugins
endif

call vundle#end()
filetype plugin indent on
" --- end of Vundle plugin --- "


set nocompatible
set cursorline
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

" --- nerdtree configuration --- "
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_focus_on_files=1

set number
set list listchars=tab:→\ ,trail:·

set backupdir=$HOME/.vim/backup
set nobackup
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

map <C-n> :NERDTreeToggle<CR>
map <F3> :noh<CR>
map <F4> :UnusedImports<CR>
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprevious<cr>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let vimproj=$HOME.'/.vim/bundle/vim-project'
let projects_list_file=$HOME.'/.vimrc_projects'
if isdirectory(vimproj) && filereadable(projects_list_file)
    set rtp+=~/.vim/bundle/vim-project/
    call project#rc("~/work")
    source ~/.vimrc_projects
    let radon_always_on
    let g:project_use_nerdtree = 1
endif

" syntstic (syntax checker)
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:pymode_lint_on_write = 1
let g:syntastic_python_checkers = ['flake8', 'pep8']
set runtimepath^=~/.vim/bundle/ctrlp.vim
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

hi CursorLine cterm=NONE ctermbg=black

syntax enable
filetype plugin indent on
