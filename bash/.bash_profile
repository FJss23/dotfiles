HOST_NAME=frandev

export PATH=$PATH:$HOME/bin

txtred='\e[0;96m' 
txtgrn='\e[0;31m' 
bldpur='\e[1;35m'  
txtrst='\e[0m'     

EMOJI=🚀

print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir 🌱" "$(vcprompt)"
}

PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PS1=" $EMOJI > "
