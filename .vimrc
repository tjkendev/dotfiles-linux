" .vimrc for linux(Ubuntu)
scriptencoding utf-8

" autocmdは一度だけ
augroup vimrc
  autocmd!
augroup END

""" Editor """
"set clipboard=unnamedplus,autoselect  " '+'とクリップボード共有
set smarttab
set tabstop=2    " タブ幅
set shiftwidth=2 " タブを挿入するときの幅
set expandtab    " タブをスペースとして扱う
set softtabstop=0 "
set shiftround   " インデントはshiftwidthの倍数
set infercase
"set virtualedit=all
set hidden
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

"" カーソル操作で o+(A|B|C|D) しない ""
if !has('gui_running')
  set notimeout
  set ttimeout
  set timeoutlen=100
endif

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

""" source ~/.vimrc
ca sv source<Space>~/.vimrc
ca vds vertical<Space>diffsplit

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

augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path+=.,/usr/include,/usr/local/include,/usr/include/c++/4.8.1
augroup END

let PATH = expand("~/.pyenv/shims") . ":" . $PATH

" ----- dein -----
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
"set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  " Let dein manage dein
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')

  call dein#add( 'Shougo/vimproc.vim', {
        \ 'build' : 'make -f make_unix.mak'
        \ })
  call dein#add('itchyny/lightline.vim')
  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('Shougo/unite.vim')
  call dein#add('h1mesuke/unite-outline')
  call dein#add('Shougo/vimshell')
  call dein#add('thinca/vim-quickrun')
  call dein#add("jceb/vim-hier")
  call dein#add('scrooloose/syntastic')
  call dein#add('vim-scripts/VimClojure')
  "call dein#add('spolu/dwm.vim')
  call dein#add('tyru/caw.vim')
  call dein#add('Yggdroot/indentLine')
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('soramugi/auto-ctags.vim')
  "call dein#add('tpope/vim-surround')
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('osyo-manga/vim-reunions')
  call dein#add( 'osyo-manga/vim-marching', {
              \ 'depends' : ['vimproc.vim', 'vim-reunions'],
              \ 'on_ft' : ['c', 'cpp']
              \ })
  "call dein#add('Shougo/neosnippet')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add( 'osyo-manga/vim-stargate', {
        \ 'on_ft' : ['cpp']
        \ })
  call dein#add('jpalardy/vim-slime')
  call dein#add('troydm/easybuffer.vim')
  call dein#add('osyo-manga/vim-over')
  call dein#add('vim-scripts/nginx.vim')
  call dein#add('rollxx/vim-antlr')
  "call dein#add('https://bitbucket.org/kovisoft/slimv')
  " git
  call dein#add('tpope/vim-fugitive')
  " ruby
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-endwise')
  call dein#add('kana/vim-textobj-user')
  call dein#add('rhysd/vim-textobj-ruby')
  " c++
  call dein#add( 'vim-jp/cpp-vim', {
        \ 'on_ft': ['cpp']
        \})
  " javacomplete
  call dein#add('vim-scripts/javacomplete', {
        \   'build': 'javac autoload/Reflection.java'
        \})
  " python
  call dein#add('lambdalisue/vim-django-support', {
        \ "on_ft": ["python", "python3", "djangohtml"]
        \ })
  call dein#add('davidhalter/jedi-vim')
  call dein#add("lambdalisue/vim-pyenv", {
        \ "depends": ['jedi-vim'],
        \ "on_ft": ["python", "python3", "djangohtml"]
        \ })
  "" javascript / node.js
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('groenewege/vim-less')
  call dein#add('moll/vim-node')
  call dein#add('digitaltoad/vim-jade')
  "" Haskell
  call dein#add('kana/vim-filetype-haskell')
  call dein#add('eagletmt/ghcmod-vim')
  call dein#add('ujihisa/neco-ghc')
  call dein#add('ujihisa/ref-hoogle')
  call dein#add('ujihisa/unite-haskellimport')
  "" Scala
  call dein#add('derekwyatt/vim-scala')
  " html
  call dein#add('mattn/emmet-vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('hail2u/vim-css3-syntax')
  "call dein#add('AtsushiM/search-parent.vim')
  "call dein#add('AtsushiM/sass-compile.vim')
  call dein#add('othree/html5.vim')
  call dein#add('lilydjwg/colorizer')
  " css
  "call dein#add('skammer/vim-css-color')
  "" TypeScript
  call dein#add('leafgarland/typescript-vim', {
        \ 'on_ft': ['typescript']
        \})
  call dein#add('clausreinke/typescript-tools.vim', {
        \ 'on_ft' : ['typescript']
        \})
  "" gnuplot
  call dein#add('vim-scripts/gnuplot.vim')
  "" plantuml
  call dein#add('aklt/plantuml-syntax')
  "" colorscheme
  call dein#add('nanotech/jellybeans.vim')
  "call dein#add('vim-scripts/twilight')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('altercation/vim-colors-solarized')
  " golang
  call dein#add('fatih/vim-go')
  " LaTeX
  call dein#add('vim-latex/vim-latex')
  " ASM
  call dein#add('shiracamus/vim-syntax-x86-objdump-d')
  " Web
  call dein#add('mattn/webapi-vim')
  call dein#add('basyura/bitly.vim')
  " Twitter
  call dein#add('basyura/twibill.vim')
  call dein#add('basyura/TweetVim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"" ----- unite.vim -----
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

"" ----- neocomplete -----
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#auto_completion_start_length = 2
let g:neocomplete#manual_completion_start_length = 0
"let g:neocomplete#min_keyword_length = 3
"let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

let g:neocomplete#enable_auto_select = 1
let g:neocomplete#enable_refresh_always = 0

let g:neocomplcache_enable_quick_match = 1

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case  = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_auto_close_preview = 1
"let g:neocomplete#enable_ignore_case = 1
"let g:neocomplete#enable_fuzzy_completion = 0

"let g:neocomplete#auto_completion_start_length = 2
"let g:neocomplete#manual_completion_start_length = 0

let g:neocomplete#skip_auto_completion_time = ""

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

if !exists('g:neocomplete#sources#dictionary#dictionaries')
  let g:neocomplete#sources#dictionary#dictionaries = {}
endif
let dict = g:neocomplete#sources#dictionary#dictionaries

let g:neocomplete#sources#buffer#disabled_pattern = '\.log\|\.log\.\|\.jax\|Log.txt'
call neocomplete#custom_source('_', 'sorters',  ['sorter_length'])
call neocomplete#custom_source('_', 'matchers', ['matcher_head'])

"let g:neocomplete#sources#include#paths = {
"      \ 'cpp' : '.,/usr/include,/usr/include/c++/4.8.1,/usr/local/include'
"      \ }

"inoremap <expr><C-n>  pumvisible() ? '\<C-n>' : '\<C-x>\<C-u>\<C-p>'
"inoremap <expr><CR>   pumvisible() ? '\<C-n>' . neocomplete#close_popup()  : '<CR>'
"inoremap <expr><C-e>  pumvisible() ? neocomplete#close_popup() : '<End>'
"inoremap <expr><C-c>  neocomplete#cancel_popup()
"inoremap <expr><C-u>  neocomplete#undo_completion()
"inoremap <expr><C-h>  neocomplete#smart_close_popup().'\<C-h>'

"" ----- jedi-vim -----
autocmd vimrc FileType python setlocal omnifunc=jedi#completions
"let g:jedi#popup_select_first = 0
let g:jedi#auto_vim_configuration = 0
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" docstringは表示しない
autocmd vimrc FileType python setlocal completeopt-=preview
" 勝手に自動補完しない
let g:jedi#completions_enabled = 0

"" ----- vim-marching -----
let g:marching_enable_neocomplete = 1
let g:marching_clang_command_option="-std=c++1y"
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

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

"""" ----- neosnippet -----
""
""" Plugin key-mappings.
""imap <C-k>     <Plug>(neosnippet_expand_or_jump)
""smap <C-k>     <Plug>(neosnippet_expand_or_jump)
""xmap <C-k>     <Plug>(neosnippet_expand_target)
""
""" SuperTab like snippets behavior.
""imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
""\ "\<Plug>(neosnippet_expand_or_jump)"
""\: pumvisible() ? "\<C-n>" : "\<TAB>"
""smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
""\ "\<Plug>(neosnippet_expand_or_jump)"
""\: "\<TAB>"
""
""" For snippet_complete marker.
""if has('conceal')
""  set conceallevel=2 concealcursor=i
""endif

" ----- ultisnips -----
"  Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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
" Vim-LaTeX用にF6
autocmd vimrc FileType tex nnoremap <silent><F6> :QuickRun -mode n<CR>
autocmd vimrc FileType tex vnoremap <silent><F6> :QuickRun -mode v<CR>
" qr = QuickRun
ca qr QuickRun
" 出力結果のエスケープシーケンス変換
autocmd vimrc FileType quickrun AnsiEsc

"" quickfix
autocmd QuickFixCmdPost *grep* cwindow

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

" ----- caw -----
" \c でコメントアウト
nmap \c <Plug>(caw:zeropos:toggle)
vmap \c <Plug>(caw:zeropos:toggle)
" \C でコメントアウトの解除
nmap \C <Plug>(caw:zeropos:uncomment)
vmap \C <Plug>(caw:zeropos:uncomment)

" ----- auto-ctags -----
" 保存時に勝手にtagsファイルを作成する
let g:auto_ctags = 0
" tagsを作成するディレクトリを指定
let g:auto_ctags_directory_list = ['.git', '.svn']
" 作成されたtagsを別途読み取る
let g:auto_ctags_filetype_mode = 1

" ----- nginx.vim -----
autocmd vimrc BufRead,BufNewFile /etc/nginx/* set ft=nginx

" ----- gnuplot.vim ----
autocmd vimrc BufRead,BufNewFile *.plt set filetype=gnuplot

"" vim-antlr
autocmd BufRead,BufNewFile *.g :set syntax=antlr3

" ----- Vim-LaTeX -----
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Imap_UsePlaceHolders = 1
let g:Imap_DeleteEmptyPlaceHolders = 1
let g:Imap_StickyPlaceHolders = 0
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'pdf'
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_FormatDependency_pdf = 'dvi,ps,pdf'
let g:Tex_FormatDependency_ps = 'dvi,ps'
let g:Tex_CompileRule_pdf = 'ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'luajitlatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
let g:Tex_CompileRule_dvi = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_BibtexFlavor = 'upbibtex'
let g:Tex_MakeIndexFlavor = 'mendex -U $*.idx'
let g:Tex_UseEditorSettingInDVIViewer = 1
let g:Tex_ViewRule_pdf = 'xdg-open'
"let g:Tex_ViewRule_pdf = 'evince'
"let g:Tex_ViewRule_pdf = 'okular --unique'
"let g:Tex_ViewRule_pdf = 'zathura -s -x "vim --servername synctex -n --remote-silent +\%{line} \%{input}"'
"let g:Tex_ViewRule_pdf = 'qpdfview --unique'
"let g:Tex_ViewRule_pdf = 'texworks'
"let g:Tex_ViewRule_pdf = 'mupdf'
"let g:Tex_ViewRule_pdf = 'firefox -new-window'
"let g:Tex_ViewRule_pdf = 'chromium --new-window'
let g:tex_conceal=''

" ----- TweetVim -----
" ツイート内容は改行する
autocmd FileType tweetvim :set wrap

" after command
set showcmd

""" colorscheme """
colorscheme jellybeans

" colorschemeからの変更
highlight Comment ctermfg=70
hi CursorLine term=none cterm=none ctermbg=236
