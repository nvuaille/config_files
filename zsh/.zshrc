# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="custom-gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$HOME/.custom_config/zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# set GCC_COLORS.
export GCC_COLORS="error=01;31:warning=01;33:note=01;36:range1=01:range2=34:locus=33:\
quote=01:fixit-insert=01;31:fixit-delete=31:\
diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32:\
type-diff=01;32"

# default values for GCC_COLORS:
# error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=01:\
# quote=01:fixit-insert=32:fixit-delete=31:\
# diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32:\
# type-diff=01;32


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# build-related
alias make="make --no-print-directory"
# force color with ninja
export CXXFLAGS="-fdiagnostics-color=always"
export CFLAGS="-fdiagnostics-color=always"

# defined by zsh but also stand for the Git Repo Viewer
unalias grv

# fancy ls
unalias l
alias l="lsd -l"

# Give time to feh to convert (useful for svg)
alias feh="feh --conversion-timeout 5"

# ParaView
alias pv="./bin/paraview -stylesheet=/home/nicolas/ParaView/Utilities/dark_style.qss"
alias ipvpython="PYTHONPATH=${PYTHONPATH}:/home/nicolas/ParaView/paraview/build/lib/python3.8/site-packages ipython"

# Fzf 
alias fzf="fzf -m"
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# vifm
export PATH="${PATH}:/home/nicolas/Softwares/vifmimg"
alias v='vifmrun .'

# alias tmux for colors : https://unix.stackexchange.com/a/355391
alias tmux="tmux -2"

# Color scheme
# wal --theme base16-materialer
# wal --theme base16-gruvbox-hard
# wal --theme base16-material

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

# reset files timestamp to their last git modif
# usage  resetToGitTime vtkSetGet.h
resetToGitTime(){ local f;for f;do touch -d @0`git log --pretty=%at -n1 -- "$f"` "$f"; done;};

# autojump
source /etc/profile.d/autojump.sh

# export PATH="/home/nicolas/Softwares/anaconda3/condabin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/nicolas/Softwares/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/nicolas/Softwares/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/nicolas/Softwares/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/nicolas/Softwares/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
