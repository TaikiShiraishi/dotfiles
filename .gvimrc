set langmenu=ja_jp.utf-8
set guifont=Source\ Han\ Code\ JP:h20
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
" set guifont=DroidSansMonoPLNerd:h12
colorscheme materialbox
set renderoptions=type:directx,renmode:5
" 縦幅　デフォルトは24
set lines=80
" 横幅　デフォルトは80
set columns=280
" タブを常に透明に表示
" set showtabline=2
" 透明度
" autocmd GUIEnter * set transparency=240
" ツールバー非表示
" set guioptions-=T
" ビープ音をオフ
set visualbell t_vb=
" airlinefontのサポート
" required if using https://github.com/bling/vim-airline
" let g:airline_powerline_fonts=1
" Vim終了時に現在のセッションを保存する
au VimLeave * mks!  ~/vimsession

"引数なし起動の時、前回のsessionを復元
autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | source ~/vimsession | endif
function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
        return 0
    else
        return byte - 1
    endif
endfunction
