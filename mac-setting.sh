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

killall Dock
killall SystemUIServer
killall Finder

ln -s dotfiles/.gitconfig ~/.gitconfig
ln -s dotfiles/.gitignore_global ~/.gitconfig
ln -s dotfiles/.zshrc ~/.zshrc
ln -s dotfiles/.zprofile ~/.profile
ln -s dotfiles/right_prompt.zsh ~/right_prompt.zsh
ln -s dotfiles/.tmux.conf ~/.tmux.conf
ln -s dotfiles/.vimrc ~/.vimrc
