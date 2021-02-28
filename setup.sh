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
# Symbolic link dotfiles
#
DOTPATH=~/dotfiles
for f in .??*
do
  [ "$f" = ".git" ] && continue
  ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
# DOT_FILES=(.gitconfig .gitignore_global .zshrc .zprofile .vimrc .tmux.conf left_prompt.zsh right_prompt.zsh)
# for file in ${DOT_FILES[@]} do
#   ln -s $HOME/dotfiles/$file $HOME/
# done

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

#
# Install Tmux Plugin Manager
#
echo "---------- tpm ----------"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "---------- END ----------"
