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
