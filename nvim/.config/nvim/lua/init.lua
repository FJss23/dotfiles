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

-- vim.cmd.colorscheme "nordfox"
vim.cmd.colorscheme "tokyonight-night"
vim.opt.inccommand = 'split'
vim.opt.guicursor = 'i:block'

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

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

-- local fzf_lua = require('fzf-lua')
-- fzf_lua.setup({
--   "telescope",
--   winopts = {
--     split = "belowright new",
--     preview = {
--       hidden = "hidden"
--     }
--   }
-- })

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


local signs = { Error = "» ", Warn = "» ", Hint = "» ", Info = "» " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
    client.server_capabilities.semanticTokensProvider = nil

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gI', fzf_lua.lsp_implementations, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- vim.keymap.set('n', '<leader>D', fzf_lua.lsp_typedefs, opts)
    -- vim.keymap.set('n', '<leader>ds', fzf_lua.lsp_document_symbols, opts)
    -- vim.keymap.set('n', '<leader>ws', fzf_lua.lsp_live_workspace_symbols, opts)
    -- vim.keymap.set('n', '<leader>dw', fzf_lua.diagnostics_workspace, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<space>ca', fzf_lua.lsp_code_actions, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', fzf_lua.lsp_references, opts)
    -- vim.keymap.set('n', '<leader>li', fzf_lua.lsp_incoming_calls, opts)
    -- vim.keymap.set('n', '<leader>lo', fzf_lua.lsp_outgoing_calls, opts)
    -- Lua
    vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
    vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
    vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
    vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
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

cmp.setup.filetype({ 'sql' }, {
  sources = {
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
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
          }
        }
      }
    }
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup {
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
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true
          }
        }
      },
    }
  end,
  ['jdtls'] = function()
    -- jdtls is handled by nvim-jdtls
  end,
})

keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', { silent = true })

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
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

keymap.set('n', '<leader>sf', "<cmd>Pick files too='git'<cr>", {})
keymap.set('n', '<leader>sg', "<cmd>Pick grep_live<cr>", {})
keymap.set('n', '<leader>sb', "<cmd>Pick buffers<cr>", {})
keymap.set('n', '<leader>sn', "<cmd>Pick resume<cr>", {})
-- keymap.set('n', '<leader>sd', "<cmd>Pick diagnostics<cr>", {})
-- keymap.set('n', '<leader>si', "<cmd>Pick git_hunks<cr>", {})
-- keymap.set('n', '<leader>sc', "<cmd>Pick git_commits<cr>", {})
-- keymap.set('n', '<leader>sr', "<cmd>Pick git_branches<cr>", {})
-- keymap.set('n', '<leader>s.', "<cmd>Pick oldfiles<cr>", {})

-- keymap.set('n', '<leader>sf', fzf_lua.files, {})
-- keymap.set('n', '<leader>sg', fzf_lua.live_grep, {})
-- keymap.set('n', '<leader>sd', fzf_lua.diagnostics_document, {})
-- keymap.set('n', '<leader>si', fzf_lua.git_status, {})
-- keymap.set('n', '<leader>sc', fzf_lua.git_commits, {})
-- keymap.set('n', '<leader>sr', fzf_lua.git_branches, {})
-- keymap.set('n', '<leader>sb', fzf_lua.buffers, {})
-- keymap.set('n', '<leader>s.', fzf_lua.oldfiles, {})
-- keymap.set('n', '<leader>sn', fzf_lua.resume, {})

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- local gwidth = vim.api.nvim_list_uis()[1].width
-- local gheight = vim.api.nvim_list_uis()[1].height
-- local width = 60
-- local height = 20

-- require('nvim-tree').setup({
--   view = {
--     width = width,
--     float = {
--       enable = true,
--       open_win_config = {
--         relative = "editor",
--         width = width,
--         height = height,
--         row = (gheight - height) * 0.4,
--         col = (gwidth - width) * 0.5,
--       }
--     }
--   },
--   diagnostics = {
--     enable = true
--   },
--   modified = {
--     enable = true
--   }
-- })

-- keymap.set('n', '-', '<cmd>NvimTreeFindFileToggle<CR>', {})

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

api.nvim_create_autocmd('BufWritePre', {
  pattern = "*",
  callback = function(args)
    require('conform').format({ bufnr = args.buf })
  end,
})

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

if vim.g.neovide then
  vim.opt.guifont = "JetBrainsMono Nerd Font:h11"
  vim.opt.linespace = 4
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
end

-- require('render-markdown').setup({
--   start_enabled = false
-- })

keymap.set('n', '<leader>rm', '<cmd>RenderMarkdownToggle<CR>', {})

-- DAP configuration
require('dapui').setup()
require('dap-go').setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

keymap.set('n', '<leader>dbb', dap.toggle_breakpoint)
keymap.set('n', '<F3>', dap.continue)
keymap.set('n', '<F4>', dap.step_into)
keymap.set('n', '<F5>', dap.step_over)
keymap.set('n', '<F6>', dap.step_out)
keymap.set('n', '<F7>', dap.step_back)
keymap.set('n', '<F8>', dap.restart)

-- require('nvim-dap-virtual-text').setup({})

require('statusline')

require('oil').setup({
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime"
  },
  view_options = {
    show_hidden = true
  }
})

vim.keymap.set("n", "-", "<cmd>lua require('oil').toggle_float()<cr>", {})

require('glance').setup()

require('mini.pick').setup()
-- require('mini.extra').setup()

-- require('trouble').setup()
-- vim: ts=2 sts=2 sw=2 et
