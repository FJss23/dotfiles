call plug#begin('~/.local/share/nvim/plugged')

" Syntax highlight
Plug 'posva/vim-vue'
Plug 'tomasiser/vim-code-dark'

" Usability
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {'do':'npm install'}

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'preservim/nerdtree'

" Intellisense and Lint
" Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lsp'
call plug#end()

set title                 				" Muestra el nombre del arcqqhivo en la ventana de la terminal
set mouse=a               				" Permite la integracion del mouse
set termguicolors         				" Activa true colors en la terminal
set number		  				" Activa el numero de linea
set noshowmode		 				" Elimina la visualizacion del modo activo

syntax on
colorscheme codedark					" Activa el theme

let g:lightline = {					
      \ 'colorscheme': 'powerlineish',
      \ }						" Activa el theme de la barra de estado

let g:prettier#autoformat = 0				" Desactivamos opciones para farmetar cuando se guarda
let g:prettier#autoformat_require_pragma = 0

:imap jj <Esc>
map <Space> <Leader>
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi
nnoremap <Leader>f A
nnoremap <Leader>0 _i
inoremap <Tab>e <Esc>ea
nnoremap qq :q<cr>
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap H :bprev<CR>
nnoremap L :bnext<CR>
nnoremap f $
vnoremap f $
nnoremap 0 _
vnoremap 0 _
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>
nnoremap <Leader>b :buffers<CR>
nnoremap <Leader>c :term<CR>
nnoremap <Leader>e :e<Space>
nnoremap <Leader>m :b<Space>
nnoremap <Leader>d :db

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


vim.cmd('packadd nvim-lsp')
require'nvim_lsp'.gopls.setup{}
