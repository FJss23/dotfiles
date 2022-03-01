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
" nnoremap <silent> <leader><CR> :noh<CR>

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
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/nvim-cmp' " Better lsp experience
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'nvim-lua/plenary.nvim' " Compulsory for other plugins
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'rebelot/kanagawa.nvim' " Colorscheme
Plug 'numToStr/Comment.nvim' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'windwp/nvim-autopairs' " Auto close paired characters
Plug 'editorconfig/editorconfig-vim' " Config for projects
Plug 'lewis6991/gitsigns.nvim' " Git info
Plug 'nvim-telescope/telescope.nvim' " Better search experience
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Fast telescope
Plug 'nvim-telescope/telescope-file-browser.nvim' " File manipulation
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation
Plug 'windwp/nvim-ts-autotag' " Easy html tag manipulation
Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'nvim-lualine/lualine.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'marko-cerovac/material.nvim'
call plug#end()

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_enabled = v:false

let g:material_style = 'darker'
colorscheme material

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
  require'gitsigns'.setup{
    numhl = true,
    signcolumn = false,
  }
  require'lualine'.setup({
    options = {
        component_separators = { left = '', right = ' '},
    },
    sections = {
      lualine_a = { '' },
      lualine_b = { 'branch', { 'diff', colored = false }, { 'diagnostics', colored = false} },
      lualine_z = { { 'location', color = { bg = '#252535', fg = '#DCD7B'} } }
     }
  })
  require'colorizer'.setup()
  require'indent_blankline'.setup {
      show_current_context = true,
      show_current_context_start = true,
  }
  require'Comment'.setup()
  require'nvim-web-devicons'.setup {
    default = true;
  }
  require'nvim-autopairs'.setup()
  require'telescope'.load_extension('fzf')
  require'telescope'.load_extension('file_browser')

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
  vim.api.nvim_set_keymap('n','<space>t', ':lua vim.diagnostic.setqflist() <CR>', { noremap = true })

  local signs = { Error = ' ●', Warn = ' ●', Hint = ' ●', Info = ' ●' }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- NVIM COMPE
  local cmp = require'cmp'

  local lspkind = require'lspkind'

  cmp.setup({
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol',
        maxwidth = 50,
      })
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- LSP: css, docker, tailwind, rust, python
  local servers = { 'cssls', 'dockerls', 'html', 'tailwindcss', 'rust_analyzer', 'pylsp' }

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
     capabilities = capabilities,
     on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  -- LSP: javascript/typescript
  nvim_lsp.tsserver.setup {
    capabilities = capabilites,
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
    capabilities = capabilites;
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    cmd = { "/home/frandev/.elixir-ls/language_server.sh"}
  }

  -- LSP: json
  nvim_lsp.jsonls.setup{
    capabilities = capabilites,
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
    capabilities = capabilities,
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
    capabilities = capabilities,
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
