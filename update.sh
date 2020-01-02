#!/bin/bash
#
# repository update
git checkout  master
git pull origin master

#
# Homebrew update and upgrade
#
brew upgrade --creanup

#
# Homebrew Cask check and upgrade
#
brew cask outdated
brew cask upgrade

#
# App Store app upgrade
#
mas upgrade

