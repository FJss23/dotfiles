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
highlight Normal ctermbg=none
highlight NonText ctermbg=none

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'EdenEast/nightfox.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'numToStr/Comment.nvim'
Plug 'mattn/emmet-vim'
Plug 'windwp/nvim-autopairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'folke/trouble.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'kyazdani42/nvim-tree.lua'

Plug 'norcalli/nvim-colorizer.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'windwp/nvim-ts-autotag'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

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

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

colorscheme nightfox

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  }

  require'gitsigns'.setup()
  require'nvim-tree'.setup {
    open_on_setup = false,     
  }
  require'colorizer'.setup()
  require'indent_blankline'.setup()
  require'Comment'.setup()

  require'nvim-web-devicons'.setup {
    default = true;
  }

  require'nvim-autopairs'.setup()
  require'trouble'.setup()

  require'telescope'.load_extension('fzf')

  local nvim_lsp = require('lspconfig')

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) 
    buf_set_keymap('n', '<space>l', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) 
    buf_set_keymap('n', '<space>h', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts) 
    buf_set_keymap('n', '<space>y', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>b', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  local servers = { 'cssls', 'dockerls', 'html','tailwindcss' }

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
     on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  nvim_lsp.tsserver.setup {
    on_attach = function(client, bufnr)
      if client.config.flags then 
          client.config.flags.allow_incremental_sync = true
      end
      client.resolved_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150,
     }
  }

  nvim_lsp.elixirls.setup{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { "/home/frandevme/.elixir-ls/language_server.sh"}
  }

  nvim_lsp.jsonls.setup{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
  }
  
  local sumneko_root_path = "/home/frandevme/.lua-language-server"
  local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
  local runtime_path = vim.split(package.path, ';')

  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }

  local prettier = {formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}", formatStdin = true}

  local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
  }

  local languages = {
    json = {prettier},
    html = {prettier},
    css = {prettier},
    typescript = {prettier, eslint},
    javascript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    pug = {prettier},
    markdown = {prettier},
  }

  nvim_lsp.efm.setup {
    cmd = { "/home/frandevme/.efm-langserver/efm-langserver"},
    flags = {
      debounce_text_changes = 150,
    },
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'html', 'json', 'pug', 'markdown'},
    settings = {rootMarkers = {".git/"}, languages = languages, log_level = 1, log_file = '~/.efm-langserver/efm.log'},
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.goto_definition = false
      on_attach(client, bufnr)
    end
  }

  require'nvim-ts-autotag'.setup()

  require'compe'.setup({
    enabled = true,
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
    },
  })

EOF
