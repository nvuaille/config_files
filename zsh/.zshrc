#====================
# oh-my-zsh stuff
#====================

# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom-gnzh"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  git
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

#====================
# Custom commands, aliases and ENV
#====================

# Be sure to use Neovim :)
export EDITOR='nvim'
alias vim="nvim"

export DIFFPROG="nvim -d"

# build-related
alias make="make --no-print-directory"
# force color with ninja
export CXXFLAGS="-fdiagnostics-color=always"
export CFLAGS="-fdiagnostics-color=always"
export CMAKE_EXPORT_COMPILE_COMMANDS="ON"

# defined by oh-my-zsh but also stand for the Git Repo Viewer
unalias grv

# fancy ls
unalias l
alias l="lsd -l"

# Give time to feh to convert (useful for svg)
alias feh="feh --conversion-timeout 5"

# ParaView
# alias pv="./bin/paraview -stylesheet=/home/nicolas/ParaView/Utilities/dark_style.qss"
alias ipvpython="PYTHONPATH=${PYTHONPATH}:/home/nicolas/ParaView/releases/5.9.1/build/lib/python3.9/site-packages ipython"

# Fzf 
alias fzf="fzf -m"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# vifm
export PATH="${PATH}:/home/nicolas/Softwares/vifmimg"
alias v='vifmrun .'

# alias tmux for colors : https://unix.stackexchange.com/a/355391
alias tmux="tmux -2"

alias tt="taskwarrior-tui"

# autojump
source /etc/profile.d/autojump.sh

# reset files timestamp to their last git modif
# usage  resetToGitTime vtkSetGet.h
resetToGitTime(){ local f;for f;do touch -d @0`git log --pretty=%at -n1 -- "$f"` "$f"; done;};

# screenshot utils
alias fshot='flameshot gui -p /home/nicolas/Tmp'

# ==================== 
# Color scheme
# ==================== 

# use python wally and rebuild conf.
setTheme()
{
  wal --theme $1 $2
  source ~/.zshrc
  bat cache --build
}

darktheme()
{
  setTheme "base16-materialer" ""
}

lighttheme()
{
  setTheme "base16-gruvbox-hard" "-l"
}


source /home/nicolas/.config/broot/launcher/bash/br

# enable alias completion
autoload -Uz compinit; compinit;
bindkey "^Xa" _expand_alias
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true

