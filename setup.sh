#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

#
# Memorize user pass
#
read -sp "Your Password:" pass;

#
# Mac App Store apps install
#
if ! command_exists mas ; then
  echo "---------- Mac App Store apps ----------"
  brew install mas
  # Xcode
  mas install 497799835
  echo "---------- END ----------"
fi

#
# Install zsh
#
if ! command_exists zsh ; then
  echo "---------- zsh ----------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
  echo "---------- END ----------"
fi


#
# Vim
#
if ! command_exists vim ; then
  echo "---------- Vim ----------"
  brew install vim --with-override-system-vi
  echo "---------- END ----------"
fi

#
# Install Ricty Diminished
#
echo "---------- Ricty Diminished ----------"
git clone https://github.com/mzyy94/RictyDiminished-for-Powerline.git
cp RictyDiminished-for-Powerline/Ricty*.ttf ~/Library/Fonts/
cp RictyDiminished-for-Powerline/vim-powerline-fontpatched/Ricty*.ttf ~/Library/Fonts/
fc-cache -f
echo "---------- END -----------"

#
# Install Yarn
#
if ! command_exists yarn ; then
  echo "---------- Yarn ----------"
  brew install yarn
  echo "----------- END ------------"
fi

#
# Install anyenv
#
if ! command_exists anyenv ; then
  echo "---------- Anyenv ----------"
  brew install anyenv
  echo "---------- END ----------"
fi


#
# Install wget
#
if ! command_exists wget ; then
  echo "---------- wget ----------"
  brew install wget
  wget --version
  echo "---------- END ----------"
fi

#
# Install jq
#
if ! command_exists jq ; then
  echo "---------- jq ----------"
  brew install jq
  jq --veriosn
  echo "---------- END ----------"
fi

#
# Install tree
#
if ! command_exists tree ; then
  echo "---------- tree ----------"
  brew install tree
  tree --version
  echo "---------- END ----------"
fi

#
# Install tmux
#
if ! command_exists tmux ; then
  echo "---------- tmux ----------"
  brew install tmux
  tmux --version
  echo "--------- END ----------"
fi
