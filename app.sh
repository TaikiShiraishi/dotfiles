#!/bin/bash
#
# Install web apps
#
brew cask install adguard
brew cask install adobe-creative-cloud
brew cask install alfred
brew cask install appcleaner
brew cask install atom
brew cask install brave-browser
brew cask install clipy
brew cask install cursorsense
brew cask install docker
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install google-drive-file-stream
brew cask install karabiner-elements
brew cask install notion
brew cask install pomotodo
brew cask install scroll-reverser
brew cask install sketch
brew cask install spectacle
brew cask install spotify
brew cask install tunnelblick
brew cask install typora
brew cask install virtualbox
brew cask install visual-studio-code

while true; do
  read -p 'Add "need license" app? [Y/n]' Answer
  case $Answer in
    '' | [Yy]* )
      brew cask install webstorm
      brew cask install microsoft-office
      break;
      ;;
    [Nn]* )
      echo "Skip install"
      break;
      ;;
    * )
      echo Please answer YES or NO.
  esac
done;
echo "---------- END -----------"
