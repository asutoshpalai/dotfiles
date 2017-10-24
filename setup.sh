#!/usr/bin/env bash
shopt -s extglob
ln -s $(realpath $(dirname "$0"))/*/!(..|.) ~/

cd ~/.fzf && ./install --all
vim +PlugInstall +qall
~/.tmux/plugins/tpm/bin/install_plugins
