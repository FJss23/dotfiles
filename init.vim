" Plugins a descargar
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'  
Plug '~/.fzf'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'dense-analysis/ale'
call plug#end()

set title                 " Muestra el nombre del archivo en la ventana de la terminal
set cursorline            " Resalta la linea actual
set mouse=a               " Permite la integracion del mouse
set termguicolors         " Activa true colors en la terminal
set number		  " Activa el numero de linea

color onedark

:imap jj <Esc>

let g:airline#extensions#tabline#enabled = 1          " Mostrar los buffers abiertos como pestañas
let g:airline#extensions#tabline#fnamemod = ':t'      " Muestra solo el nombre del archibo

let g:coc_node_path = '/home/fjss23/node-v12.16.0-linux-64/bin/node'



