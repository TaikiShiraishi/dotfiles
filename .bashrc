#
# .bashrc
#

# プロンプトにマシン名(\h)とカレントのフルパス(\w)を表示
#
#PS1="\[[\u@\h \W]\\$ \]"

#
# Kaoriya Vim ---------------------------------------------------
#
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'


#
# grep -----------------------------------------------------------
#
# GREP_COLORは、検索ワードを色づけするために使用。
# 色づけすると、視認性が格段にあがる。
# -Eオプションは、拡張正規表現を使用する場合に指定
#
export GREP_COLOR='1;37;41'
alias grep='grep -E --color=auto'

#
# Openssl --------------------------------------------------------
#
OPENSSL_PATH=/usr/local/opt/openssl
if [ -d "$OPENSSL_PATH" ];then
  export LD_LIBRARY_PATH=$OPENSSL_PATH/lib:$LD_LIBRARY_PATH
  export CPATH=$OPENSSL_PATH/include:$LD_LIBRARY_PATH
fi


#
# Aliases --------------------------------------------------------
#

#
# -iは確認を行う。-vは詳細な情報の表示。
#
#alias cp='cp -iv'
#alias rm='rm -iv'
#alias mv='mv -iv'

#
# odは16進数でのバイナリダンプコマンド
# -tx1zは、1バイトごとに区切って表示
# -Axはアドレスを16進数表示、-vは連続する0をスキップしない
#
alias od='od -tx1z -Ax -v'

#
# Git ----------------------------------------------------------
#
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '

#
# ls -------------------------------------------------------------
#
alias ll='ls -l'


#
# lsのカラー化
#
#export LS_COLORS='no=01;37:fi=00:di=01;36:ln=01;32:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;32;01:ex=01;33:*core=01;31:'
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'


#
# オリジナルのTERM=xtermはカラー表示できないと思われる。
#
if [ "$TERM" == xterm ]; then
  export TERM=xterm-color
fi

#
# EUC環境へssh接続する
#
alias sshe='cocot -t UTF-8 -p EUC-JP -- ssh'

#
# open -a のショートカット
#
alias opena='open -a'
alias gvim='open -a "MacVim"'

#
# colordiffのエイリアス
#
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi
