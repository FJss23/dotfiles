-- local nightfox = require('nightfox')
-- local palettes = {
--   nordfox = {
--     comment = "#a0a0a0"
--   }
-- }

-- nightfox.setup({
--   options = {
--     transparent = true
--   },
--   palettes = palettes
-- })

vim.cmd.colorscheme "tokyonight-night"
vim.opt.background = "dark"
vim.opt.inccommand = 'split'
vim.opt.guicursor = 'i:block'

-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    use_languagetree = false,
    disable = function(_, bufnr)
      local buf_name = vim.api.nvim_buf_get_name(bufnr)
      local file_size = vim.api.nvim_call_function("getfsize", { buf_name })
      return file_size > 256 * 1024
    end,
    max_file_lines = 10000
  },
  indent = { enable = false },
  endwise = { enable = true },
})
-- }}}

vim.g.skip_ts_context_commentstring_module = true

vim.keymap.set('n', '<leader>tc', ':TSContextToggle<CR>', { desc = 'Toggle TS Context' })

-- local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Lsp Config {{{
local function organize_imports()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end

local fzf_lua = require('fzf-lua')
fzf_lua.setup({
  "telescope",
  winopts = {
    split = "belowright new",
    preview = {
      hidden = "hidden"
    }
  }
})

vim.diagnostic.config({
  virtual_text = false, --{ source = "always" },
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


local signs = { Error = "»", Warn = "»", Hint = "»", Info = "»" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- require('telescope').setup({})
-- local builtin = require('telescope.builtin')

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
    if client ~= nil then
      client.server_capabilities.semanticTokensProvider = nil
    end
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)    -- GLANCE
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)     -- GLANCE
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts) -- GLANCE
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', fzf_lua.lsp_typedefs, opts) -- GLANCE
    -- vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, opts)
    -- vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, opts)
    vim.keymap.set('n', '<leader>dw', fzf_lua.diagnostics_workspace, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', fzf_lua.lsp_code_actions, opts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, opts)
    -- vim.keymap.set('n', '<leader>li', builtin.lsp_incoming_calls, opts)
    -- vim.keymap.set('n', '<leader>lo', builtin.lsp_outgoing_calls, opts)

    -- vim.keymap.set('n', 'gD', builtin.lsp_definitions, opts)
    -- vim.keymap.set('n', 'gR', builtin.lsp_references, opts)
    -- vim.keymap.set('n', 'gY', builtin.lsp_type_definitions, opts)
    -- vim.keymap.set('n', 'gS', builtin.lsp_document_symbols, opts)
    -- vim.keymap.set('n', 'gM', vim.lsp.buf.implementation, opts)

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint and client.server_capabilities.codeLensProvider then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.lsp.codelens.refresh({ buffer = ev.bufnr, client = client })
      end)
    end
  end,
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = {
      follow_cursor = true,
    }
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<C-h>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 5, group_index = 1, max_item_count = 20 },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' },
  }),
  performance = {
    trigger_debounce_time = 500,
    throttle = 550,
    fetching_timeout = 80,
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local lspconfig = require('lspconfig')

require('mason').setup()

require("mason-lspconfig").setup_handlers({
  -- default
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities
    }
  end,
  ['lua_ls'] = function()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            disable = { 'missing-fields' },
            globals = { 'vim', 'require' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false
          },
          hint = {
            enable = true
          }
        }
      }
    }
  end,
  ['ts_ls'] = function()
    lspconfig.ts_ls.setup {
      filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      capabilities = capabilities,
      commands = {
        OrganizeImports = {
          organize_imports,
          description = 'Orginze js and ts imports',
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
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
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true
          }
        }
      },
    }
  end,
  -- ['jdtls'] = function()
  -- jdtls is handled by nvim-jdtls
  -- end,
})

keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', { silent = true })

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1], {})
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

-- keymap.set('n', '<leader>sf', builtin.find_files, {})
-- keymap.set('n', '<leader>sg', builtin.live_grep, {})
-- keymap.set('n', '<leader>sd', builtin.diagnostics, {})
-- keymap.set('n', '<leader>si', builtin.git_status, {})
-- keymap.set('n', '<leader>sc', builtin.git_commits, {})
-- keymap.set('n', '<leader>sr', builtin.git_branches, {})
-- keymap.set('n', '<leader>sb', builtin.buffers, {})
-- keymap.set('n', '<leader>s.', builtin.oldfiles, {})
-- keymap.set('n', '<leader>sn', builtin.resume, {})

