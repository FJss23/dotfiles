require('catppuccin').setup({
  flavour = "mocha",
  show_end_of_buffer = true,
  color_overrides = {
    all = {
      base = "#111111",
    }
  }
})

vim.cmd.colorscheme "catppuccin"

vim.opt.list = true
vim.opt.listchars = { --[[tab = '» ',--]] trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

require('nvim-treesitter.configs').setup({
  highlight = { enable = true, --[[disable = { "go", "c" }--]] },
  indent = { enable = true },
  endwise = { enable = true },
})
-- }}}

vim.g.skip_ts_context_commentstring_module = true

require('ibl').setup({
  indent = { char = "┊" }
})

require('nvim-highlight-colors').setup {}

require('treesitter-context').setup({
  enable = false,
  separator = "-"
})

vim.keymap.set('n', '<leader>tc', ':TSContextToggle<CR>', { desc = 'Toggle TS Context' })

local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Lsp Config {{{
local function organize_imports()
  vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end

vim.diagnostic.config({
  virtual_text = false,
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
    vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gI', require('fzf-lua').lsp_implementations, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>D', require('fzf-lua').lsp_typedefs, opts)
    -- vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>ds', require('fzf-lua').lsp_document_symbols, opts)

    vim.keymap.set('n', '<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, opts)
    vim.keymap.set('n', '<leader>dw', require('fzf-lua').diagnostics_workspace, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>ca', require('fzf-lua').lsp_code_actions, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, opts)

    vim.keymap.set('n', '<leader>li', require('fzf-lua').lsp_incoming_calls, opts)
    vim.keymap.set('n', '<leader>lo', require('fzf-lua').lsp_outgoing_calls, opts)
  end,
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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

-- local lint_augroup = api.nvim_create_augroup('lint', { clear = true })

-- api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
--     group = lint_augroup,
--     callback = function()
--         require('lint').try_lint()
--     end
-- })

local fzflua = require('fzf-lua')
keymap.set('n', '<leader>sf', fzflua.files, {})
keymap.set('n', '<leader>sg', fzflua.live_grep, {})
keymap.set('n', '<leader>sd', fzflua.diagnostics_document, {})
keymap.set('n', '<leader>si', fzflua.git_status, {})
keymap.set('n', '<leader>sc', fzflua.git_commits, {})
keymap.set('n', '<leader>sr', fzflua.git_branches, {})
keymap.set('n', '<leader>sb', fzflua.buffers, {})

-- require('telescope').load_extension('fzf')
-- require("telescope").load_extension("ui-select")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- require("nvim-tree").setup({
--     view = {
--         side = "right",
--         width = '20%',
--     },
--     renderer = {
--         icons = {
--             show = {
--                 file = false,
--                 folder = false,
--             }
--         }
--     }
-- })

-- keymap.set('n', '<leader>-', ':NvimTreeFindFile<CR>')
require('mini.files').setup({ content = { prefix = function() end } })

local minifiles_toggle = function()
  if not MiniFiles.close() then MiniFiles.open() end
end

keymap.set('n', '-', ':lua MiniFiles.open()<CR>')

--vim.g.skip_ts_context_commentstring_module = true
vim.g.user_emmet_leader_key = 'E'
vim.g.user_emmet_settings = {
  javascript = {
    extends = 'jsx',
  },
  typescript = {
    extends = 'jsx',
  },
}

require('fzf-lua').register_ui_select()

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
  local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local lsp_info = "["
  if count["errors"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticError#E" .. count["errors"] .. "%#StatusLine# "
  end
  if count["warnings"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticWarn#W" .. count["warnings"] .. "%#StatusLine# "
  end
  if count["hints"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticHint#H" .. count["hints"] .. "%#StatusLine# "
  end
  if count["info"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticInfo#I" .. count["info"] .. "%#StatusLine#"
  end
  lsp_info = lsp_info .. "]"

  if lsp_info:len() == 2 then
    lsp_info = ""
  end

  return lsp_info
  -- return "[E" .. count["errors"] .. " W" .. count["warnings"] .. " H" .. count["hints"] .. " I" .. count["info"] .. "]"
end

local function filetype() return "[" .. string.format("%s", vim.bo.filetype) .. "]" end

local function lineinfo()
  if vim.bo.filetype == "alpha" then return "" end
  return " %l:%c %L "
end

local vcs = function()
  local git_info = vim.fn["fugitive#statusline"]()
  if git_info then
    local branch_name = git_info:sub(6, git_info:len() - 2)
    return table.concat { " [git:", branch_name, "] " }
  end
  return ""
end

statusline = {}

statusline.active = function()
  return table.concat {
    "[%n]",
    filepath(),
    filename(),
    "%m%r",
    "%=",
    lsp(),
    vcs(),
    "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }",
    filetype(),
    lineinfo()
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

-- vim: ts=2 sts=2 sw=2 et
