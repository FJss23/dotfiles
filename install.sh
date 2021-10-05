#!/bin/sh

echo 'Welcome to your script for recreating your enviroment'
echo 'Here are the list of packages that you should install: '

# CURL
echo 'curl ->  https://github.com/curl/curl -> install from source'

# STOW
echo 'stow -> https://www.gnu.org/software/stow/ -> install from apt'
echo 'You should use stow like this: $ stow --target=${HOME} nvim/'

# HTOP
echo 'htop -> https://github.com/htop-dev/htop -> install from apt'

# NEOFETCH
echo 'neofetch -> https://github.com/dylanaraps/neofetch -> install from apt'

# NVM - NODE 
echo 'nvm -> https://github.com/nvm-sh/nvm -> install with the script'

# SDKMAN - JAVA AND MAVEN
echo 'sdkman -> https://github.com/sdkman/sdkman-cli -> install with the script'

# RIPGREP
echo 'ripgrep -> https://github.com/BurntSushi/ripgrep -> install from apt'

# FD
echo 'fd -> https://github.com/sharkdp/fd -> install from apt'

# JETBRAINS MONO
echo 'JetBrains Mono -> https://github.com/JetBrains/JetBrainsMono -> install with the script'
