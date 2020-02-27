"[ bundle ]
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'preservim/nerdtree'
Plugin 'vim-scripts/Pydiction'

call vundle#end()            " required

filetype plugin indent on    " required


"[ .vimrc ]
if has('mac')
  source ~/.vim_runtime/vimrcs/basic.vim
endif

set cin
set ts=2 sw=2 et
set nu
set noendofline
set nofixendofline
set noeol
set smarttab
set autoindent


:noremap s $
:inoremap {<CR> {<CR>}<Esc>O
:inoremap <C-c> <Esc>
:noremap <C-h> <C-w>h
:noremap <C-l> <C-w>l
:noremap <C-j> <C-w>j
:noremap <C-k> <C-w>k

"[ python ]
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd BufNewFile,BufRead *.py :noremap <F9> :!python % <CR>
autocmd BufNewFile,BufRead *.py let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
autocmd BufNewFile,BufRead *.py let g:pydiction_menu_height = 3

"[ c ]
autocmd BufNewFile,BufRead *.c :noremap <F9> :!gcc % -o %:r && ./%:r <CR>

"[ nerdtree ]
if !exists('NERDTree')
  nmap <F2> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  let NERDTreeIgnore = [
    \'\.DS_Store$',
    \'\.bundle$',
    \'\.capistrano$',
    \'\.git$',
    \'\.gitkeep$',
    \'\.keep$',
    \'\.localized$',
    \'\.routes$',
    \'\.sass-cache$',
    \'\.swo$',
    \'\.swp$',
    \'tags$'
  \]
endif
