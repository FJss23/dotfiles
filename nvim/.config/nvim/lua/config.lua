local home = os.getenv("HOME")
local opts = {noremap = true, silent = true}
local nvim_lsp = require 'lspconfig'
local cmp = require 'cmp'
local luasnip = require 'luasnip'

-- ................................................................................
-- Configuring Icons that will appear next to errors

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.o.updatetime = 350

local signs = { Error = "ᐳᐳ", Warn = "ᐳᐳ" , Hint = "ᐳᐳ", Info = "ᐳᐳ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>gW', vim.lsp.buf.workspace_symbol, bufopts)
    vim.keymap.set('n', '<space>fc', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>ai', vim.lsp.buf.incoming_calls, bufopts)
    vim.keymap.set('n', '<space>ao', vim.lsp.buf.outgoing_calls, bufopts)
    vim.keymap.set('n', '<space>gw', vim.lsp.buf.document_symbol, bufopts)
end

-- ................................................................................
-- Configuration for completion using: cmp-nvim-lsp, cmp-buffer, cmp-path and nvim-cmp

cmp.setup({
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
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'buffer', max_item_count = 10},
    }, {{name = 'buffer'}}),
    enabled = false
    -- enabled = function ()
    --     local context = require('cmp.config.context')
    --     if vim.api.nvim_get_mode() == 'c' then
    --         return true
    --     else
    --         return not context.in_treesitter_capture("comment")
    --         and not context.in_syntax_group("Comment")
    --     end
    -- end
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
          shadow = true,
        },
        staticcheck = true,
      },
    },
    init_options = {
        usePlaceholders = true
    }
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

-- ................................................................................
-- LSP: EFM

local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  rootMarkers = {
    '.eslintrc',
    '.eslintrc.cjs',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    'package.json',
  },
}

local lua_check = {
    lintCommand = home .. "/.asdf/installs/lua/5.4.4/luarocks/bin/luacheck --codes --no-color --quiet ${INPUT}",
    lintStdin = true,
    lintFormats = {'%.%#:%l:%c: (%t%n) %m'},
    rootMarkers = { '.luacheckrc' },
}

local languages = {
  typescript = {eslint},
  javascript = {eslint},
  typescriptreact = {eslint},
  javascriptreact = {eslint},
  lua = {lua_check}
}

nvim_lsp.efm.setup {
  cmd = { home .. "/.efm-langserver/efm-langserver"},
  init_options = {documentFormatting = true},
  flags = {
    debounce_text_changes = 150,
  },
  settings = {rootMarkers = {".git/"}, languages = languages, log_level = 1, log_file = home .. '/.efm-langserver/efm.log'},
}

-- ................................................................................
-- Status line configuration

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
    if fpath == "" or fpath == "." then return " " end

    return string.format(" %%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand "%:t"
    if fname == "" then return "" end
    return fname .. " "
end

local function lsp()
    local count = {}
    local levels = {errors = "Error", warnings = "Warn", info = "Info", hints = "Hint"}

    for k, level in pairs(levels) do count[k] = vim.tbl_count(vim.diagnostic.get(0, {severity = level})) end

    return "[E" .. count["errors"] .. " W" .. count["warnings"] .. " H" .. count["hints"] .. " I" .. count["info"] ..
               "]"
end

local function filetype() return "[" .. string.format("%s", vim.bo.filetype) .. "]" end

local function lineinfo()
    if vim.bo.filetype == "alpha" then return "" end
    return " %l,%c %L "
end

local vcs = function()
    local git_info = vim.fn["fugitive#statusline"]()
    if git_info then
        local branch_name = git_info:sub(6, git_info:len() - 2)
        return table.concat {" [", branch_name, "] "}
    end
    return " [NO VCS]"
end

statusline = {}

statusline.active = function()
    return table.concat {
        " [%n]",filepath(), filename(), "%m%r", "%=", lsp(), vcs(),
        "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }", filetype(), lineinfo()
    }
end

function statusline.inactive() return " %F" end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline.inactive()
  augroup END
]], false)

require('neogen').setup()

require("lsp_signature").setup({})

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true
  },
  highlight = { enable = false },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

require("treesitter-context").setup({
    enable = false
})
