--[[
    This file contains the configuration for native Neovim LSP, using the following plugins:
    1. neovim-lspconfig
    2. cmp-nvim-lsp
    3. nvim-compe

    List of lsp configured:
    1. CSS / JSON / HTML
    2. CSS Modules
    3. Zig
    4. Javascript / Typescript
    5. Lua
    6. Python
    7. EFM (lint and formatting)
    8. Go
    9. C
    10. Tailwind

    A few considerations:
    * luasnip is used in this file, because is configured using nvim-compe
    * This file if full of comments
--]]

-- Behavior for diagnostics
vim.diagnostic.config({
    virtual_text = {
      prefix = '•'
    },
    update_in_insert = false,
})

vim.o.updatetime = 350
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Lsp background popup
-- VS code
-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#272727]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#272727]]
-- Gruvbox
-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#3c3836]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#3c3836]]

-- local border = {
--       {"🭽", "FloatBorder"},
--       {"▔", "FloatBorder"},
--       {"🭾", "FloatBorder"},
--       {"▕", "FloatBorder"},
--       {"🭿", "FloatBorder"},
--       {"▁", "FloatBorder"},
--       {"🭼", "FloatBorder"},
--       {"▏", "FloatBorder"},
-- }

-- local handlers =  {
--   ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
--   ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
-- }

-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

local nvim_lsp = require'lspconfig'

-- Define the keymaps for lsp client
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
  buf_set_keymap('n', '<space>u', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Show lsp diagnostic of the current file in the location list
vim.api.nvim_set_keymap('n','<space>e', ':lua vim.diagnostic.setloclist() <CR>', { noremap = true })

-- Change the icons of lsp 'events'
local signs = { Error = '', Warn = '', Hint = '', Info = '' }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local cmp_kinds = {
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = " ",
  Variable = " ",
  Class = "ﴯ" ,
  Interface = " ",
  Module = " ",
  Property = "ﰠ" ,
  Unit = " ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = " ",
  Event = " ",
  Operator = " ",
  TypeParameter = " "
}

-- Use the completion engine and include snippets
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
  formatting = {
	  format = function(_, vim_item)
        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
        return vim_item
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
    { name = 'buffer', max_item_count = 10 },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- LSP: CSS, JSON, HTML, CSS Modules, Zig, Python and Tailwind CSS
local servers = { 'cssls', 'jsonls', 'html', 'cssmodules_ls', 'zls','pyright', 'tailwindcss' }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
   capabilities = capabilities,
   on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- LSP: Javascript / Typescript
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

-- LSP: Go (Inlcudes function for autoimport functionality)
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
  },
}

function goimports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

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

vim.api.nvim_exec([[autocmd BufWritePre *.go lua goimports(1000)]], false)

-- LSP: C
nvim_lsp.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}

-- LSP: Lua
local sumneko_root_path = "/home/frandev/.lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  lags = {
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

-- LSP: EFM (linters and formatters)
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

-- Lsp cmp colors for suggestions
-- VS Code color
vim.cmd [[highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080]]
vim.cmd [[highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6]]
vim.cmd [[highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE]]
vim.cmd [[highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0]]
vim.cmd [[highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0]]
vim.cmd [[highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4]]
-- Gruvbox material
-- vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy Aqua]]
-- vim.cmd [[highlight! link CmpItemKindText Fg]]
-- vim.cmd [[highlight! link CmpItemKindMethod Purple]]
-- vim.cmd [[highlight! link CmpItemKindFunction Purple]]
-- vim.cmd [[highlight! link CmpItemKindConstructor Green]]
-- vim.cmd [[highlight! link CmpItemKindField Aqua]]
-- vim.cmd [[highlight! link CmpItemKindVariable Blue]]
-- vim.cmd [[highlight! link CmpItemKindClass Green]]
-- vim.cmd [[highlight! link CmpItemKindInterface Green]]
-- vim.cmd [[highlight! link CmpItemKindValue Orange]]
-- vim.cmd [[highlight! link CmpItemKindKeyword Keyword]]
-- vim.cmd [[highlight! link CmpItemKindSnippet Red]]
-- vim.cmd [[highlight! link CmpItemKindFile Orange]]
-- vim.cmd [[highlight! link CmpItemKindFolder Orange]]
