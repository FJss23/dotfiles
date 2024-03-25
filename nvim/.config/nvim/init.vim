let mapleader=' '
let maplocalleader=' '

inoremap qw {
inoremap wq }
inoremap qq [
inoremap ww ]
inoremap jk <Esc>
nnoremap <leader>j <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <Up> <cmd>resize +2<CR>
nnoremap <Down> <cmd>resize -2<CR>
nnoremap <Left> <cmd>vertical resize +2<CR>
nnoremap <Right> <cmd>vertical resize -2<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<CR>:b<space>
nnoremap <leader>bk <cmd>bp\|bd! #<CR>

nnoremap <leader>co <cmd>copen<CR>
nnoremap <leader>ck <cmd>cclose<CR>
nnoremap <leader>cn <cmd>cnext<CR>
nnoremap <leader>cp <cmd>cprevious<CR>

nnoremap <leader>lo <cmd>lopen<CR>
nnoremap <leader>lk <cmd>lclose<CR>
nnoremap <leader>ln <cmd>lnext<CR>
nnoremap <leader>lp <cmd>lprevious<CR>

nnoremap <leader>tk <cmd>tabclose<CR>
nnoremap <leader>tn <cmd>tabnew<CR>

nnoremap <leader>sc <cmd>e $MYVIMRC<CR>

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

set path+=**
set splitright 
set splitbelow 
set cursorline 
set hlsearch 
set mouse=a
set breakindent 
set undofile 
set ignorecase 
set smartcase 
set noswapfile 
set scrolloff=7
set spellsuggest=best,9
set spelllang=en_us
set nospell
set updatetime=100
set signcolumn=auto
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set colorcolumn=90
set shiftwidth=2
set tabstop=2
set expandtab 
set clipboard=unnamedplus
set termguicolors 
set nowrap

call plug#begin('~/.local/share/nvim/plugged')
" lsp
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/williamboman/mason.nvim' | Plug 'williamboman/mason-lspconfig.nvim' 
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp' | Plug 'hrsh7th/nvim-cmp'
" utility
Plug 'https://github.com/L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter' | Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'https://github.com/brenoprata10/nvim-highlight-colors'
Plug 'https://github.com/RRethy/nvim-treesitter-endwise'
Plug 'https://github.com/davidosomething/format-ts-errors.nvim'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'
" format
Plug 'https://github.com/mfussenegger/nvim-lint'
" linting
Plug 'https://github.com/stevearc/conform.nvim'
" vcs
Plug 'https://github.com/tpope/vim-fugitive'
" colors
Plug 'https://github.com/rebelot/kanagawa.nvim'
Plug 'https://github.com/Verf/deepwhite.nvim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" search
Plug 'https://github.com/echasnovski/mini.files', { 'branch': 'stable' }
Plug 'https://github.com/ibhagwan/fzf-lua'
call plug#end()

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

filetype plugin indent on

highlight! link IblIndent NonText
highlight! link EndOfBuffer Comment

lua <<EOF
require('init')
EOF

nnoremap <leader>p <cmd>lua PeekDefinition()<CR>

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" vim: ts=2 sts=2 sw=2 et
