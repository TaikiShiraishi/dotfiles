#!/bin/bash
function command_exists {
  command -v "$1" > /dev/null;
}

#
# Memorize user pass
#
read -sp "Your Password:" pass;


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
