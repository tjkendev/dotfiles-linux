" init.vim for NeoVim in linux(Ubuntu)
scriptencoding utf-8

" for avoiding terminator bug
set guicursor=

" autocmdは一度だけ
augroup vimrc
  autocmd!
augroup END

""" Editor """
set smarttab
set tabstop=2    " タブ幅
set shiftwidth=2 " タブを挿入するときの幅
set expandtab    " タブをスペースとして扱う
set softtabstop=0 "
set shiftround   " インデントはshiftwidthの倍数
set infercase
set hidden
set backspace=indent,eol,start " Backspaceによる削除有効化
set autoindent  " オートインデント
set nowrap      " 長いテキストを折り返さない
set formatoptions-=r    " 改行時コメント無効
set formatoptions-=o
set fileformats=unix,dos,mac " 改行コードの自動認識

""" Visual """
set ruler       " ルーラー表示
set nu          " 行番号
set list        " 不可視文字の可視化
set cursorline  " カーソルのある行を強調(7.4~)
set laststatus=2 " ステータスラインを常に表示
if !has('gui_running')
  set t_Co=256
endif
set showmatch   " 対応するカッコをハイライト表示
set matchtime=3 " 対応括弧のハイライト表示を3秒に
" set title       " > Vim を使ってくれてありがとう <
set notitle     " タイトル変更しない

""" Search """
set ignorecase  " 検索時大文字小文字区別しない
set smartcase   " 大文字が含まれている場合は区別して検索
set hlsearch    " 検索結果文字列のハイライト有効
set incsearch   " インクリメントサーチ
set wrapscan    " 最後まで検索したら先頭に

""" encoding """
set encoding=utf-8
set ambw=double
set termencoding=utf-8
set fileencoding=utf-8
"set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
"set fileencodings+=,ucs-2le,ucs-2,utf-8

""" System """
set mouse=a     " マウス機能有効化
set nobackup    " バックアップ不要
"set backupdir=~/.vimbackup " バックアップディレクトリ
set noswapfile  " スワップファイル不要
set vb t_vb=    " ビープ音Off
set shortmess& shortmess+=I     " 起動時のメッセージを消す
set noimdisable " IMを使う
set iminsert=0  " 入力モードで自動的に日本語を使わない
set imsearch=0  " 検索で自動的に日本語を使わない
set autoread    " ファイルが変更された時自動で読みなおす
set noerrorbells  " エラー時のSE無効

""" CommandLine """
set wildmenu    " コマンドラインモードでTabキーでファイル名保管を有効
set showcmd     " 入力中のコマンドをステータスに表示
set magic       " 検索時に正規表現を利用する

" ESC2回で検索ハイライト消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR><Esc>

""" Detail """
" 不可視文字の設定
set listchars=tab:▸\ ,eol:\ ,trail:-,extends:»,precedes:«,nbsp:%

" 行末空白
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" java highlight setting
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" COBOL
"let cobol_legacy_code = 1

" coffeescript
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
autocmd vimrc FileType coffee     setlocal sw=2 sts=2 ts=2 et

" Jython
autocmd BufRead,BufNewFile,BufReadPre *.jy set filetype=python

" ruby
autocmd FileType ruby setl iskeyword+=?

"" -b付きでバイナリモード
"" http://d.hatena.ne.jp/rdera/20081022/1224682665
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre  *.bin let &binary =1
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | execute "%!xxd -r" | endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END
"" BinaryXXDを無効にしたい場合
command InvalidBinary :autocmd! BinaryXXD

"" pyenv
"let g:python_host_prog = $PYENV_ROOT . '/shims/python'
let g:python_host_prog = ''
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'


" ----- dein -----
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  call dein#add( 'Shougo/vimproc.vim', {
        \ 'build' : 'make -f make_unix.mak'
        \ })
  call dein#add('itchyny/lightline.vim')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('Yggdroot/indentLine')
  call dein#add('thinca/vim-quickrun')
  call dein#add('scrooloose/syntastic')
  call dein#add('nanotech/jellybeans.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('zchee/deoplete-clang')
  "call dein#add('zchee/nvim-go', {'build': 'make'})
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

"" ----- vim-easymotion -----
" Smartcase & Smartsign
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_jp = 1
" Migemo feature
let g:EasyMotion_use_migemo = 1
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" ";" + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

"" ----- syntastic -----
" use c++11
let g:syntastic_cpp_compiler_options = '-std=c++17 -stdlib=libc++'
" ASM use -m32
let g:syntastic_asm_compiler_options = '-m32'
" use pyflakes and pep8
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
" pep8のErrorCheckは厳しいので少し緩めに
let g:syntastic_python_pep8_args='--ignore=E302,E501,E225,E226,E228,E265,E702,E703'
" SyntasticToggleMode を F4 で切り替え
noremap <silent><F4> :SyntasticToggleMode<CR>

"" ----- lightline.vim -----
set guifont=Ricty\ for\ Powerline\ 10
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

"" ----- deoplete -----
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \ 'auto_complete_delay': 2,
      \})

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"" ----- indentLine -----
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239

"" ----- vim-quickrun -----
let g:quickrun_config = {
      \ "_" : {
      \     "runner" : "vimproc",
      \     "runner/vimproc/updatetime" : 60,
      \     "hook/time/enable" : 1,
      \     "hook/time/dest": "buffer",
      \     "outputter/error/success": "buffer",
      \     "outputter/buffer/split": ":botright 4sp",
      \     "outputter/buffer/close_on_empty": 1,
      \ },
      \ "cpp/g++" : {
      \     "cmdopt" : "-std=c++17"
      \ },
      \ "asm" : {
      \     "command" : "gcc",
      \     "exec" : [
      \       "%c -m32 %s -o q.out", "./q.out"
      \     ]
      \ },
      \ "html" : {
      \     "exec" : "xdg-open %s:p",
      \ },
      \ "tex": {
      \     "command" : "platex",
      \     "exec" : [
      \         "%c %s", "%c %s",
      \         "dvipdfmx %s:r.dvi",
      \         "xdg-open %s:r.pdf"
      \     ],
      \ },
      \}
" <C-c>でquickrunを強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_scessions() : "\<C-c>"
" F5 running
nnoremap <silent><F5> :QuickRun -mode n<CR>
vnoremap <silent><F5> :QuickRun -mode v<CR>

set showcmd

""" colorscheme """
colorscheme jellybeans

" colorschemeからの変更
highlight Comment ctermfg=70
hi CursorLine term=none cterm=none ctermbg=236
" 背景透過
highlight Normal ctermbg=none
highlight NonText ctermbg=none
