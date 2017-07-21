if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# nodebrew path
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
