" fjss23 <fjriedemann@gmail.com>
" Search pattern in this file (don't judge, I like having all of this in one file): 
"      plug:<plugin_name>
"      lsp:<language_name>

" todo: put all the specific configuration for vim plugins into
" plugin_options.
"
" todo: create folders for specific filetypes

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
set number 
set relativenumber 
set numberwidth
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
set signcolumn=no
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set nofoldenable 
set colorcolumn=90
set shiftwidth=4
set tabstop=4
set expandtab 
set termguicolors 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/dcampos/nvim-snippy'
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
Plug 'https://github.com/dracula/vim'
call plug#end()

colorscheme dracula

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
let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_enabled_latex = ['latexindent']
let g:neoformat_enabled_sql = ['pg_format']

hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl
hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl

hi! link netrwMarkFile Search
hi! link Todo diffFileId

hi! link DiagnosticLineNrError DiagnosticError
hi! link DiagnosticLineNrWarn DiagnosticWarn
hi! link DiagnosticLineNrInfo DiagnosticInfo
hi! link DiagnosticLineNrHint DiagnosticHint

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

lua <<EOF

local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- plug:vim-ripgrep
keymap.set('n', '<leader>rw', ':Rg<CR>', {silent = true})
keymap.set('n', '<leader>rg', ':Rg ', {silent = true})

-- plug:neoformat
keymap.set('n', '<leader>f', '<cmd>Neoformat<CR>', {silent = true})

-- plug:netrw
keymap.set('n', '<leader>dd', ':Lexplore %:p:h<CR>', {silent = true})
keymap.set('n', '<leader>da', ':Lexplore<CR>', {silent = true})

-- plug:telescope
keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)
keymap.set('n', '<leader>sb', require('telescope.builtin').buffers)
keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)
keymap.set('n', '<leader>sf', require('telescope.builtin').find_files)
keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string)
keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep)
keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics)

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- plug:telescope-fzf-native
pcall(require('telescope').load_extension, 'fzf_native')

-- plug:telescope-file-browser
pcall(require('telescope').load_extension, 'file_browser')
keymap.set('n', '<leader>df', ':Telescope file_browser<CR>', {silent = true})

-- plug:nvim-colorizer
require('colorizer').setup({ filetypes = { 'css', 'scss' } })

-- plug:nvim-web-devicons
require('nvim-web-devicons').setup({})

-- plug:Comment
-- plug:nvim-ts-context-commentstring
require('Comment').setup({ pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook() })

-- todo: add sql
-- plug:nvim-treesitter
-- plug:nvim-ts-context-commentstring
-- plug:nvim-ts-autotag
-- plug:nvim-treesitter-textobjects
require('nvim-treesitter.configs').setup {
    context_commentstring = { enable = true, enable_autocmd = false },
    autotag = { enable = true },
    ensure_installed = { 
        'java', 
        'regex', 
        'make', 
        'cmake', 
        'c', 
        'bash', 
        'yaml', 
        'markdown_inline', 
        'markdown', 
        'go', 
        'lua', 
        'javascript', 
        'jsdoc', 
        'typescript', 
        'tsx', 
        'rust',
        'help', 
        'json', 
        'html', 
        'css', 
        'scss'
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            -- whether to set jumps in the jumplist
            set_jumps = true,
            goto_next_start = {
                ['ça'] = '@function.outer',
                ['çs'] = '@class.outer',
            },
            goto_next_end = {
                ['çd'] = '@function.outer',
                ['çf'] = '@class.outer',
            },
            goto_previous_start = {
                ['çq'] = '@function.outer',
                ['çw'] = '@class.outer',
            },
            goto_previous_end = {
                ['çe'] = '@function.outer',
                ['çr'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- plug:snippy
require('snippy').setup({
    mappings = {
        is = {
            ['<c-r>'] = 'expand_or_advance',
            ['<c-t>'] = 'previous',
        },
        nx = {
            ['<leader>x'] = 'cut_text',
        },
    },
})

local cmp = require 'cmp'

-- plug:nvim-cmp
-- plug:cmp-nvim-lsp
cmp.setup {
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            require("snippy").expand_snippet(args.body)
        end,
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu = ({ nvim_lsp = '[LSP]' })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'snippy' },
    },
}

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        severity_sort = true,
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

keymap.set('n', 'dp', vim.diagnostic.goto_prev)
keymap.set('n', 'dn', vim.diagnostic.goto_next)
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
keymap.set('n', '<leader>le', vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr })
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
    keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
    keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr })
    keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr })
    keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, { buffer = bufnr })
    keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, { buffer = bufnr })
    keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
    keymap.set('i', '<c-k>', vim.lsp.buf.hover, { buffer = bufnr })
    keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
    keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
    keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
    keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { buffer = bufnr })
