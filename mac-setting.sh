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
