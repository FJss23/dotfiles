
export ZSH="/home/fjss23/.oh-my-zsh"
export FZF_DEFAULT_COMMAND='rg --files --hidden --ignore-vcs'

ZSH_THEME="bira"
ENABLE_CORRECTION="true"

plugins=(git zsh-autosuggestions gitignore command-not-found)

source $ZSH/oh-my-zsh.sh

alias nv="nvim" 
alias nvz="nvim ~/.zshrc"
alias nvi="nvim ~/.config/nvim/init.vim"
alias nva="nvim ~/.config/alacritty/alacritty.yml"