end

-- plug:nvim-lspconfig
local servers = { 
    'tsserver', 
    'cssls', 
    'cssmodules_ls', 
    'html', 
    'jsonls',
    'bashls',
    'pylsp',
    'cmake',
    'clangd',
    'yamlls',
    'dockerls',
    'prismals'
}

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- lsp:css
-- lsp:json
-- lsp:cssmodules
-- lsp:bash
-- lsp:python
-- lsp:cmake
-- lsp:c
-- lsp:yaml
-- lsp:docker
-- lsp:prisma
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local function js_org_imports()
    local params = {
        command = '_typescript.organizeImports',
        arguments = { api.nvim_buf_get_name(0) },
        title = ''
    }
    vim.lsp.buf.execute_command(params)
end

-- lsp:typescript
-- lsp:javascript
lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            js_org_imports,
            description = 'Orginze js and ts imports'
        }
    }
})

lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all"
        },
    }
})


local go_path_bin = home .. '/.asdf/installs/golang/1.19.5/packages/bin/'

local function go_org_imports()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' }}
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

-- lsp:go
lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { go_path_bin .. 'gopls', 'serve' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    },
    commands = {
        OrganizeImports = {
            go_org_imports,
            description = 'Orginze go imports'
        }
    }
})

lspconfig.golangci_lint_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { go_path_bin .. 'golangci-lint-langserver' },
    init_options = {
        command = { go_path_bin .. 'golangci-lint', 'run', '--out-format', 'json' }
    }
    
})

-- Extending the funcionality of the tsserver and gopls.
keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', {silent = true})

-- lsp:latex
local texlab_path_bin = home .. '/.config/nvim/lsp-langs/texlab'

lspconfig.texlab.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { texlab_path_bin },
})

-- lsp:rust
lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = 'clippy'
            }
        }
    }
})

local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return ' ' .. branch .. " |"
	else
		return ""
	end
end

function status_line() 
    local file = '%f'
    local modifiers = '%m%r%h%w%q'
    local lsp_info = [[%{luaeval("diagnostic_status()")}]]
    local file_type = '%y'
    local line_info = '%l/%L:%c'
    -- ex: utf-8 (sometimes can be empty,  too lazy to write something better)
    local encoding = '%{&fenc}'
    -- ex: unix
    local file_format = '%{&ff}'

    return table.concat({
        ' %{mode()}', ' | ' ,vim.b.branch_name, ' ', file,' ', modifiers,' ', lsp_info, '%=', encoding, ' ', file_type, ' ', file_format, ' | ', line_info, ' '
    })
end

-- Thanks! https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
function diagnostic_status()
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if num_errors > 0 then
    return ' 💀 ' .. num_errors .. ' '
  end

  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if num_warnings > 0 then
    return ' 💩' .. num_warnings .. ' '
  end
  return ''
end

-- plug:nvim-lint
require('lint').linters_by_ft = {
    cmake = { 'cmakelint' },
    markdown = { 'vale' },
    c = { 'cppcheck' },
    java = { 'codespell' },
    python = { 'ruff' },
    sh = { 'shellcheck' },
    yaml = { 'yamllint' },
    gitcommit = { 'codespell' },
    -- todo: add hadolint executable
    dockerfile = { 'hadolint' },
    css = { 'stylelint' },
    html = { 'tidy' },
}

api.nvim_create_autocmd({'BufWritePost', 'BufEnter'}, {
    group = api.nvim_create_augroup('lint', { clear = true }),
    callback = function() require('lint').try_lint() end,
})

api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
	end
})

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})


api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
    pattern = '*',
})

EOF

set statusline=%!v:lua.status_line()
