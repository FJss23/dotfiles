set signcolumn=yes
set tabstop=4 
set number
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set relativenumber
set nohlsearch
set hidden
set nobackup
set noswapfile
set incsearch
set scrolloff=10
set noshowmode
set termguicolors
set completeopt=menu,noinsert,noselect
set mouse=a
set background=dark
au TermOpen * setlocal nonumber norelativenumber

:imap jk <Esc>
let mapleader=" "
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>i
nnoremap ww :q<cr>
:tnoremap jk <C-\><C-n>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <A-h> gT
nnoremap <A-l> gt
tnoremap <A-h> gT
tnoremap <A-l> gt
nnoremap <S-TAB> :bprev<CR>
nnoremap <TAB> :bnext<CR>
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>tt :tabnew term://fish<CR>i
nnoremap <Leader>ts :belowright split term://fish<CR>i
nnoremap <Leader>tb :te fish<CR>i

call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mattn/emmet-vim'

Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
call plug#end()

lua require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.cssls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.jsonls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.vuels.setup{on_attach=require'completion'.on_attach}

lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.sumneko_lua.setup{on_attach=require'completion'.on_attach}

lua require'colorizer'.setup()

autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#exec_cmd_async=1
let g:prettier#config#parser=''

colorscheme embark

autocmd FileType html EmmetInstall

let g:lightline = {
      \ 'colorscheme': 'embark',
      \ }

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
