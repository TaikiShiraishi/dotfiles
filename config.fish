function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
# ndenv
set -x NDENV_ROOT "/Users/tshiraishi/.anyenv/envs/ndenv"
set -x PATH $PATH "/Users/tshiraishi/.anyenv/envs/ndenv/bin"
set -x PATH $NDENV_ROOT/shims $PATH
# rbenv
rbenv init - | source
set -x RBENV_ROOT "/Users/tshiraishi/.anyenv/envs/rbenv"
set -x PATH $PATH "/Users/tshiraishi/.anyenv/envs/rbenv/bin"
set -x  PATH $RBENV_ROOT/shims $PATH
