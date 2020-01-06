#!/bin/bash
# Dock:自動的に隠す
defaults write com.apple.dock autohide -bool true
# Mission Control:ホットコーナー
# 左下で デスクトップ
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0
# 右下で Launchpad
defaults write com.apple.dock wvous-br-corner -int 11
defaults write com.apple.dock wvous-br-modifier -int 0
# スリープとスクリーンセーバの解除にパスワードを要求
defaults write com.apple.screensaver askForPassword -bool true
# パスワードを要求するまでの秒数
defaults write com.apple.screensaver askForPasswordDelay -int 5
# タップでクリックを許可
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# カーソルの移動速度を変更 （1〜15）
defaults write -g com.apple.trackpad.scaling -float 10

# Finder:隠しファイル/フォルダを表示
defaults write com.apple.finder AppleShowAllFiles true

# Finder:拡張子を表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# スクロールバーを常に表示
defaults write -g AppleShowScrollBars -string "Always"

# カーソルの移動速度を変更 （1〜15）
defaults write -g com.apple.trackpad.scaling -float 15

# Dockの位置を右に
defaults write -g com.apple.dock orientation right

# バッテリーの残量のパーセンテージ表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# SafariのコンテキストメニューにWebインスペクタを表示する
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# USBやネットワークストレージに.DS_Storeを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dockの表示の待ち時間とアニメーションスピードを速く
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15

# タップしたときに、クリックとする
defaults write -g com.apple.mouse.tapBehavior -int 1

# 3本指でmission control & expose
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.dock showDesktopGestureEnabled -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool true

# tabなどでMacのボタンのフォーカスを変えられるフルコントロールを設定
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Launchpadのアニメーションをoffに
defaults write com.apple.dock springboard-show-duration -int 0
defaults write com.apple.dock springboard-hide-duration -int 0

# ツールチップの表示速度を速く
defaults write -g NSInitialToolTipDelay -integer 100

# Finderのタイトルにフルパスを表示する
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# 検索時にデフォルトでカレントディレクトリを検索する
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ファイルのダウンロード後に自動でファイルを開くのを無効化する
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# 検索クエリをAppleへ送信しない
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari UniversalSearchEnabled -bool false

# スクリーンショットの保存形式を PNG にする
defaults write com.apple.screencapture type -string "png"

# Dashboardの無効化
defaults write com.apple.dashboard mcx-disabled -boolean true

killall Dock
killall SystemUIServer
killall Finder

echo "---------- zplug ----------"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
exec $SHELL -l
echo "---------- END ----------"

ln -s dotfiles/.gitconfig ~
ln -s dotfiles/.gitignore_global ~
ln -s dotfiles/.zshrc ~
ln -s dotfiles/.zprofile ~
ln -s dotfiles/right_prompt.zsh ~
ln -s dotfiles/.tmux.conf ~
ln -s dotfiles/.vimrc ~
exec $SHELL -l

echo "---------- anyenv ----------"
anyenv --version
anyenv init
anyenv install rbenv
rbenv --version
anyenv install nodenv
nodenv --version
rbenv install $(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
nodenv install $(nodenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
echo "---------- END ----------"
