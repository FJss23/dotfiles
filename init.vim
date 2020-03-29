call plug#begin('~/.local/share/nvim/plugged')

" Syntax highlight
Plug 'posva/vim-vue'
Plug 'kaicataldo/material.vim'

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
call plug#end()

set title                 				" Muestra el nombre del arcqqhivo en la ventana de la terminal
set mouse=a               				" Permite la integracion del mouse
set termguicolors         				" Activa true colors en la terminal
set number		  				" Activa el numero de linea
set noshowmode		 				" Elimina la visualizacion del modo activo

syntax on
colorscheme material					" Activa el theme
let g:lightline = { 'colorscheme': 'material_vim' }

let g:prettier#autoformat = 0				" Desactivamos opciones para farmetar cuando se guarda
let g:prettier#autoformat_require_pragma = 0

:imap jj <Esc>
map <Space> <Leader>
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi
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

" Search a file 
nnoremap <Leader>f :Files<CR>
" Search word in current file
nnoremap <Leader>r :Rg<CR>
" List buffers
nnoremap <Leader>b :Buffers<CR>
" List of history search
nnoremap <Leader>h :History<CR>
" Files under a git project
nnoremap <Leader>g :GFiles<CR>
" Files under a git project unstaged 
nnoremap <Leader>s :GFiles?<CR>
" Lines in loaded buffers
nnoremap <Leader>l :Lines<CR>
" Lines under the current buffer
nnoremap <Leader>c :Blines<CR>
" Tags in the project
nnoremap <Leader>t :Tags<CR>
" Tags in the current buffer
nnoremap <Leader>n :BTags<CR>
" Marks
nnoremap <Leader>m :Marks<CR>
" Open a new terminal
nnoremap <Leader>c :term<CR>
" Edit a new file
nnoremap <Leader>e :e<Space>
" Close the current buffer
nnoremap <Leader>d :db

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