keymap.set('n', '<leader>sf', fzf_lua.files, {})
keymap.set('n', '<leader>sg', fzf_lua.live_grep, {})
keymap.set('n', '<leader>sd', fzf_lua.diagnostics_document, {})
keymap.set('n', '<leader>si', fzf_lua.git_status, {})
keymap.set('n', '<leader>sc', fzf_lua.git_commits, {})
keymap.set('n', '<leader>sr', fzf_lua.git_branches, {})
keymap.set('n', '<leader>sb', fzf_lua.buffers, {})
keymap.set('n', '<leader>s.', fzf_lua.oldfiles, {})
keymap.set('n', '<leader>sn', fzf_lua.resume, {})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- local gwidth = vim.api.nvim_list_uis()[1].width
-- local gheight = vim.api.nvim_list_uis()[1].height
-- local width = 60
-- local height = 20

require('nvim-tree').setup({
  -- view = {
  --   width = width,
  --   float = {
  --     enable = true,
  --     open_win_config = {
  --       relative = "editor",
  --       width = width,
  --       height = height,
  --       row = (gheight - height) * 0.4,
  --       col = (gwidth - width) * 0.5,
  --     }
  --   }
  -- },
  diagnostics = {
    enable = true
  },
  modified = {
    enable = true
  }
})

keymap.set('n', '<leader>nt', '<cmd>NvimTreeFindFileToggle<CR>', {})

vim.g.user_emmet_leader_key = 'ç'
vim.g.user_emmet_settings = {
  javascript = {
    extends = 'jsx',
  },
  typescript = {
    extends = 'jsx',
  },
}

-- fzf_lua.register_ui_select()

require('conform').setup({
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  formatters_by_ft = {
    javascript      = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript      = { 'prettier' },
    typescriptreact = { 'prettier' },
    html            = { 'prettier' },
    json            = { 'prettier' },
    yaml            = { 'prettier' },
    css             = { 'prettier' },
    scss            = { 'prettier' },
    markdown        = { 'prettier' },
    go              = { 'gofmt', 'goimports' },
    lua             = { "stylelua" },
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>')

-- api.nvim_create_autocmd('BufWritePre', {
--   pattern = "*",
--   callback = function(args)
--     require('conform').format({ bufnr = args.buf })
--   end,
-- })

require('lint').linters_by_ft = {
  typescript = { 'eslint' },
  javacript = { 'eslint' },
  typescriptreact = { 'eslint' },
  javascriptreact = { 'eslint' },
  go = { 'golangcilint' },
}

local lint_augroup = api.nvim_create_augroup('lint', { clear = true })

api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    require('lint').try_lint()
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end,
  pattern = '*',
})

vim.keymap.set('n', '<leader>p', PeekDefinition)

require('statusline')

-- require('telescope').load_extension('fzf')

-- require("ibl").setup({
--   indent = { char = "▏" },
--   scope = { enabled = false }
-- })

-- require('mini.indentscope').setup({
--   draw = {
--     delay = 0
--   }
-- })

-- require('typescript-tools').setup({
--   on_attach =
--       function(client, _bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--       end,
--   settings = {
--     jsx_close_tag = {
--       enable = true,
--       filetypes = { "javascriptreact", "typescriptreact" },
--     }
--   }
-- })

-- Run gofmt + goimports on save
-- local format_sync_group = vim.api.nvim_create_augroup("goimports", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     require('go.format').goimports()
--   end,
--   group = format_sync_group
-- })

-- require('go').setup({
--   lsp_cfg = false
-- })

-- local cfg = require('go.lsp').config() -- config() return a go.nvim gopls setup

-- require('lspconfig').gopls.setup(cfg)

require("better_escape").setup({})

require('nvim-ts-autotag').setup({})

require('arrow').setup({
  leader_key = "-"
})

vim.keymap.set("n", "H", require("arrow.persist").previous)
vim.keymap.set("n", "L", require("arrow.persist").next)
vim.keymap.set("n", "<C-s>", require("arrow.persist").toggle)

require('marks').setup({})

require('treesitter-context').setup {}

require('grug-far').setup({})

vim.keymap.set({ 'n', 'x' }, '<leader>st', function()
  require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = 'grug-far: Search within range' })

vim.keymap.set({ 'n', 'x' }, '<leader>si', function()
  require('grug-far').with_visual_selection({
    startInInsertMode = false
  })
end, { desc = 'grug-far: Search within range' })

require('fyler').setup({})

-- vim: ts=2 sts=2 sw=2 et
