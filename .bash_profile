if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# nodebrew path
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# -----------------------
# anyenv
# -----------------------
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/share/anyenv-install`
  do
    export PATH="$HOME/.anyenv/share/anyenv-install/$D/shims:$PATH"
  done
fi

