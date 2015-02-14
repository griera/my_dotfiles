"
" Vim config file by Genis Riera Perez
"

" Required by Vundle
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"
" Plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"
" Plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"
" Git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"

Plugin 'scrooloose/nerdtree.git'
Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

set laststatus=2
set showmode
set wrap
set wrapmargin=5
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set showmatch
set relativenumber
set mouse=nvh
set t_Co=256
syntax on
colorscheme molokai

"Vim function to quickly switch between relative and absolute line number"
function! Switch_line_number_mode()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

nnoremap <C-l><C-n> :call Switch_line_number_mode()<cr>
noremap <MiddleMouse> <LeftMouse><MiddleMouse>
noremap <LeftRelease> <LeftRelease>y

"Vim jumps to the last position when reopening a file"
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
