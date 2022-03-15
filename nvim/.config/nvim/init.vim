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
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set noshowmode
set rtp+=~/.fzf
set nonumber norelativenumber

let mapleader=" "
:imap jk <Esc>

nnoremap <leader>s :update<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>u :tabclose<cr>

:tnoremap jk <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap Y y$

" Improved Split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Switch between your last two buffers
nnoremap <leader><leader> <c-^>
noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Kill the current buffer
nnoremap <leader>bb :ls<cr>:b<space>
nnoremap <Leader>bk :bp\|bd! #<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>

nnoremap <silent> <F2> :set invnumber invrelativenumber<cr>
nnoremap <silent> <F4> :set spell!<cr>
inoremap <silent> <F4> <C-O>:set spell!<cr>
nnoremap <silent> <F3> :IndentBlanklineToggle<cr>

nnoremap <leader>. :term<CR>i

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/nvim-cmp' " Better lsp experience

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'ellisonleao/gruvbox.nvim'
Plug 'kyazdani42/nvim-web-devicons' " Icons

Plug 'nvim-lua/plenary.nvim' " Compulsory for other plugins
Plug 'numToStr/Comment.nvim' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'windwp/nvim-autopairs' " Auto close paired characters
Plug 'lewis6991/gitsigns.nvim' " Git info
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation
Plug 'windwp/nvim-ts-autotag' " Easy html tag manipulation

Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-lualine/lualine.nvim' " Better line

Plug 'mfussenegger/nvim-dap' " Trying to debug
Plug 'rcarriga/nvim-dap-ui' " Better UI for debug

Plug 'kyazdani42/nvim-tree.lua'
Plug 'junegunn/fzf.vim'
call plug#end()

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,vue EmmetInstall
autocmd TermOpen * setlocal nonumber norelativenumber

let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_enabled = v:false

colorscheme gruvbox

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>fr :NvimTreeRefresh<CR>
nnoremap <leader>fn :NvimTreeFindFile<CR>

nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fw :Rg <C-R><C-W><CR>

let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '~30%' }

autocmd BufWritePre *.go lua goimports(1000)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


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
  require'lualine'.setup({
    sections = {
      lualine_x = { 'encoding', 'fileformat', { 'filetype', colored = false }},
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
  require'nvim-tree'.setup{
    disable_netrw = true,
    git = {
      enable = false,
    },
    view = {
      hide_root_folder = true,
    }
  }

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

  vim.api.nvim_set_keymap('n','<space>t', ':lua vim.diagnostic.setqflist() <CR>', { noremap = true })

  local signs = { Error = '➤ ', Warn = '●', Hint = '●', Info = '●' }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  require("luasnip.loaders.from_vscode").lazy_load()

  -- NVIM COMPE
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end


  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
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
      
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- LSP supported languages -> CSS, JSON, HTML, CSS Modules, Tailwindcss, Zig, C, Javascript, Lua, Python, EFM, Go
  local servers = { 'cssls', 'jsonls', 'html', 'cssmodules_ls', 'tailwindcss', 'zls', 'vuels', 'pyright' }

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
     capabilities = capabilities,
     on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end

  nvim_lsp.ccls.setup {
    init_options = {
      compilationDatabaseDirectory = "build";
      index = {
        threads = 0;
      };
      clang = {
        excludeArgs = { "-frounding-math"} ;
      };
    }
  }

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

  nvim_lsp.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
    cmd = {"gopls", "serve"},
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }


  local sumneko_root_path = "/home/frandev/.lua-language-server"
  local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
  local runtime_path = vim.split(package.path, ';')

  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

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
