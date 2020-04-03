#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"*  ]]; then

  while true; do
    read -p "Have you upgraded bash and installed homebrew?" yn
    case $yn in
      [Yy]* ) break;; 
      [Nn]* ) 
        BASH_PATH=/usr/local/bin/bash
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install bash

        if (which -a bash | grep -Fxq "$BASH_PATH")
        then
          echo "Bash installed successfully"
        else
          echo "Bash installation failed"
          exit
        fi

        echo $BASH_PATH | sudo tee -a /etc/shells
        chsh -s /usr/local/bin/bash

        # Rerun the script with the new bash
        $0

        exit;;
      * ) echo "Please answer yes or no.";;
    esac
  done

  brew install llvm # for clangd
  brew install coreutils
  brew install tmux
  brew install bash-completion@2
  brew tap homebrew/cask-fonts
  brew cask install font-source-code-pro-for-powerline

fi

shopt -s extglob

ln -s $(realpath $(dirname ./setup.sh))/files/**/{.[^.]*,?} ~/
mkdir -p ~/.config
ln -s $(realpath $(dirname "$0"))/config/{,} ~/.config

cd ~/.fzf && ./install --all
vim +PlugInstall +qall
~/.tmux/plugins/tpm/bin/install_plugins


