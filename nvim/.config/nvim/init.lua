local home = os.getenv('HOME')

vim.opt.path:append({'**'})
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.g.hlsearch = true
vim.g.incsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.wo.relativenumber = true
vim.wo.nuw = 2
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.scrolloff = 7
vim.o.shiftwidth = 4                        -- when > use 4 spaces
vim.o.tabstop = 4                           -- show existing tab with 4 spaces
vim.o.expandtab = true                      -- insert 4 spaces when pressing tab
vim.opt.spellsuggest = {'best', '9'}
vim.o.updatetime = 250
vim.wo.signcolumn = 'no'
vim.o.termguicolors = true
vim.opt.wildignore:append({'*.png', '*.jpg', '*/.git/*', '*/node_modules/*', '*/tmp/*', '*.so', '*.zip'})
vim.o.completeopt = 'menuone,noselect'
vim.g.foldenable = false
vim.cmd.colorscheme('tokyonight')
vim.g.netrw_banner = false
vim.g.netrw_localcopydircmd = 'cp -r'       -- Recursive copy
vim.g.netrw_keepdir = true
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30

local kopts = {silent = true}

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'qw', '{', kopts)
vim.keymap.set('i', 'wq', '}', kopts)
vim.keymap.set('i', 'qq', '[', kopts)
vim.keymap.set('i', 'ww', ']', kopts)
vim.keymap.set('i', 'jk', '<Esc>', kopts)
vim.keymap.set('n', '<leader>i', '<cmd>w<cr>', kopts)
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', kopts)
vim.keymap.set('n', '<leader>rw', ':grep<c-r><c-w><CR>', kopts)
vim.keymap.set('n', '<leader>rg', ':grep ', kopts)
vim.keymap.set('n', '<leader>fd', ':find ', kopts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", kopts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", kopts)

vim.keymap.set('n', '<Up>', '<cmd>resize +2<CR>', kopts)
vim.keymap.set('n', '<Down>', '<cmd>resize -2<CR>', kopts)
vim.keymap.set('n', '<Left>', '<cmd>vertical resize +2<CR>', kopts)
vim.keymap.set('n', '<Right>', '<cmd>vertical resize -2<CR>', kopts)

vim.keymap.set('n', '<leader><leader>', '<c-^>', kopts)
vim.keymap.set('n', '<leader>,', ':ls<CR>:b<space>', kopts)

vim.keymap.set('n', '<leader>co', '<cmd>copen<CR>', kopts)
vim.keymap.set('n', '<leader>ck', '<cmd>cclose<CR>', kopts)
vim.keymap.set('n', '<leader>cn', '<cmd>cnext<CR>', kopts)
vim.keymap.set('n', '<leader>cp', '<cmd>cprevious<CR>', kopts)

vim.keymap.set('n', '<leader>lo', '<cmd>lopen<CR>', kopts)
vim.keymap.set('n', '<leader>lk', '<cmd>lclose<CR>', kopts)
vim.keymap.set('n', '<leader>ln', '<cmd>lnext<CR>', kopts)
vim.keymap.set('n', '<leader>lp', '<cmd>lprevious<CR>', kopts)

vim.keymap.set('n', '<leader>tk', '<cmd>tabclose<CR>', kopts)
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', kopts)

vim.keymap.set('n', '<leader>sc', '<cmd>e $MYVIMRC<CR>', kopts)
vim.keymap.set('n', '<leader>f', '<cmd>Neoformat<CR>', kopts)
vim.keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', kopts)

vim.keymap.set('n', '<leader>dd', ':Lexplore %:p:h<CR>', kopts)     -- open netrw in the dir of the current file
vim.keymap.set('n', '<leader>da', ':Lexplore<CR>', kopts)           -- open netrw en the current working dir

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>le', vim.diagnostic.setloclist)

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

pcall(require('telescope').load_extension, 'fzy_native')
pcall(require('telescope').load_extension, 'project')
pcall(require('telescope').load_extension, 'file_browser')

require('colorizer').setup({
    filetypes = { 'css', 'scss' }
})

require('nvim-web-devicons').setup({})

require('Comment').setup({
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
})

require('nvim-treesitter.configs').setup {
    context_commentstring = { enable = true, enable_autocmd = false },
    autotag = { enable = true },
    ensure_installed = { 'yaml', 'markdown_inline', 'markdown', 'go', 'lua', 'javascript', 'typescript', 'help', 'json', 'html', 'css' },
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
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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
            set_jumps = true, -- whether to set jumps in the jumplist
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

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu = ({ nvim_lsp = '[LSP]', luasnip = '[LuaSnip]' })[entry.source.name]
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
        { name = 'luasnip' },
    },
}

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    float = {
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
    nmap('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')
end

local servers = { 'tsserver', 'cssls', 'cssmodules_ls' }
local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local function js_org_imports()
    local params = {
        command = '_typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ''
    }
    vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            js_org_imports,
            description = 'Orginze js and ts imports'
        }
    }
}

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

local go_path_bin = home .. '/.asdf/installs/golang/1.19.5/packages/bin/'

lspconfig.gopls.setup {
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
}

lspconfig.golangci_lint_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { go_path_bin .. 'golangci-lint-langserver' },
    init_options = {
        command = { go_path_bin .. 'golangci-lint', 'run', '--out-format', 'json' }
    }
    
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all"
        },
    }
}

local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return ' ' .. branch .. " | "
	else
		return ""
	end
end

vim.api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
	end
})

function status_line() 
    local file = '%f'
    local modifiers = '%m%r%h%w%q'
    local lsp_info = [[%{luaeval("diagnostic_status()")}]]
    local file_type = '%y'
    local line_info = '%l/%L:%c'
    local encoding = '%{&fenc}'  -- ex: utf-8 (sometimes can be empty,  too lazy to write something better)
    local file_format = '%{&ff}' -- ex: unix

    return table.concat({
        vim.b.branch_name, ' ', file,' ', modifiers,' ', lsp_info, '%=', encoding, ' ', file_type, ' ', file_format, ' | ', line_info, ' '
    })
end

-- https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
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



local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})


vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end,
    pattern = '*',
})


vim.cmd[[
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

set statusline=%!v:lua.status_line()

nnoremap <leader>bk <cmd>bp\|bd! #<CR>

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

hi DiagnosticUnderlineError cterm=undercurl gui=undercurl
hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl
hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl
hi DiagnosticUnderlineHint cterm=undercurl gui=undercurl

hi! link netrwMarkFile Search
hi! link Todo diffFileId

let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_json = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_go = ['gofmt']


hi! link DiagnosticLineNrError DiagnosticError
hi! link DiagnosticLineNrWarn DiagnosticWarn
hi! link DiagnosticLineNrInfo DiagnosticInfo
hi! link DiagnosticLineNrHint DiagnosticHint

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]
