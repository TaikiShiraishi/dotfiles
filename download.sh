#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

#
# Install homebrew.
#
if ! command_exists brew ; then
  echo "---------- Homebrew ---------"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade
  brew cleanup
  brew -v
  echo "---------- END ----------"
fi


#
# Install git.
#
if ! command_exists git ; then
  echo "---------- Git ----------"
  brew install git
  git --version
  echo "---------- END ----------"
fi

#
# Clone my dotfiles
#
echo "--------- dotfiles.git ----------"
git  clone https://github.com/TaikiShiraishi/dotfiles.git
echo "---------- END ----------"
