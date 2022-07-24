local home = os.getenv("HOME")
local opts = {noremap = true, silent = true}
local nvim_lsp = require 'lspconfig'
local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- ................................................................................
-- Lua plugin setup

require("nvim-lsp-installer").setup({})

require("lsp_signature").setup({})

-- ................................................................................
-- Custom symbols

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end
-- ................................................................................
-- Code action sign (with virtual text)

code_action = {}

local function get_namespace()
    return vim.api.nvim_create_namespace("mycodeactionsign")
end

local function indication_virtual_text(bufnr, line)
    local namespace = get_namespace()
    vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    if not line then return end
    local icon_with_indent = "  " .. ""
    vim.api.nvim_buf_set_extmark(bufnr, namespace, line, -1, {
        virt_text = { { icon_with_indent, "MyCodeActionSign" } },
        virt_text_pos = "overlay",
        hl_mode = "combine",
    })
end

-- TODO: apply this on for file types with language server available
local codeaction_indication = function (do_clear)
    local bufnr = vim.api.nvim_get_current_buf()
    if do_clear == "clear" then
        return indication_virtual_text(bufnr)
    end
    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
    local params = vim.lsp.util.make_range_params()
    params.context = context
    local line = params.range.start.line
    vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(_, _, result)
        if not result or type(result) ~= "table" or vim.tbl_isempty(result) then
            return indication_virtual_text(bufnr)
        else
            return indication_virtual_text(bufnr, line)
        end
    end)
end

code_action.listener = function()
    local augroup = vim.api.nvim_create_augroup("CodeActionIndication", {clear = true})

    vim.api.nvim_create_autocmd("CursorHold", {
        pattern = "*.*",
        group = augroup,
        callback = function()
            codeaction_indication()
        end
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*.*",
        group = augroup,
        callback = function()
            codeaction_indication("clear")
        end
    })
end

vim.api.nvim_set_hl(0, 'MyCodeActionSign', {fg = "gray40", bg = "NONE"})

-- ................................................................................
-- Configuring appearence of diagnostics

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = {
      source = 'always',
      -- border = 'rounded',
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

    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
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

    -- if client then
    --     code_action.listener()
    -- end

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
-- Configuration for completion using: cmp-nvim-lsp, cmp-buffer, cmp-path and nvim-cmp

cmp.setup({
    window = {
        documentation = cmp.config.window.bordered(),
    },
    completion= {
        autocomplete = false
    },
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    formatting = {
        format = function(entry, vim_item)
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'buffer', keyword_length = 3, max_item_count = 10,},
    }),
    enabled = function ()
        local context = require('cmp.config.context')
        if vim.api.nvim_get_mode() == 'c' then
            return true
        else
            return not context.in_syntax_group("Comment")
        end
    end
})

-- ................................................................................
-- Attach each language server being used

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.sumneko_lua.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.html.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

local formatting = require('null-ls').builtins.formatting
local diagnostics = require('null-ls').builtins.diagnostics
local code_actions = require('null-ls').builtins.code_actions
local completion = require('null-ls').builtins.completion

-- ................................................................................
-- Configuration for linters and formatters

require('null-ls').setup({
    sources = {
        formatting.prettier.with({
            prefer_local = "node_modules/.bin",
        }),
        diagnostics.eslint.with({
            prefer_local = "node_modules/.bin",
        }),
        code_actions.eslint.with({
            prefer_local = "node_modules/.bin",
        }),
        diagnostics.luacheck.with({
            command = home .. "/.asdf/installs/lua/5.4.4/luarocks/bin/luacheck",
        }),
        completion.luasnip,
    }
})
