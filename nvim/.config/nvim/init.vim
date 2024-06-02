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

" nnoremap <c-c> <cmd>noh<CR>

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

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

set path+=**
set splitright 
set splitbelow 
set hlsearch 
set mouse=a
set breakindent 
set undofile 
set ignorecase 
set smartcase 
set noswapfile 
set scrolloff=15
set spellsuggest=best,9
set spelllang=en_us
set nospell
set updatetime=100
set signcolumn=auto
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set shiftwidth=2
set tabstop=2
set expandtab 
set clipboard=unnamedplus
set termguicolors 
set nowrap
set number

call plug#begin('~/.local/share/nvim/plugged')
" lsp
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/williamboman/mason.nvim' 
Plug 'williamboman/mason-lspconfig.nvim' 
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/nvim-cmp'
" utility
Plug 'https://github.com/L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
Plug 'https://github.com/MeanderingProgrammer/markdown.nvim'
Plug 'https://github.com/mfussenegger/nvim-jdtls'
Plug 'https://github.com/lvimuser/lsp-inlayhints.nvim'
" formatting
Plug 'https://github.com/mfussenegger/nvim-lint'
" linting
Plug 'https://github.com/stevearc/conform.nvim'
" git
Plug 'https://github.com/kdheepak/lazygit.nvim'
" colors
Plug 'https://github.com/EdenEast/nightfox.nvim'
" search
Plug 'https://github.com/nvim-tree/nvim-tree.lua'
Plug 'https://github.com/ibhagwan/fzf-lua'
" database
Plug 'https://github.com/tpope/vim-dadbod'
Plug 'https://github.com/kristijanhusak/vim-dadbod-completion'
Plug 'https://github.com/kristijanhusak/vim-dadbod-ui'
" tests
Plug 'https://github.com/vim-test/vim-test'
" debug
Plug 'https://github.com/mfussenegger/nvim-dap'
Plug 'https://github.com/theHamsta/nvim-dap-virtual-text'
Plug 'https://github.com/rcarriga/nvim-dap-ui'
Plug 'https://github.com/nvim-neotest/nvim-nio'
Plug 'https://github.com/leoluz/nvim-dap-go'
call plug#end()

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

filetype plugin indent on

highlight! link EndOfBuffer Comment

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

set rtp+=~/.fzf

lua <<EOF
require('init')
EOF

" hi StatusLine guibg=#0086b3 guifg=#252525
" hi StatusLineNC guibg=#7d7d7d guifg=#252525
hi WinSeparator guifg=#877c7c
hi! link LspInlayHint Conceal
" hi Normal guibg=#1b1b1b
" hi Comment guifg=#a0f1f0 guibg=#1b1b1b

" vim: ts=2 sts=2 sw=2 et
