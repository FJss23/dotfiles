local home = os.getenv("HOME")
local lsp_route = home .. "/.local/share/nvim/lsp_servers"
local opts = { noremap = true, silent = true }
local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- ................................................................................
-- Lua plugins setup

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    autotag = { enable = true },
    context_commentstring = {
        enable = true,
    },
    indent = {
        enable = true
    }
})
require('treesitter-context').setup({
    highlight = { enable = true },
    indent = { enable = true }
})
require('nvim-autopairs').setup({})
require('gitsigns').setup({})
require('colorizer').setup({})
require('nvim-custom-diagnostic-highlight').setup({})
require('nvim-tree').setup({
    view = {
        width = 40,
        side = "right"
    },
    renderer = {
        icons =  {
            git_placement = "after"
        }
    }
})
require('nvim-web-devicons').setup({})

-- ................................................................................
-- Custom symbols for LSP

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- ................................................................................
-- Configuring appearence of diagnostics

vim.diagnostic.config({
    virtual_text = { 
        source = "always" 
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
    float = {
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

vim.o.updatetime = 350

-- ................................................................................
-- Configuring keyword mapping for each Language (not all the functionality is supported for
-- every language

vim.keymap.set('n', '<space>le', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>n', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<space>N', vim.diagnostic.goto_next, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>gW', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<space>gw', vim.lsp.buf.document_symbol, bufopts)
    vim.keymap.set('n', '<space>fc', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>ai', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<space>ao', vim.lsp.buf.outgoing_calls, bufopts)

    if client.server_capabilities.documentHighlightProvider then
        vim.cmd [[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=gray18
        hi! LspReferenceText cterm=bold ctermbg=red guibg=gray18
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=gray18
      ]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
        })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

-- ................................................................................
-- Configuration for completion

cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({ buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]" })[
                entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
    }),
    enabled = function()
        local context = require('cmp.config.context')
        if vim.api.nvim_get_mode() == 'c' then
            return true
        else
            return not context.in_syntax_group("Comment")
        end
    end
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ................................................................................
-- JSON

require('lspconfig').jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- CSS

require('lspconfig').cssls.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- HTML

require('lspconfig').html.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- JAVASCRIP/TYPESCRIPT

require('lspconfig').tsserver.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- GO

require('lspconfig').gopls.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- CSS_MODULES

require('lspconfig').cssmodules_ls.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- TAILWINDCSS

require('lspconfig').tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- DOCKER

require('lspconfig').dockerls.setup({ on_attach = on_attach, capabilities = capabilities })

-- ................................................................................
-- LUA (special settings, because of neovim. It can make the lsp slow)

require('lspconfig').sumneko_lua.setup({
    cmd = { lsp_route .. "/sumneko_lua/extension/server/bin/lua-language-server" },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- ................................................................................
-- EFM (linters and formatters)

local prettier = {
    formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
    formatStdin = true
}
local eslint = {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m" },
    rootMakers = {
        '.eslintrc',
        '.eslintrc.cjs',
        '.eslintrc.js',
        '.eslintrc.json',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        'package.json',
    }
}
local luacheck = {
    lintCommand = home .. "/.asdf/installs/lua/5.4.4/luarocks/bin/luacheck %s --codes --no-color --quiet -",
    lintStdin = true,
    lintFormats = { "%.%#:%l:%c: (%t%n) %m" },
    rootMakers = { ".luacheckrc" }
}
local languages = {
    typescript = { prettier, eslint },
    javascript = { prettier, eslint },
    typescriptreact = { prettier, eslint },
    javascriptreact = { prettier, eslint },
    lua = { luacheck },
}

require('lspconfig').efm.setup({
    cmd = { lsp_route .. "/efm/efm-langserver" },
    init_options = { documentFormatting = true, codeAction = true },
    filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'markdown', 'lua' },
    settings = { languages = languages, log_level = 1, log_file = lsp_route .. "/efm/efm.log" },
    on_attach = on_attach,
    capabilities = capabilities,
})

require('code_action_utils').listener()
require('status_line')
