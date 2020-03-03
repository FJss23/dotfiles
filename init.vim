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
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mattn/emmet-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

set title                 " Muestra el nombre del archivo en la ventana de la terminal
set mouse=a               " Permite la integracion del mouse
set termguicolors         " Activa true colors en la terminal
set number		  " Activa el numero de linea

colorscheme nord
:imap jj <Esc>

let g:airline_solarized_bg='dark'

map <Space> <Leader>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap H gT
nnoremap L gt

let g:prettier#autoformat = 0
let g:prettier#autoformat_require_pragma = 0
" when running at every change you may want to disable quickfix

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi

inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>

nnoremap <Leader>e A
nnoremap <Leader>b _i
inoremap <Tab>e <Esc>ea
