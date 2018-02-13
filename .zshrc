export PATH=/usr/local/bin:$PATH
source ~/right_prompt.zsh

# 日本語を使用
export LANG=ja_JP.UTF-8

# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

#
# Kaoriya Vim ---------------------------------------------------
#
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi=vim

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
# odは16進数でのバイナリダンプコマンド
# -tx1zは、1バイトごとに区切って表示
# -Axはアドレスを16進数表示、-vは連続する0をスキップしない
#
alias od='od -tx1z -Ax -v'


#
# ls -------------------------------------------------------------
#
alias ll='ls -la'


#
# lsのカラー化
#
#export LS_COLORS='no=01;37:fi=00:di=01;36:ln=01;32:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;32;01:ex=01;33:*core=01;31:'
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'

# cdの後にlsを実行
chpwd() { ll -tr }

#
# colordiffのエイリアス
#
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# -----------------------
# anyenv
# -----------------------
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/share/anyenv-install`
  do
    export PATH="$HOME/.anyenv/share/anyenv-install/$D/shims:$PATH"
  done
fi

# direnv setting
eval "$(direnv hook zsh)"

#
# zplug -----------------------------------------------------------
#
source ~/.zplug/init.zsh

# 「ユーザ名/リポジトリ名」で記述し、ダブルクォートで見やすく括る（括らなくてもいい）
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

# junegunn/dotfiles にある bin の中の vimcat をコマンドとして管理する
zplug "junegunn/dotfiles", as:command, use:bin/vimcat

# tcnksm/docker-alias にある zshrc をプラグインとして管理する
# as: のデフォルトは plugin なので省力もできる
zplug "tcnksm/docker-alias", use:zshrc, as:plugin

# frozen: を指定すると全体アップデートのときアップデートしなくなる（デフォルトは0）
zplug "k4rthik/git-cal", as:command, frozen:1

# from: で特殊ケースを扱える
# gh-r を指定すると GitHub Releases から取ってくる
# of: で amd64 とかするとそれを持ってくる（指定しないかぎりOSにあったものを自動で選ぶ）
# コマンド化するときに file: でリネームできる（この例では fzf-bin を fzf にしてる）
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:fzf

# from: では gh-r の他に oh-my-zsh と gist が使える
# oh-my-zsh を指定すると oh-my-zsh のリポジトリにある plugin/ 以下を
# コマンド／プラグインとして管理することができる
zplug "plugins/git", from:oh-my-zsh

# ビルド用 hook になっていて、この例ではクローン成功時に make install する
# シェルコマンドなら何でも受け付けるので "echo OK" などでも可
zplug "tj/n", hook-build:"make install"

# ブランチロック・リビジョンロック
# at: はブランチとタグをサポートしている
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# if: を指定すると真のときのみロードを行う（クローンはする）
zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"

# from: では gist を指定することができる
# gist のときもリポジトリと同様にタグを使うことができる
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
# zplug load --verbose
source ~/.tmuxinator/tmuxinator.zsh


#
# 起動時にtmuxに -------------------------------------------------
#
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
