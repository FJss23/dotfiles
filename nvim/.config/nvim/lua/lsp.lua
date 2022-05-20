-- LSP: HTML, CSS, JSON, CSS Modules, Tailwdind CSS, Typescript,
--      C, Rust, Lua & efm (linting and formatting)
vim.diagnostic.config({
    virtual_text = {
      prefix = ' '
    },
    update_in_insert = false,
    float = {
	    focusable = false,
    	-- style = "minimal",
	    -- border = "solid",
	    -- source = "always",
	    header = "",
	    prefix = "",
    },
})

vim.o.updatetime = 350

-- @Info floating window on hover
-- local border = {
--     {"┌", "FloatBorder"},
--     {"─","FloatBorder"},
--     {"┐", "FloatBorder"},
--     {"│","FloatBorder"},
--     {"┘","FloatBorder"},
--     {"─", "FloatBorder"},
--     {"└","FloatBorder"},
--     {"│", "FloatBorder"},
-- }

-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or border
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end


local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

local nvim_lsp = require'lspconfig'

-- Define the keymaps for lsp client
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>u', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi! LspReferenceRead cterm=bold ctermbg=red guibg=gray27
      hi! LspReferenceText cterm=bold ctermbg=red guibg=gray27
      hi! LspReferenceWrite cterm=bold ctermbg=red guibg=gray27
    ]]
    vim.api.nvim_create_augroup('lsp_document_highlight', {})
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = 'lsp_document_highlight',
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end

  -- @Info Floating window on hover
  -- vim.api.nvim_create_autocmd("CursorHold", {
  --   buffer = bufnr,
  --   callback = function()
  --     local opts = {
  --       focusable = false,
  --       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --       border = 'single',
  --       source = 'always',
  --       prefix = ' ',
  --       scope = 'cursor',
  --     }
  --     vim.diagnostic.open_float(nil, opts)
  --   end
  -- })
end


-- Change the icons of lsp 'events'
local signs = {Error = " ", Warn = " ", Hint = " ", Info = " "}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local cmp_kinds = {
  Text = " ",
	Method = " ",
	Function = " ",
	Constructor = " ",
	Field = "ﰠ" ,
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
	Struct = "פּ" ,
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}


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
	  format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. ' ' .. vim_item.kind .. ' '
      	  -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
              latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end,
  },
  -- @Info border for completion
  -- window = {
		-- completion = {
			-- border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		-- },
		-- documentation = {
			-- border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		-- },
	-- },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', max_item_count = 3 },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

local augroup = vim.api.nvim_create_augroup("luasnip-expand", { clear=true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group    = augroup,
  pattern  = "*:s",
  callback = function ()
    if luasnip.in_snippet() then
      return vim.diagnostic.disable()
    end
  end
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group    = augroup,
  pattern  = "[is]:n",
  callback = function ()
    if luasnip.in_snippet() then
      return vim.diagnostic.enable()
    end
  end
})


local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- LSP: CSS, JSON, HTML, CSS Modules, Zig, Python and Tailwind CSS
local servers = { 'cssls', 'jsonls', 'html', 'cssmodules_ls', 'tailwindcss' }

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


-- LSP: C
nvim_lsp.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  },
  flags = {
    debounce_text_changes = 150,
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

-- LSP: Rust-analyzer
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
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

-- Some lua snip configuration
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
    return ""
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

vim.api.nvim_set_keymap("i", "<C-s>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-s>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-d>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<C-d>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
