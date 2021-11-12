set path+=**
set signcolumn=yes
set colorcolumn=100
set tabstop=4 
set number
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set relativenumber
set hidden
set nobackup
set noswapfile
set incsearch hlsearch
set scrolloff=10
set noshowmode
set termguicolors
set completeopt=menu,noinsert,noselect
set mouse=a
set nuw=4
set background=dark
set cursorline
filetype on
filetype indent on
filetype plugin on
set spelllang=en
set spellsuggest=best,9
au TermOpen * setlocal nonumber norelativenumber

let mapleader=" "
:imap jk <Esc>
nnoremap <leader>s :update<cr>
nnoremap <leader>q :q<cr>
:tnoremap jk <C-\><C-n>
nnoremap <S-TAB> :bprev<CR>
nnoremap <TAB> :bnext<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap Y y$
" Switch beetwen your last two buffers
nnoremap <leader><leader> <c-^>
" After search, clean the highlight
nnoremap <silent> <leader><CR> :noh<CR>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

nnoremap <Leader>k :bp\|bd! #<CR>

nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'mattn/emmet-vim'

Plug 'bluz71/vim-moonfly-colors'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'tpope/vim-commentary'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'sbdchd/neoformat'

Plug 'tpope/vim-surround'
call plug#end()

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

colorscheme moonfly

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  }

  require'gitsigns'.setup()
  require'nvim-tree'.setup()
  require'colorizer'.setup()
  require'indent_blankline'.setup()

  require'nvim-web-devicons'.setup {
    default = true;
  }
EOF
