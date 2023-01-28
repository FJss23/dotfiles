local Plug = vim.fn['plug#']

local github = 'https://github.com/'
local home = os.getenv('HOME')

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp' )
Plug('dcampos/nvim-snippy')
Plug('nvim-treesitter/nvim-treesitter')
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug('lewpoly/sherbet.nvim')
Plug('numToStr/Comment.nvim')
Plug('NvChad/nvim-colorizer.lua')
Plug('mattn/emmet-vim')
Plug('tpope/vim-surround')
Plug(home .. '/.fzf')
Plug('junegunn/fzf.vim')
vim.call('plug#end')

vim.opt.path:append({'**'})
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.g.hlsearch = true
vim.g.incsearch = true
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.wo.relativenumber = true
vim.wo.nuw = 2
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.scrolloff = 7
vim.o.shiftwidth = 4 -- when > use 4 spaces
vim.o.tabstop = 4 -- show existing tab with 4 spaces
vim.o.expandtab = true -- insert 4 spaces when pressing tab
vim.opt.spellsuggest = {'best', '9'}
vim.o.updatetime = 250
vim.wo.signcolumn = 'no'
vim.o.termguicolors = true
vim.opt.wildignore:append({'*.png', '*.jpg', '*/.git/*', '*/node_modules/*', '*/tmp/*', '*.so', '*.zip'})
vim.o.completeopt = 'menuone,noselect'
vim.cmd.colorscheme 'sherbet'
vim.g.netrw_banner = false
vim.g.netrw_localcopydircmd = 'cp -r' -- Recursive copy


local kopts = {silent = true}
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('i', 'qw', '{', kopts)
vim.keymap.set('i', 'wq', '}', kopts)
vim.keymap.set('i', 'qq', '[', kopts)
vim.keymap.set('i', 'ww', ']', kopts)
vim.keymap.set('i', 'jk', '<Esc>', kopts)
vim.keymap.set('n', '<leader>wf', '<cmd>w<cr>', kopts)
vim.keymap.set('n', '<leader>qq', '<cmd>q<cr>', kopts)
vim.keymap.set('n', '<leader>rw', ':grep<c-r><c-w><CR>', kopts)
vim.keymap.set('n', '<leader>rg', ':grep ', kopts)
vim.keymap.set('n', '<leader>fd', ':find ', kopts)

vim.keymap.set('n', '<c-space>', [[<cmd>lua require('cmp').complete()]], kopts)

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
vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>', kopts)

vim.keymap.set('n', '<leader>dd', ':Lexplore %:p:h<CR>', kopts) -- open netrw in the dir of the current file
vim.keymap.set('n', '<leader>da', ':Lexplore<CR>', kopts) -- open netrw en the current working dir

vim.keymap.set('n', '<leader>?', '<cmd>History<CR>', { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sb', '<cmd>Buffers<CR>', { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', '<cmd>BLines<CR>', { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', '<cmd>Files<CR>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', '<cmd>Helptags<CR>', { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', ':Rg ', { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', '<cmd>Rg<CR>', { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>le', vim.diagnostic.setloclist)


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

require('colorizer').setup({
    filetypes = { 'css' }
})

require('Comment').setup({})

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'lua', 'javascript', 'typescript', 'help', 'json', 'html', 'css' },
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

local on_attach = function(_, bufnr)
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

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end


local servers = { 'tsserver', 'cssls', 'cssmodules_ls' }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


local prettier = { formatCommand = "prettier --stdin --stdin-filepath ${INPUT}", formatStdin = true }

local languages = {
    typescript = { prettier }, 
    javascript = { prettier }, 
    javascriptreact = { prettier }, 
    typescriptreact = { prettier }, 
    json = { prettier }, 
    css = { prettier }
}

require('lspconfig').efm.setup {
    cmd = {  home .. '/.efm-langserver/bin/efm-langserver' },
    init_options = { documentFormatting = true, codeAction = true },
    filetypes = { 'typescriptreact', 'javascriptreact', 'javascript', 'typescript', 'json', 'css' },
    settings = { languages = languages },
    on_attach = on_attach,
    capabilities = capabilities,
}

require'lspconfig'.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all"
        },
    }
}

local cmp = require 'cmp'
local snippy = require 'snippy'

cmp.setup {
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            snippy.expand_snippets(args.body)
        end,
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu = ({ buffer = '[Buffer]', nvim_lsp = '[LSP]', snippy = '[Snippy]', nvim_lua = '[Lua]' })[entry.source.name]
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


vim.cmd[[
nnoremap <leader>bk <cmd>bp\|bd! #<CR>

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']

let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit',
\ 'ctrl-q': 'fill_quickfix'}

hi DiagnosticUnderlineError ctermfg=red guifg=#db4b4b cterm=undercurl gui=undercurl
hi DiagnosticUnderlineWarn ctermfg=yellow guifg=#eeaf58 cterm=undercurl gui=undercurl
hi DiagnosticUnderlineInfo ctermfg=red guifg=#1cbc9b cterm=undercurl gui=undercurl
hi DiagnosticUnderlineHint ctermfg=blue guifg=#4bc1fe cterm=undercurl gui=undercurl

hi! link netrwMarkFile Search
]]
