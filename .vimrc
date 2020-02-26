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


autocmd BufNewFile,BufRead *.c :noremap <F9> :!gcc % -o %:r && ./%:r <CR>
autocmd BufNewFile,BufRead *.py :noremap <F9> :!python % <CR>

:noremap s $
:inoremap {<CR> {<CR>}<Esc>O
:inoremap <C-c> <Esc>

"[ python ]
if !exists('g:pydiction_location')
  let g:pydiction_location = '/home/urayoru/.vim/tools/Pydiction/complete-dict'
endif
"[ nerdtree ]
if !exists('NERDTree')
  map <F2> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
