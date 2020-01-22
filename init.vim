" Plugins a descargar
call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

set title                 " Muestra el nombre del archivo en la ventana de la terminal
set relativenumber        " Muestra los numero relativos
set cursorline            " Resalta la linea actual
set mouse=a               " Permite la integracion del mouse
set termguicolors         " Activa true colors en la terminal

colorscheme dracula       " Activa el theme de colores
 
:imap jj <Esc>

let g:airline#extensions#tabline#enabled = 1          " Mostrar los buffers abiertos como pestañas
let g:airline#extensions#tabline#fnamemod = ':t'      " Muestra solo el nombre del archibo
