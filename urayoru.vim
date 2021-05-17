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
set smarttab
set ttyfast
set nonumber
set noeol
set noendofline
set nofixendofline
set notitle
set nowrap
set relativenumber

set backspace=indent,eol,start
set background=dark
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

noremap <tab> gt
noremap <s-tab> gT

nnoremap <C-s> :w<CR>

inoremap <m-k> <up>
inoremap <m-j> <down>
inoremap <m-h> <left>
inoremap <m-l> <right>
inoremap <C-s> <ESC>:w<CR>a

let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=3000

autocmd BufRead * :%s/\s\+$//e
autocmd BufRead * :%s/\r//e
"******** bundle ********
if isdirectory($vimdir."/bundle/Vundle.vim")
  let $plugindir = $vimdir."/bundle"
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
  Plug 'mattn/emmet-vim', {'for': ['html']}
  Plug 'Yggdroot/indentLine'
  Plug 'itchyny/lightline.vim'
  Plug 'jiangmiao/auto-pairs'
  "Plug 'vim-syntastic/syntastic', {'for': 'python', 'branch': 'develop'}
  Plug 'dense-analysis/ale'
  "Plug 'python-mode/python-mode', {'for': 'python', 'branch': 'develop'}
  "Plug 'davidhalter/jedi-vim'
  Plug 'takac/vim-hardtime'

  " vim scheme
  Plug 'evturn/cosmic-barf'
  Plug 'artanikin/vim-synthwave84' "synthwave84
  Plug 'ParamagicDev/vim-medic_chalk'
  Plug 'bluz71/vim-nightfly-guicolors' "nightfly
  Plug 'sainnhe/edge'
  Plug 'sainnhe/sonokai'
  Plug 'https://github.com/jsnal/vim-serape', { 'tag': 'v0.2.2'  } " serape
  Plug 'xdg/vim-darkluma' "darkluma
  Plug 'sonph/onehalf'
  Plug 'tomasr/molokai'

  call plug#end()            " required
endif

"******** python *********
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd BufNewFile,BufRead *.py :noremap <F9> :!python % <CR>
autocmd BufNewFile,BufRead *.py :noremap <F10> :!python %

autocmd BufNewFile,BufRead *.py let g:pydiction_location =
      \$plugindir."/Pydiction/complete-dict"
autocmd BufNewFile,BufRead *.py let g:pydiction_menu_height = 3

"******** c ********
autocmd BufNewFile,BufRead *.c :noremap <F9> :!gcc % -o %:r && ./%:r <CR>
autocmd BufNewFile,BufRead *.cpp :noremap <F9> :!g++ % -o %:r && ./%:r <CR>

"******** nerdtree ********
autocmd StdinReadPre * let s:std_in=1
function! NERDTreeLoader()
  nnoremap <silent> <F2> :NERDTreeToggle<CR>
  if argc() == 0 && !exists('std_in') | NERDTree | endif
  if argc() == 1 && isdirectory(argv()[0])
\ && !exists("s:std_in") | exe 'NERDTree' argv()[0]
                       \ | wincmd p
                       \ | ene | exe 'cd '.argv()[0] | endif
  autocmd BufEnter * if (winnr("$") == 1
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

endfunction
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '-'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinSize=24


"******** indentline ********
let g:lightline = {
      \'colorscheme': 'molokai',
      \ }

"******** ale ********
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
"let g:ale_fixers = {
"\   'python': ['autopep8', 'yapf'],
"\}

let g:ale_python_flake8_options = '-m flake --ignore E501'

"******** syntastic ********
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'
"let g:syntastic_python_checkers = ['pylint']
"
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"******** auto-pairs ********
function AutoPairsLoader()
  let g:AutoPairsFlyMode = 1
  let g:AutoPairsShortcutFastWrap = '<A-e>'
endfunction

"******** jedi-vim ********
let g:jedi#popup_on_dot = 1

"******** scheme ********
silent! colorscheme serape

"[Load plugin]
autocmd VimEnter * if exists('NERDTree')  | call NERDTreeLoader()  | endif
autocmd VimEnter * if exists('AutoPairs') | call AutoPairsLoader() | endif
autocmd VimEnter * if exists('*HardTimeOn') | call HardTimeOn() | endif