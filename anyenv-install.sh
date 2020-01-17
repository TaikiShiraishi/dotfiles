#!/bin/bash
echo "---------- anyenv ----------"
git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
anyenv --version
anyenv init
anyenv install rbenv
rbenv --version
anyenv install nodenv
nodenv --version
rbenv install $(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
nodenv install $(nodenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
echo "---------- END ----------"
