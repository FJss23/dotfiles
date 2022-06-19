local home = os.getenv("HOME")
local opts = {noremap = true, silent = true}
local nvim_lsp = require 'lspconfig'
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_kinds = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = "ﰠ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = "פּ",
    Event = " ",
    Operator = " ",
    TypeParameter = " "
}

-- ................................................................................
-- Configuring Icons that will appear next to errors

vim.diagnostic.config({
    virtual_text = {prefix = ' '},
    update_in_insert = false,
    float = {focusable = false, header = "", prefix = ""}
})
vim.o.updatetime = 350

vim.cmd [[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

-- ................................................................................
-- Configuring keyword mapping for each Language (not all the functionality is supported for
-- every language

vim.keymap.set('n', '<space>le', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>u', vim.lsp.buf.formatting, bufopts)

    if client.resolved_capabilities.document_highlight then
        vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=red guibg=gray22
      hi! LspReferenceText cterm=bold ctermbg=red guibg=gray22
      hi! LspReferenceWrite cterm=bold ctermbg=red guibg=gray22
    ]]
        vim.api.nvim_create_augroup('lsp_document_highlight', {})
        vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.document_highlight
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            group = 'lsp_document_highlight',
            buffer = 0,
            callback = vim.lsp.buf.clear_references
        })
    end
end

-- ................................................................................
-- Configuration for completion using: cmp-nvim-lsp, cmp-buffer, cmp-path and nvim-cmp

cmp.setup({
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. ' ' .. vim_item.kind .. ' '
            vim_item.menu =
                ({buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]"})[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp', max_item_count = 5},
        {name = 'buffer', max_item_count = 5},
        {name = 'nvim_lsp_signature_help'},
        {name = 'path'}
    }, {{name = 'buffer', max_item_count = 5}})
})


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- ................................................................................
-- LSP: CSS, JSON, HTML, CSS Modules, Tailwind CSS, Bash and Docker

local servers = {'cssls', 'jsonls', 'html', 'cssmodules_ls', 'tailwindcss', 'bashls', 'dockerls'}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {capabilities = capabilities, on_attach = on_attach, flags = {debounce_text_changes = 150}}
end

-- ................................................................................
-- LSP: Javascript / Typescript

nvim_lsp.tsserver.setup {
---@diagnostic disable-next-line: undefined-global
    capabilities = capabilites,
    on_attach = function(client, bufnr)
        if client.config.flags then client.config.flags.allow_incremental_sync = true end
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {debounce_text_changes = 150}
}

-- ................................................................................
-- LSP: C

nvim_lsp.ccls.setup {init_options = {cache = {directory = ".ccls-cache"}}, flags = {debounce_text_changes = 150}}

-- ................................................................................
-- LSP: Lua

local sumneko_root_path = home .. "/.lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    lags = {debounce_text_changes = 150},
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = runtime_path},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    }
}

-- ................................................................................
-- LSP: Rust-analyzer

nvim_lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {importGranularity = "module", importPrefix = "self"},
            cargo = {loadOutDirsFromCheck = true},
            procMacro = {enable = true}
        }
    }
}

-- ................................................................................
-- LSP: Go

nvim_lsp.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = nvim_lsp.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  }

function OrgImports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
end
