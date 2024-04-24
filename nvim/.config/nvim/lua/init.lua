-- require('catppuccin').setup({
--   flavour = "mocha",
--   show_end_of_buffer = true,
--   color_overrides = {
--     all = {
--       base = "#111111",
--     }
--   },
--   custom_highlights = function(_colors)
--     return {
--       StatusLine = { bg = "#252525", fg = "#ffffff" },
--       StatusLineNC = { bg = "#111111", fg = "#ffffff" },
--       WinSeparator = { fg = "#877c7c" }
--     }
--   end
-- })

-- vim.cmd.colorscheme "catppuccin"
-- local std_bg = "#1b1b1b"
-- require('tokyonight').setup({
--   -- on_colors = function(colors)
--   --   colors.bg = std_bg
--   -- end,
--   on_highlights = function(hl, c)
--     hl.Comment = {
--       fg = "#9bbebd"
--     }
--     -- hl.TelescopeNormal = {
--     --   bg = c.bg,
--     -- }
--     -- hl.TelescopeBorder = {
--     --   bg = c.bg,
--     -- }
--     -- hl.TelescopePromptBorder = {
--     --   bg = c.bg,
--     -- }
--     hl.WinSeparator = {
--       fg = "#877c7c"
--     }
--     -- hl.StatusLine = {
--     --   -- bg = "#414141"
--     --   bg = "#282828"
--     -- }
--     -- hl.StatusLineNC = {
--     --   bg = "#282828"
--     --   -- bg = c.bg
--     -- }
--   end
-- })

-- require('rose-pine').setup({
--   styles = {
--     italic = false,
--     bold = false,
--     transparency = true
--   }
-- })

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  { "🭽", "FloatBorder" },
  { "▔", "FloatBorder" },
  { "🭾", "FloatBorder" },
  { "▕", "FloatBorder" },
  { "🭿", "FloatBorder" },
  { "▁", "FloatBorder" },
  { "🭼", "FloatBorder" },
  { "▏", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local nightfox = require('nightfox')
local palettes = {
  nordfox = {
    comment = "#a0a0a0"
  }
}

nightfox.setup({
  options = {
    transparent = true
  },
  palettes = palettes
})

vim.cmd.colorscheme "nordfox"

-- vim.opt.list = true
-- vim.opt.listchars = { --[[tab = '» ',--]] trail = '·', nbsp = '␣' }
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
    -- disable = { "go", "c", "lua", "javascript", "typescript", "tsx" }
  },
  indent = { enable = false },
  endwise = { enable = true },
})
-- }}}

vim.g.skip_ts_context_commentstring_module = true

require('treesitter-context').setup({
  enable = true,
  -- separator = "-"
})

vim.keymap.set('n', '<leader>tc', ':TSContextToggle<CR>', { desc = 'Toggle TS Context' })

local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Lsp Config {{{
local function organize_imports()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end

-- local telescope = require('telescope')
-- telescope.setup({})
-- telescope.load_extension('fzf')
-- telescope.load_extension('ui-select')

-- local builtin = require 'telescope.builtin'

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
  virtual_text = { source = "always" },
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

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', 'gd', fzf_lua.lsp_definitions, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'gI', builtin.lsp_implementations, opts)
    vim.keymap.set('n', 'gI', fzf_lua.lsp_implementations, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>D', builtin.lsp_type_definitions, opts)
    vim.keymap.set('n', '<leader>D', fzf_lua.lsp_typedefs, opts)
    -- vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>ds', fzf_lua.lsp_document_symbols, opts)
    -- vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, opts)

    -- vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, opts)
    vim.keymap.set('n', '<leader>ws', fzf_lua.lsp_live_workspace_symbols, opts)
    vim.keymap.set('n', '<leader>dw', fzf_lua.diagnostics_workspace, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>ca', fzf_lua.lsp_code_actions, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
    vim.keymap.set('n', 'gr', fzf_lua.lsp_references, opts)

    -- vim.keymap.set('n', '<leader>li', builtin.lsp_incoming_calls, opts)
    -- vim.keymap.set('n', '<leader>lo', builtin.lsp_outgoing_calls, opts)
    vim.keymap.set('n', '<leader>li', fzf_lua.lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>lo', fzf_lua.lsp_outgoing_calls, opts)

    -- TODO(fj): the neovim version that you are using doesn't support inlay_hint
    -- if client.supports_method(vim.lsp.protocol.textDocument_inlayHint) then
    --   local bufnr = ev.buf
    --   local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })

    --   -- Initial inlay hint display.
    --   -- Idk why but without the delay inlay hints aren't displayed at the very start.
    --   vim.defer_fn(function()
    --     local mode = vim.api.nvim_get_mode().mode
    --     vim.lsp.inlay_hint.enable(bufnr, mode == 'n' or mode == 'v')
    --   end, 500)

    --   vim.api.nvim_create_autocmd('InsertEnter', {
    --     group = inlay_hints_group,
    --     desc = 'Enable inlay hints',
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.inlay_hint.enable(bufnr, false)
    --     end,
    --   })
    --   vim.api.nvim_create_autocmd('InsertLeave', {
    --     group = inlay_hints_group,
    --     desc = 'Disable inlay hints',
    --     buffer = bufnr,
    --     callback = function()
    --       vim.lsp.inlay_hint.enable(bufnr, true)
    --     end,
    --   })
    -- end
  end,
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  -- enabled = function()
  --   return not cmp.config.context.in_syntax_group("Comment")
  -- end,
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
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
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
    { name = 'luasnip' }, -- For vsnip users.
    -- { name = 'path' },
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

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
      capabilities = capabilities,
      commands = {
        OrganizeImports = {
          organize_imports,
          description = 'Orginze js and ts imports',
        },
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = function(
          _,
          result,
          ctx,
          config
        )
          if result.diagnostics == nil then
            return
          end

          -- ignore some tsserver diagnostics
          local idx = 1
          while idx <= #result.diagnostics do
            local entry = result.diagnostics[idx]

            local formatter = require('format-ts-errors')[entry.code]
            entry.message = formatter and formatter(entry.message) or entry.message

            -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
            if entry.code == 80001 then
              -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
              table.remove(result.diagnostics, idx)
            else
              idx = idx + 1
            end
          end

          vim.lsp.diagnostic.on_publish_diagnostics(
            _,
            result,
            ctx,
            config
          )
        end
      }
    }
  end,
  --[[['yamlls'] = function()
        lspconfig.yamlls.setup {
            capabilities = capabilities,
            yaml = {
                schemaStore = {
                    url = 'https://www.schemastore.org/api/json/catalog.json',
                    enable = true,
                },
            },
        }
    end,--]]
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
        }
      },
    }
  end,
  -- ['efm'] = function()
  --     lspconfig.efm.setup {
  --         capabilities = capabilities,
  --         on_attach = function(client, bufnr)
  --             vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --             vim.api.nvim_create_autocmd("BufWritePre", {
  --               group = augroup,
  --               buffer = bufnr,
  --               callback = function()
  --                 vim.lsp.buf.format()
  --               end,
  --             })
  --         end,
  --         init_options = {
  --             documentFormatting = true,
  --             codeActions = true,
  --         },
  --         cmd = { 'efm-langserver', '-c', home .. '/.config/efm-langserver/config.yaml' },
  --         filetypes = {
  --             'javascriptreact',
  --             'javascript',
  --             'typescript',
  --             'typescriptreact',
  --             'markdown',
  --             'css',
  --             'scss',
  --             'go',
  --             'html',
  --         },
  --     }
  -- end,
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

