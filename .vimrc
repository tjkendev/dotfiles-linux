" .vimrc for linux(Ubuntu)
scriptencoding utf-8

""" Editor """
set clipboard=unnamedplus,autoselect  " '+'とクリップボード共有
set smarttab
set tabstop=2    " タブ幅
set shiftwidth=2 " タブを挿入するときの幅
set expandtab    " タブをスペースとして扱う
set softtabstop=0 " 
set shiftround   " <>インデントはshiftwidth
"set infercase
"set virtualedit=all
"set hidden
set backspace=indent,eol,start " Backspaceによる削除有効化
set autoindent  " オートインデント
"set cindent     " オートインデントより賢いインデント(C用?)
set nowrap      " 長いテキストを折り返さない
set formatoptions-=r    " 改行時コメント無効
set formatoptions-=o
set fileformats=unix,dos,mac " 改行コードの自動認識

""" Visual """
set ruler       " ルーラー表示
set nu          " 行番号
set list        " 不可視文字の可視化
set cursorline  " カーソルのある行を強調(7.4~)
"set cursorcolumn " カーソルのある列を強調
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
set fileencodings=ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2,utf-8

""" System """
set mouse=a     " マウス機能有効化
set nobackup    " バックアップ不要
set backupdir=~/.vimbackup " バックアップディレクトリ
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

""" Detail """
" 不可視文字の設定
set listchars=tab:▸\ ,eol:\ ,trail:-,extends:»,precedes:«,nbsp:%

" java highlight setting
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" COBOL
"let cobol_legacy_code = 1

""" NeoBundle """
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

filetype plugin indent on
syntax on

" Installation check
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
  	\ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" base
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/VimClojure'
NeoBundle 'Yggdroot/indentLine'
"NeoBundle 'tpope/vim-surround'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'troydm/easybuffer.vim'
NeoBundle 'osyo-manga/vim-over'
"NeoBundle 'https://bitbucket.org/kovisoft/slimv'
" git
NeoBundle 'tpope/vim-fugitive'
" ruby
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
" c++
NeoBundle 'vim-jp/cpp-vim'
"" javascript / node.js
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'
NeoBundle 'digitaltoad/vim-jade'
"" Haskell
NeoBundle 'kana/vim-filetype-haskell'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'ujihisa/ref-hoogle'
NeoBundle 'ujihisa/unite-haskellimport'
" html
NeoBundle 'mattn/emmet-vim'
"NeoBundle 'tyru/open-browser.vim'
NeoBundle 'hail2u/vim-css3-syntax'
"NeoBundle 'AtsushiM/search-parent.vim'
"NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'othree/html5.vim'
" css
"NeoBundle 'skammer/vim-css-color'
"" colorscheme
NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'vim-scripts/twilight'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'

"" ----- unite.vim ----- {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
 
" unite.vim keymap
" https://github.com/alwei/dotfiles/blob/3760650625663f3b08f24bc75762ec843ca7e112/.vimrc
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" vinarise
let g:vinarise_enable_auto_detect = 1
 
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
"" }}}

"" ----- neocomplete -----
"let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case  = 1
let g:neocomplete#enable_fuzzy_completion = 0

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

if !exists('g:neocomplete#sources#dictionary#dictionaries')
  let g:neocomplete#sources#dictionary#dictionaries = {}
endif
let dict = g:neocomplete#sources#dictionary#dictionaries

let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax\|Log.txt'
call neocomplete#custom_source('_', 'sorters',  ['sorter_length'])
call neocomplete#custom_source('_', 'matchers', ['matcher_head'])

inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
inoremap <expr><CR>   pumvisible() ? "\<C-n>" . neocomplete#close_popup()  : "<CR>"
inoremap <expr><C-e>  pumvisible() ? neocomplete#close_popup() : "<End>"
inoremap <expr><C-c>  neocomplete#cancel_popup()
inoremap <expr><C-u>  neocomplete#undo_completion()
inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"

"" ----- vim-easymotion -----
" http://blog.remora.cx/2012/08/vim-easymotion.html
" 2 character search motion
"nmap s <Plug>(easymotion-s2)
"nmap t <Plug>(easymotion-t2)
" n character search motion
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
" hjkl motion
"map <Leader>h <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>l <Plug>(easymotion-linebackward)
" Smartcase & Smartsign
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_jp = 1
" Migemo feature
let g:EasyMotion_use_migemo = 1
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「;」 + 何かにマッピング
let g:EasyMotion_leader_key=";"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

"" ----- lightline.vim -----
set guifont=Ricty\ 10
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
      \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
      \ }

"" ----- neosnippet -----

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"" ----- indentLine -----
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239

"" ----- vim-quickrun -----
let g:quickrun_config = {
      \ "_" : {
      \     "runner" : "vimproc",
      \     "runner/vimproc/updatetime" : 60,
      \     "hook/time/enable" : 1,
      \ },
      \ "cpp/g++" : {
      \     "cmdopt" : "-std=c++11"
      \ },
      \}
" <C-c>でquickrunを強制終了できるように
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_scessions() : "\<C-c>"

"" ----- ghc-mod -----
let $PATH = $PATH . ':' . expand("~/.cabal/bin")

""" colorscheme """
colorscheme jellybeans

" colorschemeからの変更
highlight Comment ctermfg=70
hi CursorLine term=none cterm=none ctermbg=236
