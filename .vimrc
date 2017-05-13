set encoding=utf-8
scriptencoding utf-8

" plugin
if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
if version > 703 && isdirectory(s:dein_dir)
  let &runtimepath = &runtimepath . ',' . s:dein_dir . '/repos/github.com/Shougo/dein.vim'
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add('Shougo/dein.vim')
    call dein#add('embear/vim-localvimrc')
    call dein#add('ap/vim-buftabline')
    call dein#add('cohama/lexima.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('derekwyatt/vim-scala')
    call dein#end()
    call dein#save_state()
  endif
  if dein#check_install()
    call dein#install()
  endif
  let g:localvimrc_ask = 0
  let g:buftabline_numbers = 2
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeQuitOnOpen = 1
  let g:lexima_enable_basic_rules = 0
endif

" settings
filetype plugin indent on
syntax enable
set number
set hidden
set ruler
set showcmd
set showmode
set laststatus=2
set statusline=%F\ %m%r%h%w%=\ %{&ft}\ %{&fenc}\ %{&ff}
set wildmenu
set wildmode=longest,list,full
set list
set listchars=tab:>\ ,trail:-
set noswapfile
set nobackup
set noundofile
set mouse&
set formatoptions&
if has('kaoriya')
  autocmd FileType * setlocal formatoptions&
endif

set tabstop=4
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set expandtab
set autoindent
set smartindent

set hlsearch
set incsearch
set showmatch
set matchtime=1

set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,dos,mac
set ambiwidth=double

" editor shortcut
nnoremap Y y$
nnoremap <C-s> :%s/
inoremap <silent> jj <ESC>
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
nnoremap <Tab><Space> :setlocal expandtab<CR>
nnoremap <Tab><Tab> :setlocal noexpandtab<CR>
nnoremap <Tab>2 :setlocal ts=4 sw=2 sts=2<CR>
nnoremap <Tab>4 :setlocal ts=4 sw=4 sts=4<CR>

" buffer shortcut
nnoremap <silent> <Space>w :b#<CR>
nnoremap <silent> <Space>d :bd<CR>
nnoremap <silent> <Space>e :NERDTreeToggle<CR>
for s:i in range(1, 9)
  execute 'nmap <silent> <Space>' . s:i . ' <Plug>BufTabLine.Go(' . s:i . ')'
endfor

" window shortcut
nnoremap <Space>s :split<CR>
nnoremap <Space>v :vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" cursor shortcut
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k
nnoremap <silent> <C-a> ^
nnoremap <silent> <C-e> $
inoremap <silent> <C-a> <ESC>^i
inoremap <silent> <C-e> <ESC>$a

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END