-- require('conform').setup({
--     formatters_by_ft = {
--         javascript = { 'prettier' },
--         javascriptreact = { 'prettier' },
--         typescript = { 'prettier' },
--         typescriptreact  = { 'prettier' },
--         html  = { 'prettier' },
--         json  = { 'prettier' },
--         yaml  = { 'prettier' },
--         css  = { 'prettier' },
--         scss  = { 'prettier' },
--         markdown  = { 'prettier' },
--         go  = { 'gofmt', 'goimports' },
--     }
-- })
--
-- api.nvim_create_autocmd('BufWritePre', {
--   pattern = "*",
--   callback = function(args)
--     require('conform').format({ bufnr = args.buf })
--   end,
-- })

-- require('lint').linters_by_ft = {
--     typescript = { 'eslint_d' },
--     javacript = { 'eslint_d' },
--     typescriptreact = { 'eslint_d' },
--     javascriptreact = { 'eslint_d' },
--     go = { 'golangcilint' }
--[[yaml = { 'yamllint' },
    dockerfile = { 'hadolint' },--]]
-- }

-- keymap.set('n', '<leader>sf', builtin.find_files, {})
-- keymap.set('n', '<leader>sh', builtin.help_tags, {})
-- keymap.set('n', '<leader>sk', builtin.keymaps, {})
-- keymap.set('n', '<leader>ss', builtin.builtin, {})
-- keymap.set('n', '<leader>sw', builtin.grep_string, {})
-- keymap.set('n', '<leader>sg', builtin.live_grep, {})
-- keymap.set('n', '<leader>sd', builtin.diagnostics, {})
-- keymap.set('n', '<leader>si', builtin.git_status, {})
-- keymap.set('n', '<leader>sc', builtin.git_commits, {})
-- keymap.set('n', '<leader>sr', builtin.git_branches, {})
-- keymap.set('n', '<leader>sb', builtin.buffers, {})
-- keymap.set('n', '<leader>s.', builtin.oldfiles, {})
-- keymap.set('n', '<leader>sn', builtin.resume, {})

-- Slightly advanced example of overriding default behavior and theme
-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
--   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

-- -- It's also possible to pass additional configuration options.
-- --  See `:help telescope.builtin.live_grep()` for information about particular keys
-- vim.keymap.set('n', '<leader>s/', function()
--   builtin.live_grep {
--     grep_open_files = true,
--     prompt_title = 'Live Grep in Open Files',
--   }
-- end, { desc = '[S]earch [/] in Open Files' })

-- -- Shortcut for searching your Neovim configuration files
-- vim.keymap.set('n', '<leader>sn', function()
--   builtin.find_files { cwd = vim.fn.stdpath 'config' }
-- end, { desc = '[S]earch [N]eovim files' })

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

local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 60
local height = 20

require('nvim-tree').setup({
  view = {
    width = width,
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        width = width,
        height = height,
        row = (gheight - height) * 0.4,
        col = (gwidth - width) * 0.5,
      }
    }
    -- side = "right"
  }
})

-- require('mini.files').setup({ content = { prefix = function() end } })
-- require('mini.files').setup()

-- minifiles_toggle = function()
--   if not MiniFiles.close() then MiniFiles.open() end
-- end

keymap.set('n', '-', '<cmd>NvimTreeFindFileToggle<CR>', {})

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

-- vim: ts=2 sts=2 sw=2 et
