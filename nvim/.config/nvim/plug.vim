" fjss23 <fjriedemann@gmail.com>
"
" List of plugins. Vim-plug (https://github.com/junegunn/vim-plug) required.
" This file also contains configuration for vimscript plugins, including the
" built-in onces. This file doesn't include any mapping for the list of
" plugins, those are in <init.lua>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/L3MON4D3/LuaSnip', {'tag': 'v1.*', 'do': 'make install_jsregexp'}
Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/sbdchd/neoformat'
Plug 'https://github.com/mfussenegger/nvim-lint'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects'
Plug 'https://github.com/nvim-tree/nvim-web-devicons'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim', {'tag': '0.1.1'}
Plug 'https://github.com/nvim-telescope/telescope-file-browser.nvim'
Plug 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'https://github.com/jremmen/vim-ripgrep'
Plug 'https://github.com/windwp/nvim-ts-autotag'
Plug 'https://github.com/NvChad/nvim-colorizer.lua'
Plug 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring'
Plug 'https://github.com/numToStr/Comment.nvim'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/ray-x/lsp_signature.nvim'
Plug 'https://github.com/dracula/vim'
call plug#end()

let g:netrw_banner=v:false
let g:netrw_localcopydircmd='cp -r'
let g:netrw_keepdir=v:true
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle=3
let g:netrw_winsize=30

let g:user_emmet_install_global = 0

autocmd FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'jsx',
\  },
\  'javascript.jsx' : {
\    'extends' : 'jsx',
\    'default_attributes': {
\      'label': [{'htmlFor': ''}],
\    }
\  },
\}

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_prisma = ['prettier']
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_cmake = ['cmake_format']
let g:neoformat_enabled_python = ['black']
" https://stackoverflow.com/questions/20756924/how-can-i-install-clang-format-in-ubuntu
let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_enabled_latex = ['latexindent']
let g:neoformat_enabled_sql = ['pg_format']
