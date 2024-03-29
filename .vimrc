set encoding=utf-8
scriptencoding utf-8

" plugin
if &compatible | set nocompatible | endif
let $DEIN = $HOME . '/.cache/dein'
if version > 704 && isdirectory($DEIN)
  set runtimepath+=$DEIN/repos/github.com/Shougo/dein.vim
  if dein#load_state($DEIN)
    call dein#begin($DEIN)
    call dein#add('Shougo/dein.vim')
    call dein#add('embear/vim-localvimrc')
    call dein#add('ap/vim-buftabline')
    call dein#add('cohama/lexima.vim')
    call dein#add('cocopon/vaffle.vim')
    call dein#add('tyru/caw.vim')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-sleuth')
    call dein#add('haya14busa/incsearch.vim')
    call dein#add('rhysd/clever-f.vim')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('w0rp/ale')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('niklasl/vim-rdf')
    call dein#add('mechatroner/rainbow_csv')
    call dein#add('foooomio/vim-colors-japanesque')
    call dein#end()
    call dein#save_state()
  endif
  if dein#check_install()
    call dein#install()
  endif
  let g:localvimrc_ask = 0
  let g:buftabline_numbers = 2
  let g:ale_lint_on_text_changed = 'normal'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_linters_ignore = { 'javascript': ['deno'], 'typescript': ['deno'] }
  let g:incsearch#auto_nohlsearch = 1
  map n <Plug>(incsearch-nohl-n)
  map N <Plug>(incsearch-nohl-N)
  map * <Plug>(incsearch-nohl-*)
  map # <Plug>(incsearch-nohl-#)
endif

" syntax highlight
augroup MyColors | autocmd! | augroup END

if isdirectory($DEIN) && has('termguicolors')
  set termguicolors
  set background=dark
  colorscheme japanesque
else
  colorscheme default
  autocmd MyColors ColorScheme * highlight Search ctermfg=0
  autocmd MyColors ColorScheme * highlight Visual ctermbg=4
  autocmd MyColors ColorScheme * highlight MatchParen cterm=underline ctermbg=NONE
endif

" appearance
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
set wildignorecase
set wildignore+=*.lock,vendor/**,node_modules/**
set list
set listchars=tab:>\ ,trail:-
set visualbell

" cache
let $CACHE = $HOME . '/.cache/vim//'
if !isdirectory($CACHE) | call mkdir($CACHE, 'p') | endif
set backup
set backupdir=$CACHE
set backupskip+=/private/tmp/crontab.*
set swapfile
set directory=$CACHE
set undofile
set undodir=$CACHE

" indent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set expandtab
set autoindent
set smartindent

" search
set hlsearch
set incsearch
set showmatch
set matchtime=1
set ignorecase
set smartcase

" encoding
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,dos,mac
set ambiwidth=double

" auto command
augroup vimrc
  autocmd!
  autocmd FileType * setlocal formatoptions=
  autocmd SwapExists * let v:swapchoice = 'o'
  autocmd FileType php
        \ setlocal tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType go setlocal listchars=tab:\ \ ,trail:-
  autocmd BufNewFile,BufRead *.rdf setfiletype xml
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
augroup END

" editor shortcut
nnoremap Y y$
nnoremap + <c-a>
nnoremap - <C-x>
vnoremap < <gv
vnoremap > >gv|
nnoremap <Space>s :<C-u>%s/
inoremap <silent> jj <ESC>
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>
nnoremap <Tab>e :<C-u>set expandtab!<CR>:set expandtab?<CR>
nnoremap <Tab><Tab> :<C-u>call <SID>switch_indent()<CR>
nnoremap <silent> cc :<C-u>execute 'setlocal cc=' . (&cc ? '' : '80')<CR>
nnoremap q: <Nop>

function! s:switch_indent()
  let s:indent = (&sw == 2 ? 'ts=4 sw=4 sts=4' : 'ts=4 sw=2 sts=2')
  execute 'setlocal ' . s:indent
  echo s:indent
endfunction

" buffer shortcut
nnoremap <silent> <Space>w :b#<CR>
nnoremap <silent> <Space>d :bd<CR>
for s:i in range(1, 9)
  execute 'nmap <silent> <Space>' . s:i . ' <Plug>BufTabLine.Go(' . s:i . ')'
endfor

" cursor shortcut
noremap <silent> j gj
noremap <silent> k gk
noremap <silent> gj j
noremap <silent> gk k

" quickfix shortcut
nnoremap <C-n> :cnext<CR>
nnoremap <C-p> :cprev<CR>

" emacs-style editing
noremap <C-a> ^
"noremap <C-b> <Left>
"noremap <C-d> <Del>
noremap <C-e> $
"noremap <C-f> <Right>
"noremap <C-k> D
inoremap <C-a> <C-o>^
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <C-o>$
inoremap <C-f> <Right>
inoremap <C-k> <C-o>D
inoremap <C-n> <Down>
inoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" gitgutter shortcut
nnoremap <Space>gg :<C-u>GitGutterSignsToggle<CR>
nnoremap <Space>ga :<C-u>GitGutterStageHunk<CR>
nnoremap <Space>gu :<C-u>GitGutterUndoHunk<CR>
nnoremap <Space>gd :<C-u>GitGutterPreviewHunk<CR>
nnoremap <Space>gn :<C-u>GitGutterNextHunk<CR>
nnoremap <Space>gp :<C-u>GitGutterPrevHunk<CR>

augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
