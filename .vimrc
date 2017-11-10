let g:hybrid_use_iTerm_colors = 1
" colorscheme molokai
" colorscheme materialbox
" colorscheme material-theme
colorscheme atom-dark-256
set background=dark
syntax on
" 文字エンコーディング設定
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
"backspaceを有効化
set backspace=indent,eol,start
" vimのコピペをクリップボードと連携
set clipboard=unnamed,autoselect
"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
"行数の表示
set number
set cursorline " 行の強調
set t_Co=256
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=235
" NERDTreeで隠しファイルを表示するか
let NERDTreeShowHidden = 1
" NERDTreeで行番号を表示する
let NERDTreeShowLineNumbers=1
" NERDTreeの横幅
let g:NERDTreeWinSize=32
" NERDTreeの無視リスト
let g:NERDTreeIgnore=['\.DS_Store$', '\.git$', '\.svn$', '\.clean$', '\.swp$', '\.bak$', '\.hg$', '\.hgcheck$', '\~$']
let g:vimfiler_as_default_explorer = 1 "vim標準のファイラを置き換える
"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" markdownの折りたたみなし
let g:vim_markdown_folding_disabled=1
" 対応する括弧を強調
set showmatch
" ヘルプを画面いっぱいに開く
set helpheight=999
" 不可視文字を表示
set list
"不可視文字の表示記号指定
set listchars=tab:▸\ ,extends:❯,precedes:❮
" 保存されていないファイルが有るときは終了前に保存確認
set confirm
"保存されていないファイルがあるときでも別のファイルを開くことが出来る
set hidden
" 外部でファイルに変更がされた場合は読みなおす
set autoread
"ファイル保存時にバックアップファイルを作らない
set nobackup
"ファイル編集中にスワップファイルを作らない
set noswapfile
"検索文字列をハイライトする
set hlsearch
"インクリメンタルサーチを行う
set incsearch
"大文字と小文字を区別しない
set ignorecase
"大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set smartcase
"最後尾まで検索を終えたら次の検索で先頭に移る
set wrapscan
"タブ入力を複数の空白入力に置き換える
set expandtab
"画面上でタブ文字が占める幅
set tabstop=2
"自動インデントでずれる幅
set shiftwidth=2
"連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2
"改行時に前の行のインデントを継続する
set autoindent
"括弧の対応表示時間
set showmatch matchtime=1
" statuslineの設定
set statusline=2
"ステータスラインに文字コードと改行文字を表示する
" set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" 全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" 無限Undo
if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

" カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
imap ** **<left>

