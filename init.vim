call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

set relativenumber
set cursorline

:imap jj <Esc>

let g:airline#extensions#tabline#enabled = 1
