#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -G'
alias grep='grep --color=auto'
alias hublog='tail -f /var/log/httpd/hub.error.log'
alias pacupg='sudo pacman -Syu'
alias pacins='sudo pacman -S --needed'
alias aurins='pacaur -u'
alias wifi='sudo iw dev wlp9s0'
alias upmirror='sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && sudo -E reflector --verbose -l 200 --sort rate --save /etc/pacman.d/mirrorlist'
alias upmirrorh='sudo -E reflector --verbose -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
PS1='[\u@\h \W]\$ '
alias ssh='ssh -o ServerAliveInterval=60'
alias avenv='source venv/bin/activate'
alias down='aria2c -x10 -s10 -j10 -c --file-allocation=none'
alias bingo='fortune | $(echo -e "cowsay\ncowthink" | shuf -n1) -f $(for w in `cowsay -l` ; do echo $w ; done | sed '1,4d' | shuf -n1)'
alias cdt='cd `mktemp -d`'
alias nhm='cdt; export HOME=`pwd`'
alias lexec='sbcl --quit --load '   # before I met --script :P
alias plfx='peerflix -f "$(pwd)" -k'
export PATH=$HOME/xdman:$PATH

gpp()
{
  g++ -g $1 && ./a.out
}

nvenv() {
  python3 -m venv ~/.venvs/$1;
  source ~/.venvs/$1/bin/activate
}

nvenv2() {
  virtualenv2 ~/.venvs/$1;
  source ~/.venvs/$1/bin/activate
}

venv() {
  source ~/.venvs/$1/bin/activate
}

diffdir() {
  diff  -ENwbur $@ | vim -R -
}

export NVM_DIR=~/.nvm
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

##############################################
# Lazy load nvm
##############################################

if [ -d "$NVM_DIR" ]; then
  declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

  NODE_GLOBALS+=("node")
  NODE_GLOBALS+=("nvm")

  load_nvm () {
      export NVM_DIR=~/.nvm
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  }

  for cmd in "${NODE_GLOBALS[@]}"; do
      eval "${cmd} () { unset -f ${NODE_GLOBALS[@]}; load_nvm; ${cmd} \$@; }"
  done
fi
##############################################


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe  ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt"  ]; then
  if [ -x /usr/bin/tput  ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes  ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors  ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0  ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases  ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion  ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion  ]; then
    . /etc/bash_completion
  elif [ -f /usr/local/etc/profile.d/bash_completion.sh  ]; then # macOS
    . "/usr/local/etc/profile.d/bash_completion.sh"
  fi
fi

export GOPATH=~/go
export PATH=~/go/bin:$PATH

# composer global install modules
export PATH=$PATH:~/.config/composer/vendor/bin

export PATH=$PATH:~/bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm"  ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Meet the sweet git helpers
#[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
eval "$(scmpuff init -s)"
scmpuff_cmds=(vim rm bat)
for cmd in "${scmpuff_cmds[@]}"; do
  #echo "export SCMPUFF_${cmd}_CMD=\"$(\which $cmd)\";${cmd} () { eval \"\$(scmpuff expand -- \"\$SCMPUFF_${cmd}_CMD\"  \$@ )\"; }"
  eval "export SCMPUFF_${cmd}_CMD=\"$(\which $cmd)\";${cmd} () { eval \"\$(scmpuff expand -- \"\$SCMPUFF_${cmd}_CMD\"  \$@ )\"; }"
done
alias gc='git commit'
alias gf='git fetch'
alias gb='git branch'
#alias gd='git diff --color-words="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'
alias gd='git diff'

[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

export PATH="$HOME/.cargo/bin:$PATH"

if [ -x ~/.vim/plugged/fzf.vim/bin/preview.sh  ]; then
  export FZF_CTRL_T_OPTS="--preview '~/.vim/plugged/fzf.vim/bin/preview.sh {} | head -200'"
fi

export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

macos_ramdisk() {
  ramdisk_size=$((2048 * $1))
  diskutil erasevolume HFS+ 'RAM Disk' `hdiutil attach -nobrowse -nomount ram://$ramdisk_size`
}

# courtesy https://dev.to/zanehannanau/bash-lazy-completion-evaluation-2a2d 
# arg 1: command for which completion is being initialized
# arg 2: completion function after initialization of completion.
#       this can be found by running `complete -p <arg 1>` after running
#       the initialization code.
function __lazyfunc {
  local target="$1"
  shift
  local fn="$1"
  shift

  if [[ -z "$(type -t $fn)" || $LAZYFUNC_FORCE_REDEFINE  ]]; then
    eval "$fn () { unset -f $fn ; eval \"\$( $@  )\" ; $fn \$@ ;  }"
    complete -o default -F "$fn" "$target"
  fi
}

__lazyfunc sheepctl __start_sheepctl sheepctl completion bash
__lazyfunc kubectl __start_kubectl kubectl completion bash
__lazyfunc eksctl __start_eksctl eksctl completion bash

if [ -f ~/.bashrc_local  ]; then
  . ~/.bashrc_local
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
