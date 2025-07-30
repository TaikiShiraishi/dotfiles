#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

#
# Memorize user pass
#
read -sp "Your Password:" pass;

#
# Install homebrew.
#
if ! command_exists brew ; then
  echo "---------- Homebrew ---------"
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
# Install zsh
#
if command_exists zsh ; then
  echo "---------- zsh ----------"
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
  echo "---------- END ----------"
fi

#
# Install zprezto
#
echo "---------- zprezto ----------"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
echo "---------- END ----------"


echo "---------- zplug ----------"
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
exec $SHELL -l
echo "---------- END ----------"

#
# Install brew apps
#
echo "---------- brew ----------"
brew bundle
echo "---------- END ----------"

