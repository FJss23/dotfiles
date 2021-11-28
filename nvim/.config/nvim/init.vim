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
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
au TermOpen * setlocal nonumber norelativenumber

let mapleader=" "
:imap jk <Esc>
nnoremap <leader>s :update<cr>
nnoremap <leader>q :q<cr>
:tnoremap jk <C-\><C-n>
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
Plug 'romgrk/doom-one.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'projekt0n/github-nvim-theme'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sbdchd/neoformat'
" Plug 'neovim/nvim-lspconfig'
" Plug 'ray-x/lsp_signature.nvim'
" Plug 'hrsh7th/nvim-cmp'
Plug 'windwp/nvim-autopairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'digitaltoad/vim-pug'
Plug 'elixir-editors/vim-elixir'
call plug#end()

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall

nnoremap <leader>e :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" colorscheme moonfly
" colorscheme doom-one
" let g:doom_one_terminal_colors = v:true
colorscheme nightfox
" colorscheme github_dark

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  }

  require'gitsigns'.setup()
  require'nvim-tree'.setup {
    open_on_setup = true,     
  }
  require'colorizer'.setup()
  require'indent_blankline'.setup()

  require'nvim-web-devicons'.setup {
    default = true;
  }

  require'nvim-autopairs'.setup()

  require'telescope'.load_extension('fzf')

   --require'lspconfig'.cssls.setup{}
   --require'lsp_signature'.setup()

EOF