" 最後の編集位置でファイルを開く
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" vim養成ギブスのテキストファイルパス
let g:gips_reading_txt = '$HOME/.vim/bundle/gips-vim/autoload/dict/tsundere.txt'
" -----------------------------------
" vim-plug
" -----------------------------------
if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

  " ---------------------------------------
  " vim util
  " ---------------------------------------
  "インデントを可視化
  Plug 'nathanaelkane/vim-indent-guides'
  " Emmet
  Plug 'mattn/emmet-vim'
  " ツリー型ファイラー
  Plug 'scrooloose/nerdtree', { 'on' : ['NERDTreeToggle']}
  " コメントON/OFFを手軽に実行
  Plug 'tomtom/tcomment_vim'
  " ログファイルを色づけしてくれる
  Plug 'vim-scripts/AnsiEsc.vim'
  " vimのテキストオブジェクトを拡張する
  Plug 'tpope/vim-surround'
  " URLを開いたりググったりする
  Plug 'tyru/open-browser.vim'
  " vimproc
  Plug 'Shougo/vimproc', {
  \ 'build': {
  \   'mac' : 'make'
  \  },
  \}
  " Markdown
  Plug 'plasticboy/vim-markdown'
  " ブラウザを自動更新する
  Plug 'tell-k/vim-browsereload-mac'
  Plug 'kannokanno/previm'
  Plug 'tyru/open-browser.vim'
  " 入力補完
  Plug 'Shougo/neocomplcache'
  " vim養成ギプス
  " Plug 'Shougo/neocomplete.vim', { 'on' : ['gips_reading_txt'] }
  " statusbarツール
  Plug 'bling/vim-airline'
  " アイコン表示
  " Plug 'ryanoasis/vim-devicons'
  " twitter
  " Plug 'basyura/TweetVim'
  " color scheme
  Plug 'jdkanani/vim-material-theme', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'gosukiwi/vim-atom-dark', {'do': 'cp colors/* ~/.vim/colors/'}
  Plug 'mattn/webapi-vim'
  Plug 'basyura/twibill.vim'
  Plug 'tyru/open-browser.vim'
  Plug 'h1mesuke/unite-outline'
  Plug 'basyura/bitly.vim'
  Plug 'Shougo/unite.vim'
  " Elm用
  Plug 'elmcast/elm-vim'
  " ----------------------------------------
  "  lang syntax
  " ----------------------------------------
  " css3のシンタックス
  Plug 'hail2u/vim-css3-syntax'
  " html5のシンタックス
  " Plug 'taichouchou2/html5.vim'
  " javascriptのシンタックス
  Plug 'jelera/vim-javascript-syntax'
  " シンタックスチェッカー
  Plug 'scrooloose/syntastic'
  " pugシンタックス
  Plug 'digitaltoad/vim-pug'
  " ---------------------------------------
  "  sinippets
  " ---------------------------------------
  " vimでスニペットが使えるようになる
  Plug 'Shougo/neosnippet'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'garbas/vim-snipmate'
  Plug 'shuvalov-anton/vim-snippets'
  " javascriptの補完
  Plug 'jiangmiao/simple-javascript-indenter'
  Plug 'mattn/jscomplete-vim'
  " jQueryのスニペット
  Plug 'vim-scripts/jQuery'
  " ---------------------------------------
  " text edit
  " ---------------------------------------
  " =を揃える
  Plug 'junegunn/vim-easy-align'
  " カッコとか'で選択範囲のワードをラップ
  Plug 'tpope/vim-surround'
  " 行末の空白を削除
  Plug 'bronson/vim-trailing-whitespace'
  " ---------------------------------------
  " text edit
  " ---------------------------------------
  " 独自スニペットを実装
  Plug 'Shougo/neosnippet-snippets'
call plug#end()


" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" emmet setting

let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<c-t>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
    \ 'variables':{
    \    'lang' : 'ja',
    \ },
    \ 'html' : {
    \   'filters' : 'html',
    \ },
    \ 'css' : {
    \   'filters' : 'fc',
    \ },
    \ 'php' : {
    \   'extends' : 'html',
    \   'filters' : 'html',
    \ },
    \}
augroup EmmitVim
  autocmd!
  autocmd FileType * let g:user_emmet_settings.indentation = '    '[:&tabstop]
augroup END

" リロード後に戻ってくるアプリ 変更してください
let g:returnApp = "Terminal"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>
nmap <Space>bs :SafariReloadStart<CR>
nmap <Space>bS :SafariReloadStop<CR>
nmap <Space>bo :OperaReloadStart<CR>
nmap <Space>bO :OperaReloadStop<CR>
nmap <Space>ba :AllBrowserReloadStart<CR>
nmap <Space>bA :AllBrowserReloadStop<CR>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" Markdonw Setting
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open'

" neocomplcache設定
"" Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
    \ }


"-----------------------------
" easy align
"----------------------------
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-airline
let g:airline#extensions#tabline#enabled = 1 "tabline表示

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 検索ハイライトをesc2回で消す
nnoremap <ESC><ESC> :nohlsearch<CR>
vnoremap <silent> > >gv
vnoremap <silent> < <gv

"----------------------------------------
"  vim-trailing-whitespace
"----------------------------------------
autocmd BufWritePre * :%s/\s\+$//ge
