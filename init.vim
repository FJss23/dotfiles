call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-airline/vim-airline'	
Plug 'vim-airline/vim-airline-themes'
" Plug '~/.fzf'
" Plug 'junegunn/fzf.vim'
" Plug 'neoclide/coc.nvim', {'branch':'release'}
" Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
" Plug 'preservim/nerdtree'
" Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mattn/emmet-vim'
Plug 'junegunn/seoul256.vim'
call plug#end()

set title                 " Muestra el nombre del archivo en la ventana de la terminal
set mouse=a               " Permite la integracion del mouse
set termguicolors         " Activa true colors en la terminal
set number		  " Activa el numero de linea

let g:seoul256_background = 234
colo seoul256

:imap jj <Esc>

let g:airline_theme = 'base16'

" map <F2> :NERDTreeToggle<CR>
map <Space> <Leader>

