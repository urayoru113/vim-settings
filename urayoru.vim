"******** .vimrc ********
if has('win32')
  let $vimdir = expand("~/vimfiles")
else
  let $vimdir = expand("~/.vim")
endif
let $plugindir = ""

"[utils]
function! GetCursorChar()
  return matchstr(getline("."), '\%'.col(".").'c.')
endfunction

set autoindent
set cin
set expandtab
set incsearch
set number
set smarttab
set ttyfast
set noeol
set noendofline
set nofixendofline
set notitle
set nowrap

set encoding=utf-8
set t_Co=256
set laststatus=2
set shiftwidth=2
set tabstop=2
set scrolloff=4
set fileformat="unix,dos,mac"

syntax enable

inoremap <C-c> <Esc>
noremap s $
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k


"******** bundle ********
if isdirectory($vimdir."/bundle/Vundle.vim")
  et $plugindir = $vimdir."/bundle"
  set nocompatible              " be iMproved, required
  filetype off                  " required

  exe 'set rtp+=' . $plugindir."/Vundle.vim"
  call vundle#begin($plugindir)

  Plugin 'VundleVim/Vundle.vim'
  Plugin 'preservim/nerdtree'
  Plugin 'vim-scripts/Pydiction'
  Plugin 'mattn/emmet-vim'

  call vundle#end()            " required
  filetype plugin indent on    " required
endif

"******** vim-plug *********
if filereadable($vimdir."/autoload/plug.vim")
  let $plugindir = $vimdir."/plugged"
  call plug#begin($vimdir."/plugged")

  " Make sure you use single quotes

  Plug 'scrooloose/nerdtree'
  Plug 'vim-scripts/Pydiction', {'for': ['py']}
  Plug 'mattn/emmet-vim', {'for': ['html']}
  Plug 'Yggdroot/indentLine'
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'

  " vim scheme
  Plug 'evturn/cosmic-barf'
  Plug 'tomasr/molokai'

  call plug#end()            " required
endif

"******** python *********
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd BufNewFile,BufRead *.py :noremap <F9> :!python % <CR>

autocmd BufNewFile,BufRead *.py let g:pydiction_location = 
      \$plugindir."/Pydiction/complete-dict"
autocmd BufNewFile,BufRead *.py let g:pydiction_menu_height = 3

"******** c ********
autocmd BufNewFile,BufRead *.c :noremap <F9> :!gcc % -o %:r && ./%:r <CR>

"******** nerdtree ********
function! NERDTreeLoader()
  nnoremap <silent> <F2> :NERDTreeToggle<CR>
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter *
        \ if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * 
        \ if (winnr("$") == 1 
        \ && exists("b:NERDTree") 
        \ && b:NERDTree.isTabTree()) | q | endif
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
  let g:NERDTreeDirArrowExpandable = '➝'
  let g:NERDTreeDirArrowCollapsible = '▾'
  let g:NERDTreeWinSize=24
endfunction


"******** indentline ********
function LightlineLoader()
let g:lightline = {
      \'colorscheme': 'wombat',
      \ }

endfunction


"******** auto-pairs ********
function AutoPairsLoader()
  let g:AutoPairsFlayMode = 1
endfunction

"******** scheme ********
colorscheme cosmic-barf

"[Load plugin]
autocmd VimEnter * if exists('NERDTree')  | call NERDTreeLoader()      | endif
autocmd VimEnter * if exists('lightline') | call LightlineLoader() | endif
autocmd VimEnter * if exists('AutoPairs') | call AutoPairsLoader() | endif