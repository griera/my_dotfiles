" =============================================================================
" Start Vundle configuration
" =============================================================================

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Also required by Vundle.
set nocompatible

" Required by Vundle.
filetype off

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Alternatively, pass a path where Vundle should install plugins.
"call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

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

" File navigator gutter
Plugin 'scrooloose/nerdtree.git'

" Color scheme pack
Plugin 'flazz/vim-colorschemes'

" Status line bar
Plugin 'bling/vim-airline'

" Awesome syntax checking
Plugin 'scrooloose/syntastic'

" Awesome Git wrapper
Plugin 'tpope/vim-fugitive'

" Implements some of TextMate's snippets features
Plugin 'msanders/snipmate.vim'

" A code-completion engine
"Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" =============================================================================
" End Vundle configuration
" =============================================================================


" =============================================================================
" Start general configuration
" =============================================================================

" Most of this configurations are based on this article:
" http://items.sjbach.com/319/configuring-vim-right

" Enables limited line numbering in a buffer.
" Format is: (line, column, %).
set ruler

" Shows current mode down the bottom.
set showmode

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Shows incomplete cmds down the bottom.
set showcmd

" Reloads files changed outside vim.
set autoread

" Allows Vim to manage multiple buffers effectively.
" Buffers can exist in the background without being in a windows.
set hidden

" The screen will not be redrawn while executing macros,
" registers and other commands that have not been typed.
set lazyredraw

" Makes backspace work like most other apps
set backspace=indent,eol,start

set title
set mouse=nv
set relativenumber
set number
set history=1000
set textwidth=80
set colorcolumn=80
set wrap

" Search options
"""""""""""""""""""""""""""""""""""""""
set ignorecase
set smartcase
set incsearch
set hlsearch

" Press return to temporarily get out of the highlighted search.
nnoremap <CR> :nohlsearch<CR><CR>


" Completion options
"""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildmode=list:longest
set wildignore=*.o,*.obj,*~
set wildignore+=*.png,*.jpg,*.gif


" Indentation options (by default)
"""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set smarttab


" Appearance options
"""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=256
syntax on
let g:molokai_original=0
colorscheme molokai


" Mapping options
"""""""""""""""""""""""""""""""""""""""
noremap <MiddleMouse> <LeftMouse><MiddleMouse>
noremap <LeftRelease> <LeftRelease>y


" File type specific configurations
"""""""""""""""""""""""""""""""""""""""
" Grouping related autocommands is intended to improve Vim performance. This tip
" is well explained at:
" - http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
"
" This solution can be found at:
" - https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim

augroup filetype_gitcommit
    autocmd!
    autocmd FileType gitcommit let b:comment_leader = '#'
    autocmd Filetype gitcommit setlocal spell textwidth=72 colorcolumn=72
augroup END

augroup filetype_c_cpp_java_scala
    autocmd!
    autocmd FileType c,cpp,java,scala let b:comment_leader = '//'
augroup END

augroup filetype_sh_ruby_python
    autocmd!
    autocmd FileType sh,ruby,python let b:comment_leader = '#'
augroup END

augroup filetype_conf_fstab
    autocmd!
    autocmd FileType conf,fstab let b:comment_leader = '#'
augroup END

augroup filetype_tex
    autocmd!
    autocmd FileType tex let b:comment_leader = '%'
augroup END

augroup filetype_mail
    autocmd!
    autocmd FileType mail let b:comment_leader = '>'
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim let b:comment_leader = '"'
augroup END

noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


" =============================================================================
" End general configuration
" =============================================================================

" =============================================================================
" Start plugins configurations
" =============================================================================

" vim-airline
"""""""""""""""""""""""""""""""""""""""
" Sets the statusline appearing all the time.
set laststatus=2

" Avoid the delay when leaving Insert mode.
set ttimeoutlen=50

" Sets powerline font symbols showing up properly. It's mandatory to patch the
" font you use in your terminal. To download an already font patched pack:
" https://github.com/powerline/fonts
"
" For installation instructions:
" https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation
set encoding=utf-8
let g:airline_powerline_fonts=1

let g:airline_theme='murmur'

" =============================================================================
" End plugins configuration
" =============================================================================

" Jumps to the last position when reopening a file"
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
