#!/bin/bash

source .defaults.sh

export PS1="\u:\w\\$ "

alias nvim="~/nvim/nvim.appimage"
alias fd="fdfind"
alias efm-langserver="~/.efm-langserver/efm-langserver"
alias ssh='kitty +kitten ssh'
alias dot="cd ~/dotfiles"
alias proj="cd ~/Documents/github"

alias xs='exa --grid --color auto --icons --sort=type'
alias xl='exa --long --color always --icons --sort=type'
alias xa='exa --grid --all --color auto --icons --sort=type'
alias xla='exa --long --all --color auto --icons --sort=type'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPS="--extended"
export FZF_DEFAULT_COMMAND="fdfind --type f"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export GOROOT="$HOME/.asdf/installs/golang/1.17/go"
export GOPATH=$(go env GOPATH)
export PATH="$PATH:$(go env GOPATH)/bin"

export SDKMAN_DIR="/home/frandev/.sdkman"
[[ -s "/home/frandev/.sdkman/bin/sdkman-init.sh" ]] && source "/home/frandev/.sdkman/bin/sdkman-init.sh"

if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
. "$HOME/.cargo/env"
