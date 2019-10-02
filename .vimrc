set ts=4 sw=4 et
set nu
set ai
set noendofline
set nofixendofline
set noeol

set smarttab

set autoindent

autocmd BufNewFile,BufRead *.c :noremap <F9> :!gcc % -o %:r && ./%:r <CR>
autocmd BufNewFile,BufRead *.py :noremap <F9> :!python % <CR>

:noremap s $
:inoremap {<CR> {<CR>}<Esc>O
:inoremap <C-c> <Esc>

filetype plugin indent on
let g:pydiction_location = '/home/urayoru/.vim/tools/Pydiction/complete-dict'
