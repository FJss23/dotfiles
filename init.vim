call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'  
Plug '~/.fzf'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'sheerun/vim-polyglot'
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

map <F2> :NERDTreeToggle<CR>
map <Space> <Leader>

nnoremap <C-p> :FZF<CR>

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set signcolumn=yes

