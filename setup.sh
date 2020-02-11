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

$0


exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

  brew install llvm # for clangd
brew install coreutils
fi

shopt -s extglob
shopt -s dotglob

ln -s $(realpath $(dirname "$0"))/files/*/!(config|..|.) ~/
mkdir -p ~/.config
ln -s $(realpath $(dirname "$0"))/config/!(..|.) ~/.config

cd ~/.fzf && ./install --all
vim +PlugInstall +qall
~/.tmux/plugins/tpm/bin/install_plugins


