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
set updatetime=250
set signcolumn=auto
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set colorcolumn=90
set shiftwidth=4
set tabstop=4
set expandtab 
set clipboard=unnamedplus
set termguicolors 
set number 
set nowrap

call plug#begin('~/.local/share/nvim/plugged')
" lsp
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/williamboman/mason.nvim' | Plug 'williamboman/mason-lspconfig.nvim' 
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp' | Plug 'hrsh7th/nvim-cmp' | Plug 'hrsh7th/cmp-path'
" utily
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/numToStr/Comment.nvim'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter' "| Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/mfussenegger/nvim-lint'
Plug 'https://github.com/stevearc/conform.nvim'
Plug 'https://github.com/echasnovski/mini.statusline'
Plug 'https://github.com/nvim-lualine/lualine.nvim'
Plug 'https://github.com/davidosomething/format-ts-errors.nvim'
" Plug 'https://github.com/nvim-tree/nvim-web-devicons'
" vcs
Plug 'https://github.com/tpope/vim-fugitive'
" colors
Plug 'https://github.com/folke/tokyonight.nvim'
" Plug 'https://github.com/gruvbox-community/gruvbox'
" Plug 'https://github.com/dracula/vim'
" Plug 'https://github.com/MaxMEllon/vim-jsx-pretty'
" search
Plug 'https://github.com/nvim-tree/nvim-tree.lua'
" Plug 'https://github.com/stevearc/oil.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim' | Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } | Plug 'nvim-lua/plenary.nvim' | Plug 'nvim-telescope/telescope-ui-select.nvim'
call plug#end()

colorscheme tokyonight-moon

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

lua <<EOF
require('nvim-treesitter.configs').setup({
    highlight = { enable = true },
    indent = { enable = true },
})
-- }}}

require('Comment').setup({})
require('lualine').setup({
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' }
    },
    sections = {
        lualine_a = {'branch'},
        lualine_b = {'diff', 'diagnostics'},
        lualine_c = {{'filename',  path = 1}},
        lualine_x = {'encoding', 'searchcount', 'filetype'},
    }
})
--require('treesitter-context').setup({})
--require("oil").setup()
--require('nvim-web-devicons').setup()

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Lsp Config {{{
local function organize_imports()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        severity_sort = true,
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

keymap.set('n', 'dp', vim.diagnostic.goto_prev)
keymap.set('n', 'dn', vim.diagnostic.goto_next)
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
keymap.set('n', '<leader>le', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, opts)
    vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts)
    vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)
  end,
})

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', keyword_length = 5, group_index = 1, max_item_count = 20 },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'path' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    }),
    performance = {
       trigger_debounce_time = 500,
       throttle = 550,
       fetching_timeout = 80,
    }
  })
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

require('mason').setup()
require("mason-lspconfig").setup_handlers({
    -- default
    function (server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities
        }
    end,
    ['tsserver'] = function()
        lspconfig.tsserver.setup {
            capabilities = capabilities,
            commands = {
                OrganizeImports = {
                    organize_imports,
                    description = 'Orginze js and ts imports',
                },
            },
            handlers = {
                 ["textDocument/publishDiagnostics"] = function(
                      _,
                      result,
                      ctx,
                      config
                    )
                        if result.diagnostics == nil then
                            return
                          end

                          -- ignore some tsserver diagnostics
                          local idx = 1
                          while idx <= #result.diagnostics do
                            local entry = result.diagnostics[idx]

                            local formatter = require('format-ts-errors')[entry.code]
                            entry.message = formatter and formatter(entry.message) or entry.message

                            -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
                            if entry.code == 80001 then
                              -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                              table.remove(result.diagnostics, idx)
                            else
                              idx = idx + 1
                            end
                          end

                          vim.lsp.diagnostic.on_publish_diagnostics(
                            _,
                            result,
                            ctx,
                            config
                          )
                    end
            }
        }
    end,
    ['yamlls'] = function()
        lspconfig.yamlls.setup {
            capabilities = capabilities,
            yaml = {
                schemaStore = {
                    url = 'https://www.schemastore.org/api/json/catalog.json',
                    enable = true,
                },
            },
        }
    end,
    ['gopls'] = function()
        lspconfig.gopls.setup {
            capabilities = capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        shadow = true,
                    },
                    staticcheck = true,
                }
            },
        }
    end,
    --[[['html'] = function()
        lspconfig.html.setup {
            capabilities = capabilities,
            filetypes = { 'html', 'javascriptreact', 'typescriptreact' }
        }
    end,--]]
})


keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', {silent = true})

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

require('conform').setup({
    formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact  = { 'prettier' },
        html  = { 'prettier' },
        json  = { 'prettier' },
        yaml  = { 'prettier' },
        css  = { 'prettier' },
        scss  = { 'prettier' },
        markdown  = { 'prettier' },
        go  = { 'gofmt', 'goimports' },
    }
})

api.nvim_create_autocmd('BufWritePre', {
  pattern = "*",
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

require('lint').linters_by_ft = {
    yaml = { 'yamllint' },
    dockerfile = { 'hadolint' },
}

local lint_augroup = api.nvim_create_augroup('lint', { clear = true })

api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
        require('lint').try_lint()
    end
})

local builtin = require('telescope.builtin')
keymap.set('n', '<leader>sf', builtin.find_files, {})
keymap.set('n', '<leader>sg', builtin.live_grep, {})
keymap.set('n', '<leader>sd', builtin.diagnostics, {})
keymap.set('n', '<leader>si', builtin.git_status, {})
keymap.set('n', '<leader>sb', builtin.buffers, {})
keymap.set('n', '<leader>sc', builtin.git_commits, {})
keymap.set('n', '<leader>ss', builtin.git_status, {})

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

require("nvim-tree").setup({
    view = {
        side = "right",
    },
    renderer = {
        icons = { 
            show = {
                file = false,
                folder = false,
            }
        }
    }
})
keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>')
keymap.set('n', '<leader>tf', ':NvimTreeFindFile<CR>')

--vim.g.skip_ts_context_commentstring_module = true

EOF

nnoremap <leader>p <cmd>lua PeekDefinition()<CR>

" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" let g:lightline = {
"     \ 'colorscheme': 'gruvbox',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'gitbranch#name'
"       \ },
"       \ }

