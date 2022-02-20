set path+=**
set signcolumn=yes
set colorcolumn=100
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
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
set number relativenumber
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
nnoremap <leader>9 :bprevious<CR>
nnoremap <leader>0 :bnext<CR>

" Switch between your last two buffers
nnoremap <leader><leader> <c-^>
" After search, clean the highlight
nnoremap <silent> <leader><CR> :noh<CR>

nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Kill the current buffer
nnoremap <Leader>k :bp\|bd! #<CR>

nnoremap <silent> <F2> :set invnumber invrelativenumber<cr>
nnoremap <silent> <F4> :set spell!<cr>
inoremap <silent> <F4> <C-O>:set spell!<cr>
nnoremap <silent> <F3> :IndentBlanklineToggle<cr>

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'nvim-lua/plenary.nvim' " Compulsory for other plugins
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'rebelot/kanagawa.nvim' " Colorscheme
Plug 'numToStr/Comment.nvim' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'windwp/nvim-autopairs' " Auto close paired characters
Plug 'editorconfig/editorconfig-vim' " Config for projects
Plug 'folke/trouble.nvim' " Errors in the project
Plug 'lewis6991/gitsigns.nvim' " Git info
Plug 'nvim-telescope/telescope.nvim' " Better search experience
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Fast telescope
Plug 'nvim-telescope/telescope-file-browser.nvim' " File manipulation
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation
Plug 'windwp/nvim-ts-autotag' " Easy html tag manipulation
Plug 'hrsh7th/nvim-compe' " Better lsp experience
Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'akinsho/bufferline.nvim' " Show buffer in a tab style
call plug#end()

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall

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

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_enabled = v:false

colorscheme kanagawa

autocmd BufWritePre *.go lua goimports(1000)

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    autotag = {
      enable = true
    },
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
  }
  require'gitsigns'.setup()
  require'colorizer'.setup()
  require("bufferline").setup()
  require'indent_blankline'.setup {
      show_current_context = true,
      show_current_context_start = true,
  }
  require'Comment'.setup()
  require'nvim-web-devicons'.setup {
    default = true;
  }
  require'nvim-autopairs'.setup()
  require'trouble'.setup()
  require'telescope'.load_extension('fzf')
  require'telescope'.load_extension('file_browser')
  require'compe'.setup({
    enabled = true,
    source = {
      path = true,
      buffer = true,
      nvim_lsp = true,
    },
  })

  local nvim_lsp = require'lspconfig'

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
    buf_set_keymap('n', '<space>b', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  vim.api.nvim_set_keymap('n','<space>fe',':Telescope file_browser <CR>', { noremap = true })

  -- LSP: css, docker, tailwind, rust, python
  local servers = { 'cssls', 'dockerls', 'html', 'tailwindcss', 'rust_analyzer', 'pylsp' }

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
     on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  -- LSP: javascript/typescript
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

  -- LSP: elixir
  nvim_lsp.elixirls.setup{
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { "/home/frandev/.elixir-ls/language_server.sh"}
  }

  -- LSP: json
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
  
  local sumneko_root_path = "/home/frandev/.lua-language-server"
  local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
  local runtime_path = vim.split(package.path, ';')

  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  -- LSP: lua
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

  -- LSP: go
  nvim_lsp.gopls.setup {
    on_attach = on_attach,
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    }
  }

  function goimports(timeout_ms)
    local context = { only = { "source.organizeImports" } }
    vim.validate { context = { context, "t", true } }

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]

    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit)
      end
      if type(action.command) == "table" then
        vim.lsp.buf.execute_command(action.command)
      end
    else
      vim.lsp.buf.execute_command(action)
    end
  end

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

  -- LSP: efm (linters and formatters)
  nvim_lsp.efm.setup {
    cmd = { "/home/frandev/.efm-langserver/efm-langserver"},
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
EOF
