" カラーテーマ
colorscheme one
set background=light
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
" 行の強調
set cursorline
"set t_Co=256
" highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=235
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
" ctags定義
set tags+=.tags,.git/tags
" コマンドモードを抜ける時にIMEをOFFにする Kaoriya限定
set imdisable
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

" ノーマルモード切り替え時にIMEをOFFに
" @see https://rcmdnk.com/blog/2017/03/10/computer-mac-vim/
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
  noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
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
let g:gips_reading_txt = '$HOME/.vim/plugged/gips-vim/autoload/dict/tsundere.txt'
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
  " vimproc
  Plug 'Shougo/vimproc', {
  \ 'build': {
  \   'mac' : 'make'
  \  },
  \}
  " Markdown
  Plug 'plasticboy/vim-markdown'
  Plug 'kannokanno/previm'
  Plug 'tyru/open-browser.vim'
  " 入力補完
  " Plug 'Shougo/neocomplcache'
  " statusbarツール
  Plug 'bling/vim-airline'
  " color scheme
  Plug 'rakr/vim-one', {'do': 'cp colors/* ~/.vim/colors/'}
  " git
  Plug 'tpope/vim-fugitive'
  " vim養成ギプス
  Plug 'modsound/gips-vim'
  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " prettier
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'branch': 'release/1.x',
    \ 'for': [
      \ 'javascript',
      \ 'typescript',
      \ 'css',
      \ 'less',
      \ 'scss',
      \ 'json',
      \ 'graphql',
      \ 'markdown',
      \ 'vue',
      \ 'angular',
      \ 'php',
      \ 'html'] }
  " ----------------------------------------
  "  languages
  " ----------------------------------------
  "  JavaScript
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
  " ----------------------------------------
  "  lang syntax
  " ----------------------------------------
  " PlantUmlのハイライト
  Plug 'aklt/plantuml-syntax'
  " モダンなJSのハイライト
  Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  " テンプレートリテラルのハイライト
  Plug 'Quramy/vim-js-pretty-template'
  " ---------------------------------------
  "  sinippets
  " ---------------------------------------
  " ---------------------------------------
  " text edit
  " ---------------------------------------
  " =を揃える
  Plug 'junegunn/vim-easy-align'
  " カッコとか'で選択範囲のワードをラップ
  Plug 'tpope/vim-surround'
  " 行末の空白を削除
  Plug 'bronson/vim-trailing-whitespace'
call plug#end()
" ---------------------------------------
" Prettier auto save setting
" ---------------------------------------
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" vim-oneのサポート設定
set t_8b=^[[48;2;%lu;%lu;%lum
set t_8f=^[[38;2;%lu;%lu;%lum

" yajs Setting
augroup YAJS
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript
  autocmd BufRead,BufNewFile *.js set filetype=javascript
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" ---------------------------------------
" Intellisense Setting
" ---------------------------------------
" メッセージ表示欄を2行確保
set cmdheight=2
" タイピング停止からプラグインの反応までの時間
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" ---------------------------------------
" End Intellisense Setting
" ---------------------------------------

" 検索で自動的にquickfix-windowを開く
autocmd QuickFixCmdPost *grep* cwindow

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
" let g:neocomplete#enable_at_startup = 1
" Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : ''
"     \ }
"

"-----------------------------
" easy align
"----------------------------
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-airline
let g:airline#extensions#tabline#enabled = 1 "tabline表示
let g:airline_theme='one'

" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplcache#undo_completion()
" inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplcache#smart_close_popup() . "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 検索ハイライトをesc2回で消す
nnoremap <ESC><ESC> :nohlsearch<CR>
vnoremap <silent> > >gv
vnoremap <silent> < <gv
" 空行挿入
" nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

"----------------------------------------
"  vim-trailing-whitespace
"----------------------------------------
autocmd BufWritePre * :%s/\s\+$//ge
